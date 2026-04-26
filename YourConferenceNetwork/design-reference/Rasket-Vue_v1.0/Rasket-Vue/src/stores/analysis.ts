/**
 * Analysis Pinia store.
 * Manages the list of user datasets and the active dataset during detail views.
 */
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import * as api from '@/helpers/api/analysis'
import type { Dataset } from '@/helpers/api/analysis'

export const useAnalysisStore = defineStore('analysis_store', () => {
  // ── State ──────────────────────────────────────────────────────────────────

  const datasets = ref<Dataset[]>([])
  const loading = ref(false)
  const uploading = ref(false)
  const uploadProgress = ref(0)
  const error = ref<string | null>(null)

  // ── Computed ───────────────────────────────────────────────────────────────

  const readyDatasets = computed(() =>
    datasets.value.filter((d) => d.status === 'ready')
  )

  const hasDatasets = computed(() => datasets.value.length > 0)

  // ── Actions ────────────────────────────────────────────────────────────────

  async function fetchDatasets() {
    loading.value = true
    error.value = null
    try {
      const res = await api.listDatasets()
      datasets.value = res.data
    } catch (e: any) {
      error.value = e.response?.data?.detail ?? 'Failed to load datasets.'
    } finally {
      loading.value = false
    }
  }

  async function uploadDataset(name: string, file: File): Promise<Dataset | null> {
    uploading.value = true
    uploadProgress.value = 0
    error.value = null
    const formData = new FormData()
    formData.append('name', name)
    formData.append('uploaded_file', file)
    try {
      const res = await api.createDataset(formData)
      datasets.value.unshift(res.data)
      return res.data
    } catch (e: any) {
      const detail = e.response?.data?.detail ?? e.response?.data?.uploaded_file?.[0]
        ?? 'Upload failed.'
      error.value = detail
      return null
    } finally {
      uploading.value = false
    }
  }

  async function removeDataset(id: number) {
    await api.deleteDataset(id)
    datasets.value = datasets.value.filter((d) => d.id !== id)
  }

  /** Poll until status is 'ready' or 'error'. Returns the final status. */
  async function pollStatus(id: number): Promise<string> {
    return new Promise((resolve) => {
      const interval = setInterval(async () => {
        try {
          const res = await api.getDatasetStatus(id)
          const { status, row_count, unique_orgs, unique_events } = res.data

          // Update in-list dataset
          const idx = datasets.value.findIndex((d) => d.id === id)
          if (idx !== -1) {
            datasets.value[idx] = {
              ...datasets.value[idx],
              status,
              row_count,
              unique_orgs,
              unique_events,
            }
          }

          if (status === 'ready' || status === 'error') {
            clearInterval(interval)
            resolve(status)
          }
        } catch {
          clearInterval(interval)
          resolve('error')
        }
      }, 2000)
    })
  }

  return {
    datasets,
    loading,
    uploading,
    uploadProgress,
    error,
    readyDatasets,
    hasDatasets,
    fetchDatasets,
    uploadDataset,
    removeDataset,
    pollStatus,
  }
})
