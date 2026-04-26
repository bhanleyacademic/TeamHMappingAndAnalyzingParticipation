<template>
  <VerticalLayout>
    <!-- Loading -->
    <div v-if="loading" class="text-center py-5"><b-spinner variant="primary" /></div>

    <!-- Not ready -->
    <b-alert v-else-if="dataset && dataset.status !== 'ready'" variant="warning" show>
      Dataset is {{ dataset.status }}. Come back when processing is complete.
    </b-alert>

    <template v-else-if="dataset">
      <!-- Header -->
      <b-row class="mb-4 align-items-center">
        <b-col>
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-1">
              <li class="breadcrumb-item">
                <router-link :to="{ name: 'analysis.datasets' }">Datasets</router-link>
              </li>
              <li class="breadcrumb-item active">{{ dataset.name }}</li>
            </ol>
          </nav>
          <h4 class="mb-0">{{ dataset.name }}</h4>
          <p class="text-muted mb-0 small">
            {{ dataset.year_min }}–{{ dataset.year_max }} ·
            Uploaded {{ formatDate(dataset.created_at) }}
          </p>
        </b-col>
        <b-col cols="auto" class="d-flex gap-2">
          <router-link :to="{ name: 'analysis.chart', params: { id } }" class="btn btn-outline-primary btn-sm">
            <i class="bx bx-bar-chart-alt-2 me-1"></i> Chart
          </router-link>
          <router-link :to="{ name: 'analysis.networks', params: { id } }" class="btn btn-outline-primary btn-sm">
            <i class="bx bx-network-chart me-1"></i> Networks
          </router-link>
          <router-link :to="{ name: 'analysis.exports', params: { id } }" class="btn btn-outline-secondary btn-sm">
            <i class="bx bx-download me-1"></i> Exports
          </router-link>
        </b-col>
      </b-row>

      <!-- KPI cards -->
      <b-row class="mb-4">
        <b-col md="6" xl="3" class="mb-3">
          <b-card class="text-center h-100">
            <h2 class="mb-0 text-primary">{{ (dashboard?.row_count ?? 0).toLocaleString() }}</h2>
            <p class="text-muted mb-0 small mt-1">Total Records</p>
          </b-card>
        </b-col>
        <b-col md="6" xl="3" class="mb-3">
          <b-card class="text-center h-100">
            <h2 class="mb-0 text-success">{{ (dashboard?.unique_orgs ?? 0).toLocaleString() }}</h2>
            <p class="text-muted mb-0 small mt-1">Unique Organizations</p>
          </b-card>
        </b-col>
        <b-col md="6" xl="3" class="mb-3">
          <b-card class="text-center h-100">
            <h2 class="mb-0 text-warning">{{ dashboard?.unique_events ?? 0 }}</h2>
            <p class="text-muted mb-0 small mt-1">Conference Events</p>
          </b-card>
        </b-col>
        <b-col md="6" xl="3" class="mb-3">
          <b-card class="text-center h-100">
            <h2 class="mb-0 text-info">{{ dashboard?.year_min }} – {{ dashboard?.year_max }}</h2>
            <p class="text-muted mb-0 small mt-1">Year Range</p>
          </b-card>
        </b-col>
      </b-row>

      <!-- Sectors + Search -->
      <b-row>
        <b-col xl="4" class="mb-4">
          <b-card header="Sectors in this dataset">
            <div class="d-flex flex-wrap gap-2 mt-1">
              <b-badge
                v-for="sector in dashboard?.sectors"
                :key="sector"
                variant="secondary"
                class="px-2 py-1 fs-6"
              >
                {{ sector }}
              </b-badge>
            </div>
          </b-card>
        </b-col>

        <b-col xl="8" class="mb-4">
          <b-card header="Search Organizations">
            <div class="d-flex gap-2 mb-3">
              <b-form-input
                v-model="searchQuery"
                placeholder="Type an organization name…"
                @keyup.enter="doSearch"
              />
              <button class="btn btn-primary" @click="doSearch">Search</button>
            </div>

            <div v-if="searchLoading" class="text-center py-3">
              <b-spinner small variant="primary" />
            </div>

            <div v-else-if="searchResults.length">
              <div
                v-for="result in searchResults"
                :key="result.organization"
                class="border-bottom pb-2 mb-2"
              >
                <div class="d-flex justify-content-between align-items-start">
                  <div>
                    <strong>{{ result.organization }}</strong>
                    <b-badge variant="secondary" class="ms-2 small">{{ result.sna_category }}</b-badge>
                  </div>
                  <span class="text-muted small">{{ result.event_count }} events</span>
                </div>
                <div class="text-muted small mt-1">
                  {{ result.conferences.join(' · ') }}
                </div>
              </div>
            </div>

            <p v-else-if="searchDone" class="text-muted small mb-0">No results for "{{ searchQuery }}".</p>
            <p v-else class="text-muted small mb-0">Search by organization name above.</p>
          </b-card>
        </b-col>
      </b-row>

      <!-- Quick links -->
      <b-row>
        <b-col md="4" class="mb-3">
          <b-card class="h-100 hover-card" @click="$router.push({ name: 'analysis.chart', params: { id } })">
            <div class="d-flex align-items-center gap-3">
              <i class="bx bx-bar-chart-alt-2 fs-2 text-primary"></i>
              <div>
                <h6 class="mb-0">Participation Chart</h6>
                <p class="text-muted small mb-0">Attendance by sector over time</p>
              </div>
            </div>
          </b-card>
        </b-col>
        <b-col md="4" class="mb-3">
          <b-card class="h-100 hover-card" @click="$router.push({ name: 'analysis.networks', params: { id } })">
            <div class="d-flex align-items-center gap-3">
              <i class="bx bx-network-chart fs-2 text-success"></i>
              <div>
                <h6 class="mb-0">Network Maps</h6>
                <p class="text-muted small mb-0">Kumu blueprints &amp; org graphs</p>
              </div>
            </div>
          </b-card>
        </b-col>
        <b-col md="4" class="mb-3">
          <b-card class="h-100 hover-card" @click="$router.push({ name: 'analysis.exports', params: { id } })">
            <div class="d-flex align-items-center gap-3">
              <i class="bx bx-download fs-2 text-warning"></i>
              <div>
                <h6 class="mb-0">Export Data</h6>
                <p class="text-muted small mb-0">CSV nodes/edges &amp; Kumu JSON</p>
              </div>
            </div>
          </b-card>
        </b-col>
      </b-row>
    </template>
  </VerticalLayout>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import VerticalLayout from '@/layouts/VerticalLayout.vue'
