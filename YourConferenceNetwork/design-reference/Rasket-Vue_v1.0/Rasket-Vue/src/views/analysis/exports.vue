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
            <li class="breadcrumb-item active">Exports</li>
          </ol>
        </nav>
        <h4 class="mb-0">Export Data</h4>
        <p class="text-muted mb-0 small">Download CSV files for Gephi, PowerBI, or your own analysis.</p>
      </b-col>
    </b-row>

    <!-- Paywall gate -->
    <b-alert v-if="paywalled" variant="warning" show class="d-flex align-items-center gap-3">
      <i class="bx bx-lock-alt fs-3"></i>
      <div>
        <strong>Paid feature</strong> — CSV exports are available on Starter and Pro plans.
        <router-link :to="{ name: 'billing.plans' }" class="ms-2 alert-link">Upgrade now</router-link>
      </div>
    </b-alert>

    <b-row v-if="!paywalled">
      <!-- Nodes -->
      <b-col md="6" class="mb-4">
        <b-card class="h-100">
          <h5 class="mb-1">
            <i class="bx bx-circle me-2 text-primary"></i>Nodes CSV
          </h5>
          <p class="text-muted small">
            One row per unique organization. Includes canonical SNA sector, website,
            and total event count. Use as the nodes table in Gephi or PowerBI.
          </p>
          <div class="font-monospace small bg-light rounded p-2 mb-3 text-muted">
            Id, Label, SNA_Category, Website, Event_Count, Record_Count
          </div>
          <button class="btn btn-outline-primary" :disabled="loading.nodes" @click="download('nodes')">
            <b-spinner v-if="loading.nodes" small class="me-1" />
            <i v-else class="bx bx-download me-1"></i>
            Download nodes.csv
          </button>
        </b-card>
      </b-col>

      <!-- Edges: Org–Event -->
      <b-col md="6" class="mb-4">
        <b-card class="h-100">
          <h5 class="mb-1">
            <i class="bx bx-git-branch me-2 text-success"></i>Edges CSV — Org ↔ Event
          </h5>
          <p class="text-muted small">
            One row per attendance record. Source = organization, Target = conference event.
            Bipartite edge list for Gephi's bipartite projection or Kumu import.
          </p>
          <div class="font-monospace small bg-light rounded p-2 mb-3 text-muted">
            source, target, year, month, state
          </div>
          <button class="btn btn-outline-success" :disabled="loading.edgesOrgEvent" @click="download('edgesOrgEvent')">
            <b-spinner v-if="loading.edgesOrgEvent" small class="me-1" />
            <i v-else class="bx bx-download me-1"></i>
            Download edges-org-event.csv
          </button>
        </b-card>
      </b-col>

      <!-- Edges: Org–Org -->
      <b-col md="6" class="mb-4">
        <b-card class="h-100">
          <h5 class="mb-1">
            <i class="bx bx-share-alt me-2 text-warning"></i>Edges CSV — Org ↔ Org
          </h5>
          <p class="text-muted small">
            One row per pair of organizations that appeared at the same event.
            Edge weight = number of shared conference events. Use for co-attendance analysis.
          </p>
          <div class="font-monospace small bg-light rounded p-2 mb-3 text-muted">
            source, target, weight
          </div>
          <button class="btn btn-outline-warning" :disabled="loading.edgesOrgOrg" @click="download('edgesOrgOrg')">
            <b-spinner v-if="loading.edgesOrgOrg" small class="me-1" />
            <i v-else class="bx bx-download me-1"></i>
            Download edges-org-org.csv
          </button>
        </b-card>
      </b-col>

      <!-- Edges: Event–Sector–Org -->
      <b-col md="6" class="mb-4">
        <b-card class="h-100">
          <h5 class="mb-1">
            <i class="bx bx-network-chart me-2 text-info"></i>Edges CSV — Event → Sector → Org
          </h5>
          <p class="text-muted small">
            Three-layer edge list: Event → Sector and Sector → Org rows combined.
            Use with Gephi's multilayer layout or import directly into Kumu.
          </p>
          <div class="font-monospace small bg-light rounded p-2 mb-3 text-muted">
            source, target, layer, weight
          </div>
          <button class="btn btn-outline-info" :disabled="loading.edgesEventSectorOrg" @click="download('edgesEventSectorOrg')">
            <b-spinner v-if="loading.edgesEventSectorOrg" small class="me-1" />
            <i v-else class="bx bx-download me-1"></i>
            Download edges-event-sector-org.csv
          </button>
        </b-card>
      </b-col>
    </b-row>

    <!-- Tool tips -->
    <b-card v-if="!paywalled" class="bg-light border-0 mt-2">
      <h6 class="mb-3">Using these files</h6>
      <b-row class="g-3">
        <b-col md="4">
          <div class="d-flex gap-2 align-items-start small">
            <i class="bx bx-table text-primary fs-5 mt-1"></i>
            <div>
              <strong>PowerBI / Excel</strong><br>
              Load nodes.csv as a lookup table. Load any edges file as a relationship table.
            </div>
          </div>
        </b-col>
        <b-col md="4">
          <div class="d-flex gap-2 align-items-start small">
            <i class="bx bx-scatter-chart text-success fs-5 mt-1"></i>
            <div>
              <strong>Gephi</strong><br>
              Import nodes.csv on the Nodes tab, then any edges CSV on the Edges tab.
              Use "weight" for edge thickness.
            </div>
          </div>
        </b-col>
        <b-col md="4">
          <div class="d-flex gap-2 align-items-start small">
            <i class="bx bx-network-chart text-warning fs-5 mt-1"></i>
            <div>
              <strong>Kumu.io</strong><br>
              Use the Network Maps tab for pre-formatted Kumu JSON blueprints instead.
            </div>
          </div>
        </b-col>
      </b-row>
    </b-card>

    <!-- Error toast area -->
    <b-alert v-if="downloadError" variant="danger" show dismissible class="mt-3" @dismissed="downloadError = ''">
      {{ downloadError }}
    </b-alert>
  </VerticalLayout>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRoute } from 'vue-router'
