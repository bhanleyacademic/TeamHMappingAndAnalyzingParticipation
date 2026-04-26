<template>
  <VerticalLayout>
    <b-row class="mb-3 align-items-center">
      <b-col>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-1">
            <li class="breadcrumb-item">
              <router-link :to="{ name: 'analysis.datasets' }">Datasets</router-link>
            </li>
            <li class="breadcrumb-item">
              <router-link :to="{ name: 'analysis.overview', params: { id } }">Dataset</router-link>
            </li>
            <li class="breadcrumb-item active">Networks</li>
          </ol>
        </nav>
        <h4 class="mb-0">Network Maps</h4>
        <p class="text-muted mb-0 small">Download Kumu.io blueprint JSON for three network models.</p>
      </b-col>
    </b-row>

    <!-- Paywall gate / content -->
    <div v-if="paywalled" class="alert alert-warning d-flex align-items-center gap-3" role="alert">
      <i class="bx bx-lock-alt fs-3"></i>
      <div>
        <strong>Paid feature</strong> — Network maps are available on Starter and Pro plans.
        <router-link :to="{ name: 'billing.plans' }" class="ms-2 alert-link">Upgrade now</router-link>
      </div>
    </div>

    <template v-else>

    <!-- Export Options Panel -->
    <b-card class="mb-3">
      <div class="d-flex align-items-center justify-content-between">
        <h6 class="mb-0"><i class="bx bx-slider me-2 text-secondary"></i>Export Options</h6>
        <button class="btn btn-sm btn-outline-secondary" @click="showOptions = !showOptions">
          {{ showOptions ? 'Hide Options' : 'Show Options' }}
        </button>
      </div>

      <div v-if="showOptions" class="mt-3">
        <!-- Org ↔ Event options -->
        <div class="mb-4">
          <p class="fw-semibold small mb-2 text-primary">
            <i class="bx bx-git-branch me-1"></i>Org ↔ Event (Bipartite)
          </p>
          <div class="row g-2">
            <div class="col-sm-6 col-md-4">
              <label class="form-label small mb-1">Min. events per org</label>
              <input
                v-model.number="options.orgEvent.min_events"
                type="number" min="1" max="50"
                class="form-control form-control-sm"
              />
              <div class="form-text">Orgs attending fewer events are hidden (default: 3)</div>
            </div>
            <div class="col-sm-6 col-md-4">
              <label class="form-label small mb-1">Min. orgs per event</label>
              <input
                v-model.number="options.orgEvent.min_orgs"
                type="number" min="1" max="200"
                class="form-control form-control-sm"
              />
              <div class="form-text">Events with fewer orgs are hidden (default: 10)</div>
            </div>
          </div>
        </div>

        <!-- Org ↔ Org options -->
        <div class="mb-4">
          <p class="fw-semibold small mb-2 text-success">
            <i class="bx bx-share-alt me-1"></i>Org ↔ Org (Co-attendance)
          </p>
          <div class="row g-2">
            <div class="col-sm-6 col-md-4">
              <label class="form-label small mb-1">Min. events per org</label>
              <input
                v-model.number="options.orgOrg.min_events"
                type="number" min="1" max="50"
                class="form-control form-control-sm"
              />
              <div class="form-text">Orgs with fewer events are excluded (default: 2)</div>
            </div>
            <div class="col-sm-6 col-md-4">
              <label class="form-label small mb-1">Min. shared events (edge weight)</label>
              <input
                v-model.number="options.orgOrg.min_weight"
                type="number" min="1" max="50"
                class="form-control form-control-sm"
              />
              <div class="form-text">Pairs sharing fewer events have no edge (default: 3)</div>
            </div>
          </div>
        </div>

        <!-- Three-Layer options -->
        <div class="mb-2">
          <p class="fw-semibold small mb-2 text-warning">
            <i class="bx bx-network-chart me-1"></i>Three-Layer (Event → Sector → Org)
          </p>
          <div class="row g-2">
            <div class="col-sm-6 col-md-3">
              <label class="form-label small mb-1">Year from</label>
              <input
                v-model.number="options.threeLayer.year_min"
                type="number" min="1980" max="2100"
                class="form-control form-control-sm"
              />
            </div>
            <div class="col-sm-6 col-md-3">
              <label class="form-label small mb-1">Year to</label>
              <input
                v-model.number="options.threeLayer.year_max"
                type="number" min="1980" max="2100"
                class="form-control form-control-sm"
              />
            </div>
            <div class="col-sm-6 col-md-3">
              <label class="form-label small mb-1">Min. events per org</label>
              <input
                v-model.number="options.threeLayer.min_events"
                type="number" min="1" max="50"
                class="form-control form-control-sm"
              />
              <div class="form-text">Within the year window (default: 4)</div>
            </div>
          </div>
        </div>

        <button class="btn btn-sm btn-link text-muted p-0 mt-2" @click="resetOptions">
          Reset to defaults
        </button>
      </div>
    </b-card>

    <!-- Network cards -->
    <b-row>
      <!-- Org ↔ Event (bipartite) -->
      <b-col md="12" class="mb-4">
        <b-card>
          <div class="d-flex align-items-start justify-content-between flex-wrap gap-3">
            <div>
              <h5 class="mb-1">
                <i class="bx bx-git-branch me-2 text-primary"></i>Org ↔ Event (Bipartite)
              </h5>
              <p class="text-muted small mb-0">
                Two-layer graph: organization nodes connected to the conference events they attended.
                Best for exploring which orgs appeared at which events.
              </p>
            </div>
            <button
              class="btn btn-outline-primary"
              :disabled="loading.orgEvent"
              @click="downloadNetwork('orgEvent')"
            >
              <b-spinner v-if="loading.orgEvent" small class="me-1" />
              <i v-else class="bx bx-download me-1"></i>
              Download Kumu JSON
            </button>
          </div>
          <div v-if="stats.orgEvent" class="mt-3 d-flex gap-4 text-muted small">
            <span><strong>{{ stats.orgEvent.elements }}</strong> nodes</span>
            <span><strong>{{ stats.orgEvent.connections }}</strong> connections</span>
          </div>
        </b-card>
      </b-col>

      <!-- Org ↔ Org (co-attendance) -->
      <b-col md="12" class="mb-4">
        <b-card>
          <div class="d-flex align-items-start justify-content-between flex-wrap gap-3">
            <div>
              <h5 class="mb-1">
                <i class="bx bx-share-alt me-2 text-success"></i>Org ↔ Org (Co-attendance)
              </h5>
              <p class="text-muted small mb-0">
                Orgs connected when they attended the same conference event.
                Edge weight = number of shared events. Adjust "Min. shared events" in options to control density.
              </p>
            </div>
            <button
              class="btn btn-outline-success"
              :disabled="loading.orgOrg"
              @click="downloadNetwork('orgOrg')"
            >
              <b-spinner v-if="loading.orgOrg" small class="me-1" />
              <i v-else class="bx bx-download me-1"></i>
              Download Kumu JSON
            </button>
          </div>
          <div v-if="stats.orgOrg" class="mt-3 d-flex gap-4 text-muted small">
            <span><strong>{{ stats.orgOrg.elements }}</strong> nodes</span>
            <span><strong>{{ stats.orgOrg.connections }}</strong> connections</span>
          </div>
        </b-card>
      </b-col>

      <!-- Three-layer -->
      <b-col md="12" class="mb-4">
        <b-card>
          <div class="d-flex align-items-start justify-content-between flex-wrap gap-3">
            <div>
              <h5 class="mb-1">
                <i class="bx bx-network-chart me-2 text-warning"></i>Three-Layer (Event → Sector → Org)
              </h5>
              <p class="text-muted small mb-0">
                Hierarchical graph: conference events link to sector nodes, which link to org nodes.
                Reveals the sector composition of each conference at a glance.
              </p>
            </div>
            <button
              class="btn btn-outline-warning"
              :disabled="loading.threeLayer"
              @click="downloadNetwork('threeLayer')"
            >
              <b-spinner v-if="loading.threeLayer" small class="me-1" />
              <i v-else class="bx bx-download me-1"></i>
              Download Kumu JSON
            </button>
          </div>
          <div v-if="stats.threeLayer" class="mt-3 d-flex gap-4 text-muted small">
            <span><strong>{{ stats.threeLayer.elements }}</strong> nodes</span>
            <span><strong>{{ stats.threeLayer.connections }}</strong> connections</span>
          </div>
        </b-card>
      </b-col>
    </b-row>

    <!-- Kumu.io remote URL section -->
    <b-card class="mb-3">
      <h6 class="mb-1"><i class="bx bx-link-alt me-2 text-primary"></i>Kumu Remote Source URLs</h6>
      <p class="text-muted small mb-3">
        Paste one of these URLs directly into Kumu's <strong>New Map → JSON → Remote URL</strong> field.
        The URL is unique to this dataset — share it with collaborators or save it in Kumu for live updates.
      </p>
      <div v-if="kumuToken" class="d-flex flex-column gap-2">
        <div v-for="net in kumuNetworks" :key="net.type" class="d-flex align-items-center gap-2">
          <span class="badge bg-secondary text-nowrap" style="min-width:140px">{{ net.label }}</span>
          <code class="flex-grow-1 small text-break bg-light rounded px-2 py-1">{{ kumuUrl(net.type) }}</code>
          <button class="btn btn-sm btn-outline-secondary text-nowrap" @click="copyUrl(net.type)">
            <i class="bx bx-copy me-1"></i>{{ copied === net.type ? 'Copied!' : 'Copy' }}
          </button>
        </div>
      </div>
      <div v-else class="text-muted small">Loading dataset info…</div>
    </b-card>

    <!-- Kumu.io tip -->
    <b-card class="bg-light border-0">
      <div class="d-flex align-items-start gap-3">
        <i class="bx bx-info-circle fs-4 text-info mt-1"></i>
        <div class="small">
          <strong>Two ways to load in Kumu.io</strong><br>
          <strong>1. Remote URL (recommended):</strong> Copy a URL above → in Kumu choose
          <strong>New Map → JSON → Remote URL</strong> and paste it. Kumu will auto-refresh when your data changes.<br>
          <strong>2. File import:</strong> Click "Download Kumu JSON" → in Kumu choose
          <strong>New Map → JSON → Import file</strong> and drag in the downloaded file.
        </div>
      </div>
    </b-card>
    </template><!-- end v-else (not paywalled) -->
  </VerticalLayout>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import VerticalLayout from '@/layouts/VerticalLayout.vue'
