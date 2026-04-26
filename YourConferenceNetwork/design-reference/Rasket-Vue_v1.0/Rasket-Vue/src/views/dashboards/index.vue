<template>
  <VerticalLayout>
    <!-- Welcome header -->
    <b-row class="mb-4 align-items-center">
      <b-col>
        <h4 class="mb-1">Welcome back, {{ firstName }}</h4>
        <p class="text-muted mb-0">
          Your Conference Network — analyze attendance, map connections, and export for Kumu.io.
        </p>
      </b-col>
      <b-col cols="auto">
        <router-link :to="{ name: 'analysis.upload' }" class="btn btn-primary">
          <i class="bx bx-upload me-1"></i> Upload Dataset
        </router-link>
      </b-col>
    </b-row>

    <!-- KPI cards -->
    <b-row class="mb-4">
      <b-col md="6" xl="3" class="mb-3">
        <b-card class="text-center h-100">
          <h2 class="mb-0 text-primary">{{ store.datasets.length }}</h2>
          <p class="text-muted mb-0 small mt-1">Datasets</p>
        </b-card>
      </b-col>
      <b-col md="6" xl="3" class="mb-3">
        <b-card class="text-center h-100">
          <h2 class="mb-0 text-success">{{ totalRecords.toLocaleString() }}</h2>
          <p class="text-muted mb-0 small mt-1">Total Records</p>
        </b-card>
      </b-col>
      <b-col md="6" xl="3" class="mb-3">
        <b-card class="text-center h-100">
          <h2 class="mb-0 text-warning">{{ totalOrgs.toLocaleString() }}</h2>
          <p class="text-muted mb-0 small mt-1">Unique Organizations</p>
        </b-card>
      </b-col>
      <b-col md="6" xl="3" class="mb-3">
        <b-card class="text-center h-100">
          <h2 class="mb-0 text-info">{{ totalEvents.toLocaleString() }}</h2>
          <p class="text-muted mb-0 small mt-1">Conference Events</p>
        </b-card>
      </b-col>
    </b-row>

    <!-- Recent datasets -->
    <b-row class="mb-4">
      <b-col xl="8" class="mb-4">
        <b-card header="Recent Datasets" no-body>
          <div v-if="store.loading" class="text-center py-4">
            <b-spinner variant="primary" />
          </div>
          <div v-else-if="!store.hasDatasets" class="text-center py-5">
            <i class="bx bx-data fs-1 text-muted"></i>
            <h5 class="mt-3">No datasets yet</h5>
            <p class="text-muted small">Upload a conference attendance CSV to get started.</p>
            <router-link :to="{ name: 'analysis.upload' }" class="btn btn-primary btn-sm mt-1">
              Upload Now
            </router-link>
          </div>
          <b-list-group v-else flush>
            <b-list-group-item
              v-for="ds in recentDatasets"
              :key="ds.id"
              class="d-flex align-items-center justify-content-between"
            >
              <div>
                <router-link
                  v-if="ds.status === 'ready'"
                  :to="{ name: 'analysis.overview', params: { id: ds.id } }"
                  class="fw-semibold text-decoration-none"
                >{{ ds.name }}</router-link>
                <span v-else class="fw-semibold">{{ ds.name }}</span>
                <div class="text-muted small mt-1" v-if="ds.status === 'ready'">
                  {{ ds.row_count?.toLocaleString() }} records ·
                  {{ ds.unique_orgs?.toLocaleString() }} orgs ·
                  {{ ds.unique_events }} events
                </div>
              </div>
              <b-badge :variant="statusVariant(ds.status)">{{ ds.status }}</b-badge>
            </b-list-group-item>
          </b-list-group>
          <div v-if="store.datasets.length > 5" class="p-3 text-center">
            <router-link :to="{ name: 'analysis.datasets' }" class="btn btn-sm btn-outline-secondary">
              View all {{ store.datasets.length }} datasets
            </router-link>
          </div>
        </b-card>
      </b-col>

      <!-- Quick actions -->
      <b-col xl="4" class="mb-4">
        <b-card header="Quick Actions">
          <div class="d-flex flex-column gap-2">
            <router-link
              :to="{ name: 'analysis.upload' }"
              class="btn btn-outline-primary text-start"
            >
              <i class="bx bx-upload me-2"></i> Upload New Dataset
            </router-link>
            <router-link
              v-if="latestReadyDataset"
              :to="{ name: 'analysis.chart', params: { id: latestReadyDataset.id } }"
              class="btn btn-outline-primary text-start"
            >
              <i class="bx bx-bar-chart-alt-2 me-2"></i> View Latest Chart
            </router-link>
            <router-link
              v-if="latestReadyDataset"
              :to="{ name: 'analysis.networks', params: { id: latestReadyDataset.id } }"
              class="btn btn-outline-primary text-start"
            >
              <i class="bx bx-network-chart me-2"></i> Network Maps
            </router-link>
            <router-link
              v-if="latestReadyDataset"
              :to="{ name: 'analysis.exports', params: { id: latestReadyDataset.id } }"
              class="btn btn-outline-secondary text-start"
            >
              <i class="bx bx-download me-2"></i> Export Data
            </router-link>
            <router-link
              :to="{ name: 'billing.plans' }"
              class="btn btn-outline-secondary text-start"
            >
              <i class="bx bx-credit-card me-2"></i> Manage Subscription
            </router-link>
          </div>
        </b-card>
      </b-col>
    </b-row>
  </VerticalLayout>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue'
import VerticalLayout from '@/layouts/VerticalLayout.vue'
import { useAuthStore } from '@/stores/auth'
import { useAnalysisStore } from '@/stores/analysis'

const auth = useAuthStore()
const store = useAnalysisStore()

const firstName = computed(() => auth.user?.firstName || auth.user?.email?.split('@')[0] || 'there')

const recentDatasets = computed(() => store.datasets.slice(0, 5))
const latestReadyDataset = computed(() => store.datasets.find(d => d.status === 'ready') ?? null)

const totalRecords = computed(() =>
  store.datasets.reduce((sum, d) => sum + (d.row_count ?? 0), 0)
)
const totalOrgs = computed(() =>
  store.datasets.reduce((sum, d) => sum + (d.unique_orgs ?? 0), 0)
)
const totalEvents = computed(() =>
  store.datasets.reduce((sum, d) => sum + (d.unique_events ?? 0), 0)
)

const statusVariant = (status: string) => ({
  ready: 'success',
  processing: 'warning',
  pending: 'secondary',
  error: 'danger',
}[status] ?? 'secondary')

onMounted(() => store.fetchDatasets())
</script>
