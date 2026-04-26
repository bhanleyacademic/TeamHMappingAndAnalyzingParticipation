/**
 * Axios instance configured for the YourConferenceNetwork Django REST API.
 *
 * - Base URL from VITE_API_BASE_URL env variable (defaults to http://localhost:8000)
 * - Request interceptor: attaches Authorization: Bearer <accessToken>
 * - Response interceptor: on 401, attempts silent token refresh; logs out on failure
 */
import axios, { type AxiosInstance } from 'axios'

const BASE_URL = import.meta.env.VITE_API_BASE_URL ?? 'http://localhost:8000'

const httpClient: AxiosInstance = axios.create({
  baseURL: BASE_URL,
  headers: { 'Content-Type': 'application/json' },
})

// ── Request interceptor ─────────────────────────────────────────────────────
httpClient.interceptors.request.use((config) => {
  const raw = sessionStorage.getItem('YCN_SESSION')
  if (raw) {
    try {
      const session = JSON.parse(raw)
      if (session?.accessToken) {
        config.headers.Authorization = `Bearer ${session.accessToken}`
      }
    } catch {
      // malformed session — ignore
    }
  }
  return config
})

// ── Response interceptor ────────────────────────────────────────────────────
let _refreshing = false
let _refreshQueue: Array<(token: string) => void> = []

httpClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    const original = error.config

    if (error.response?.status !== 401 || original._retry) {
      return Promise.reject(error)
    }

    if (_refreshing) {
      // Queue requests while a refresh is in progress
      return new Promise((resolve) => {
        _refreshQueue.push((token: string) => {
          original.headers.Authorization = `Bearer ${token}`
          resolve(httpClient(original))
        })
      })
    }

    original._retry = true
    _refreshing = true

    try {
      const raw = sessionStorage.getItem('YCN_SESSION')
      const session = raw ? JSON.parse(raw) : null
      if (!session?.refreshToken) throw new Error('No refresh token')

      const resp = await axios.post(`${BASE_URL}/api/v1/auth/token/refresh/`, {
        refresh: session.refreshToken,
      })
      const { access } = resp.data

      // Update session in storage
      session.accessToken = access
      sessionStorage.setItem('YCN_SESSION', JSON.stringify(session))

      // Flush queued requests
      _refreshQueue.forEach((cb) => cb(access))
      _refreshQueue = []

      original.headers.Authorization = `Bearer ${access}`
      return httpClient(original)
    } catch {
      // Refresh failed — log the user out
      sessionStorage.removeItem('YCN_SESSION')
      _refreshQueue = []
      window.location.href = '/app/auth/sign-in'
      return Promise.reject(error)
    } finally {
      _refreshing = false
    }
  }
)

export default httpClient