import * as api from '@/helpers/api/analysis'
import { getDataset } from '@/helpers/api/analysis'

const route = useRoute()
const id = Number(route.params.id)

const paywalled = ref(false)
const loading = reactive({ orgEvent: false, orgOrg: false, threeLayer: false })
const showOptions = ref(false)

const options = reactive({
  orgEvent:   { min_events: 3,  min_orgs: 10 },
  orgOrg:     { min_events: 2,  min_weight: 3 },
  threeLayer: { year_min: 2004, year_max: 2010, min_events: 4 },
})

const resetOptions = () => {
  options.orgEvent   = { min_events: 3,  min_orgs: 10 }
  options.orgOrg     = { min_events: 2,  min_weight: 3 }
  options.threeLayer = { year_min: datasetYearMin.value, year_max: datasetYearMax.value, min_events: 4 }
}

const datasetYearMin = ref(2004)
const datasetYearMax = ref(2010)

const kumuToken = ref('')
const copied = ref('')

const kumuNetworks = [
  { type: 'org-event',    label: 'Org ↔ Event' },
  { type: 'org-org',      label: 'Org ↔ Org' },
  { type: 'three-layer',  label: 'Three-Layer' },
]

const kumuUrl = (type: string) =>
  `${window.location.origin}/api/v1/kumu/${kumuToken.value}/${type}/`

