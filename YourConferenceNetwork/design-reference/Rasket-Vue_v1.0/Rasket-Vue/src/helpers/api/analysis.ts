/**
 * Analysis API helper — thin wrappers around httpClient for dataset endpoints.
 */
import httpClient from '@/helpers/http-client'

const BASE = '/api/v1'

export interface CategoryMap {
  categories?: string[]
  raw_map?: Record<string, string>
  pass_through?: boolean
}

export interface Dataset {
  id: number
  name: string
  status: 'pending' | 'processing' | 'ready' | 'error'
  error_message: string
  row_count: number | null
  unique_orgs: number | null
  unique_events: number | null
  year_min: number | null
  year_max: number | null
  kumu_token: string
  category_map: CategoryMap | null
  created_at: string
  updated_at: string
}

export interface DatasetStatus {
  status: Dataset['status']
  error_message: string
  row_count: number | null
  unique_orgs: number | null
  unique_events: number | null
}

export interface DashboardData {
  row_count: number | null
  unique_orgs: number | null
  unique_events: number | null
  year_min: number | null
  year_max: number | null
  sectors: string[]
}

export interface ChartData {
  categories: string[]
  series: { name: string; data: number[]; color: string }[]
  available_years: number[]
  available_states: string[]
  canonical_categories: string[]
}

export interface SearchResult {
  organization: string
  sna_category: string
  conferences: string[]
  event_count: number
}

// ── Dataset CRUD ───────────────────────────────────────────────────────────

export const listDatasets = () =>
  httpClient.get<Dataset[]>(`${BASE}/datasets/`)

export const createDataset = (formData: FormData) =>
  httpClient.post<Dataset>(`${BASE}/datasets/`, formData, {
    headers: { 'Content-Type': 'multipart/form-data' },
  })

export const getDataset = (id: number) =>
  httpClient.get<Dataset>(`${BASE}/datasets/${id}/`)

export const updateDataset = (id: number, data: Partial<Pick<Dataset, 'name' | 'category_map'>>) =>
  httpClient.patch<Dataset>(`${BASE}/datasets/${id}/`, data)

export const deleteDataset = (id: number) =>
  httpClient.delete(`${BASE}/datasets/${id}/`)

export const getDatasetStatus = (id: number) =>
  httpClient.get<DatasetStatus>(`${BASE}/datasets/${id}/status/`)

// ── Analysis ───────────────────────────────────────────────────────────────

export const getDashboard = (id: number) =>
  httpClient.get<DashboardData>(`${BASE}/datasets/${id}/dashboard/`)

export const getChart = (id: number, params?: Record<string, string>) =>
  httpClient.get<ChartData>(`${BASE}/datasets/${id}/chart/`, { params })

export const getDataQuality = (id: number) =>
  httpClient.get(`${BASE}/datasets/${id}/data-quality/`)

export const searchOrgs = (id: number, q: string) =>
  httpClient.get<{ results: SearchResult[] }>(`${BASE}/datasets/${id}/search/`, { params: { q } })

// ── Networks (paid) ────────────────────────────────────────────────────────

export const getNetworkOrgEvent = (id: number, params?: Record<string, string>) =>
  httpClient.get(`${BASE}/datasets/${id}/networks/org-event/`, { params })

export const getNetworkOrgOrg = (id: number, params?: Record<string, string>) =>
  httpClient.get(`${BASE}/datasets/${id}/networks/org-org/`, { params })

export const getNetworkThreeLayer = (id: number, params?: Record<string, string>) =>
  httpClient.get(`${BASE}/datasets/${id}/networks/three-layer/`, { params })

// ── Exports (paid) ─────────────────────────────────────────────────────────

export const exportUrl = (id: number, type: string) =>
  `/api/v1/datasets/${id}/exports/${type}/`

// ── Template download (public) ─────────────────────────────────────────────

export const templateDownloadUrl = () => `/api/v1/datasets/template/`