import VerticalLayout from '@/layouts/VerticalLayout.vue'
import { exportUrl } from '@/helpers/api/analysis'
import httpClient from '@/helpers/http-client'

const route = useRoute()
const id = Number(route.params.id)

const paywalled = ref(false)
const downloadError = ref('')

const loading = reactive({
  nodes: false,
  edgesOrgEvent: false,
  edgesOrgOrg: false,
  edgesEventSectorOrg: false,
})

type ExportType = keyof typeof loading

const endpointMap: Record<ExportType, string> = {
  nodes: exportUrl(id, 'nodes'),
  edgesOrgEvent: exportUrl(id, 'edges/org-event'),
  edgesOrgOrg: exportUrl(id, 'edges/org-org'),
  edgesEventSectorOrg: exportUrl(id, 'edges/event-sector-org'),
}

const filenameMap: Record<ExportType, string> = {
  nodes: `nodes-${id}.csv`,
  edgesOrgEvent: `edges-org-event-${id}.csv`,
  edgesOrgOrg: `edges-org-org-${id}.csv`,
  edgesEventSectorOrg: `edges-event-sector-org-${id}.csv`,
}

const download = async (type: ExportType) => {
  loading[type] = true
  downloadError.value = ''
  try {
    const res = await httpClient.get(endpointMap[type], { responseType: 'blob' })
    const blob = new Blob([res.data as BlobPart], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = filenameMap[type]
    a.click()
    URL.revokeObjectURL(url)
  } catch (e: any) {
    if (e.response?.status === 403) {
      paywalled.value = true
    } else {
      downloadError.value = 'Download failed. Please try again.'
    }
  } finally {
    loading[type] = false
  }
}
</script>