const copyUrl = async (type: string) => {
  await navigator.clipboard.writeText(kumuUrl(type))
  copied.value = type
  setTimeout(() => { copied.value = '' }, 2000)
}

const stats = reactive<{
  orgEvent:   { elements: number; connections: number } | null
  orgOrg:     { elements: number; connections: number } | null
  threeLayer: { elements: number; connections: number } | null
}>({ orgEvent: null, orgOrg: null, threeLayer: null })

const buildParams = (type: 'orgEvent' | 'orgOrg' | 'threeLayer'): Record<string, string> => {
  if (type === 'orgEvent') return {
    min_events: String(options.orgEvent.min_events),
    min_orgs:   String(options.orgEvent.min_orgs),
  }
  if (type === 'orgOrg') return {
    min_events: String(options.orgOrg.min_events),
    min_weight: String(options.orgOrg.min_weight),
  }
  return {
    year_min:   String(options.threeLayer.year_min),
    year_max:   String(options.threeLayer.year_max),
    min_events: String(options.threeLayer.min_events),
  }
}

const downloadNetwork = async (type: 'orgEvent' | 'orgOrg' | 'threeLayer') => {
  loading[type] = true
  try {
    let res: { data: object }
    let filename: string
    if (type === 'orgEvent') {
      res = await api.getNetworkOrgEvent(id, buildParams('orgEvent'))
      filename = `network-org-event-${id}.json`
    } else if (type === 'orgOrg') {
      res = await api.getNetworkOrgOrg(id, buildParams('orgOrg'))
      filename = `network-org-org-${id}.json`
    } else {
      res = await api.getNetworkThreeLayer(id, buildParams('threeLayer'))
      filename = `network-three-layer-${id}.json`
    }
    const data = res.data as { elements: unknown[]; connections: unknown[] }
    stats[type] = { elements: data.elements.length, connections: data.connections.length }
    triggerDownload(JSON.stringify(data, null, 2), filename, 'application/json')
  } catch (e: any) {
    if (e.response?.status === 403) paywalled.value = true
  } finally {
    loading[type] = false
  }
}

const triggerDownload = (content: string, filename: string, mime: string) => {
  const blob = new Blob([content], { type: mime })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = filename
  a.click()
  URL.revokeObjectURL(url)
}

onMounted(async () => {
  const [datasetRes] = await Promise.allSettled([getDataset(id)])
  if (datasetRes.status === 'fulfilled') {
    const ds = datasetRes.value.data
    kumuToken.value = ds.kumu_token
    if (ds.year_min) {
      datasetYearMin.value = ds.year_min
      options.threeLayer.year_min = ds.year_min
    }
    if (ds.year_max) {
      datasetYearMax.value = ds.year_max
      options.threeLayer.year_max = ds.year_max
    }
  }
})
</script>
