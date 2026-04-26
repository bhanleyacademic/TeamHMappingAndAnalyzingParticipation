/**
 * Auth store — replaces Rasket's session-storage-based fake auth.
 *
 * Stores accessToken + refreshToken in sessionStorage under 'YCN_SESSION'.
 * Decodes the JWT payload to check expiry and detect impersonation.
 */
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import router from '@/router'
import type { User, AuthSession } from '@/types/auth'

const SESSION_KEY = 'YCN_SESSION'

function _decodePayload(token: string): Record<string, unknown> | null {
  try {
    const part = token.split('.')[1]
    return JSON.parse(atob(part.replace(/-/g, '+').replace(/_/g, '/')))
  } catch {
    return null
  }
}

function _isExpired(token: string): boolean {
  const payload = _decodePayload(token)
  if (!payload?.exp) return true
  return (payload.exp as number) < Date.now() / 1000
}

export const useAuthStore = defineStore('auth_store', () => {
  const _session = ref<AuthSession | null>(
    (() => {
      try {
        const raw = sessionStorage.getItem(SESSION_KEY)
        return raw ? JSON.parse(raw) : null
      } catch {
        return null
      }
    })()
  )

  // ── Computed ──────────────────────────────────────────────────────────────

  const user = computed<User | null>(() => _session.value?.user ?? null)

  const accessToken = computed<string | null>(() => _session.value?.accessToken ?? null)

  const isAuthenticated = computed<boolean>(() => {
    if (!_session.value?.accessToken) return false
    return !_isExpired(_session.value.accessToken)
  })

  /** True when an admin is impersonating this session */
  const isImpersonating = computed<boolean>(
    () => !!_session.value?.impersonatorId
  )

  const impersonatorEmail = computed<string | undefined>(
    () => _session.value?.impersonatorEmail
  )

  // ── Actions ───────────────────────────────────────────────────────────────

  function saveSession(data: {
    access: string
    refresh: string
    user: User
  }) {
    const payload = _decodePayload(data.access)
    const session: AuthSession = {
      user: data.user,
      accessToken: data.access,
      refreshToken: data.refresh,
      impersonatorId: payload?.impersonator_id as number | undefined,
      impersonatorEmail: payload?.impersonator_email as string | undefined,
    }
    _session.value = session
    sessionStorage.setItem(SESSION_KEY, JSON.stringify(session))
  }

  function removeSession() {
    _session.value = null
    sessionStorage.removeItem(SESSION_KEY)
    router.push('/auth/sign-in')
  }

  /** Call after impersonate/stop to restore admin tokens */
  function restoreAdminSession(data: { access: string; refresh: string; user: User }) {
    saveSession(data)
  }

  return {
    user,
    accessToken,
    isAuthenticated,
    isImpersonating,
    impersonatorEmail,
    saveSession,
    removeSession,
    restoreAdminSession,
  }
})
