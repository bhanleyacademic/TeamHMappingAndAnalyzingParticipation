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
            <li class="breadcrumb-item active">Chart</li>
          </ol>
        </nav>
        <h4 class="mb-0">Participation Chart</h4>
        <p class="text-muted mb-0 small">Attendance per conference event, broken down by sector.</p>
      </b-col>
    </b-row>

    <!-- Filters -->
    <b-card class="mb-3">
      <b-row class="g-2 align-items-end">
        <b-col sm="4" md="3">
          <label class="form-label small fw-semibold mb-1">Year</label>
          <b-form-select v-model="filters.year" :options="yearOptions" size="sm" @change="loadChart" />
        </b-col>
        <b-col sm="4" md="3">
          <label class="form-label small fw-semibold mb-1">Sector</label>
          <b-form-select v-model="filters.sector" :options="sectorOptions" size="sm" @change="loadChart" />
        </b-col>
        <b-col sm="4" md="3">
          <label class="form-label small fw-semibold mb-1">State</label>
          <b-form-select v-model="filters.state" :options="stateOptions" size="sm" @change="loadChart" />
        </b-col>
        <b-col sm="12" md="3">
          <button class="btn btn-sm btn-outline-secondary w-100" @click="resetFilters">
            Clear Filters
          </button>
        </b-col>
      </b-row>
    </b-card>

    <!-- Chart -->
    <b-card>
      <div v-if="loading" class="text-center py-5"><b-spinner variant="primary" /></div>
      <div v-else-if="!chartData || !chartData.series.length" class="text-center py-5 text-muted">
        No data for the selected filters.
      </div>
      <VueApexCharts
        v-else
        type="bar"
        height="420"
        :options="chartOptions"
        :series="chartData.series.map(s => ({ name: s.name, data: s.data }))"
      />
    </b-card>

    <!-- Legend / sector count summary -->
    <b-row v-if="chartData" class="mt-3">
      <b-col
        v-for="series in chartData.series"
        :key="series.name"
        cols="6" md="4" xl="2"
        class="mb-2"
      >
        <div class="d-flex align-items-center gap-2">
          <span
            class="d-inline-block rounded"
            :style="`width:12px;height:12px;background:${series.color};flex-shrink:0`"
          ></span>
          <span class="small">{{ series.name }}</span>
          <span class="small text-muted ms-auto">{{ series.data.reduce((a, b) => a + b, 0).toLocaleString() }}</span>
        </div>
      </b-col>
    </b-row>
  </VerticalLayout>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import VerticalLayout from '@/layouts/VerticalLayout.vue'
import VueApexCharts from 'vue3-apexcharts'
import * as api from '@/helpers/api/analysis'
import type { ChartData } from '@/helpers/api/analysis'

const route = useRoute()
const id = Number(route.params.id)

const loading = ref(true)
const chartData = ref<ChartData | null>(null)

const filters = reactive({ year: '', sector: '', state: '' })

const yearOptions = computed(() => [
  { value: '', text: 'All Years' },
  ...(chartData.value?.available_years ?? []).map(y => ({ value: String(y), text: String(y) })),
])
const sectorOptions = computed(() => [
  { value: '', text: 'All Sectors' },
  ...(chartData.value?.canonical_categories ?? []).map(s => ({ value: s, text: s })),
])
const stateOptions = computed(() => [
  { value: '', text: 'All States' },
  ...(chartData.value?.available_states ?? []).map(s => ({ value: s, text: s })),
])

const chartOptions = computed(() => ({
  chart: {
    type: 'bar',
    stacked: true,
    toolbar: { show: true },
    animations: { enabled: false },
  },
  xaxis: {
    categories: chartData.value?.categories ?? [],
    labels: { rotate: -45, style: { fontSize: '11px' } },
  },
  yaxis: { title: { text: 'Attendees' } },
  legend: { position: 'top' },
  colors: (chartData.value?.series ?? []).map(s => s.color),
  plotOptions: { bar: { columnWidth: '80%' } },
  dataLabels: { enabled: false },
  tooltip: { shared: true, intersect: false },
}))

const loadChart = async () => {
  loading.value = true
  const params: Record<string, string> = {}
  if (filters.year) params.year = filters.year
  if (filters.sector) params.sector = filters.sector
  if (filters.state) params.state = filters.state
  try {
    const res = await api.getChart(id, params)
    chartData.value = res.data
  } finally {
    loading.value = false
  }
}

const resetFilters = () => {
  filters.year = ''
  filters.sector = ''
  filters.state = ''
  loadChart()
}

onMounted(loadChart)
</script>