import * as api from '@/helpers/api/analysis'
import type { Dataset, DashboardData, SearchResult } from '@/helpers/api/analysis'

const route = useRoute()
const id = Number(route.params.id)

const loading = ref(true)
const dataset = ref<Dataset | null>(null)
const dashboard = ref<DashboardData | null>(null)

const searchQuery = ref('')
const searchResults = ref<SearchResult[]>([])
const searchLoading = ref(false)
const searchDone = ref(false)

onMounted(async () => {
  try {
    const [dsRes, dbRes] = await Promise.all([
      api.getDataset(id),
      api.getDashboard(id),
    ])
    dataset.value = dsRes.data
    dashboard.value = dbRes.data
  } finally {
    loading.value = false
  }
})

const doSearch = async () => {
  if (!searchQuery.value.trim()) return
  searchLoading.value = true
  searchDone.value = false
  try {
    const res = await api.searchOrgs(id, searchQuery.value)
    searchResults.value = res.data.results
  } finally {
    searchLoading.value = false
    searchDone.value = true
  }
}

const formatDate = (iso: string) =>
  new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
</script>

<style scoped>
.hover-card {
  cursor: pointer;
  transition: box-shadow 0.15s;
}
.hover-card:hover {
  box-shadow: 0 4px 16px rgba(0,0,0,0.1);
}
</style>
