<template>
  <VerticalLayout>
    <b-row class="mb-3 align-items-center">
      <b-col>
        <h4 class="mb-0">My Datasets</h4>
        <p class="text-muted mb-0">Your uploaded conference attendance files.</p>
      </b-col>
      <b-col cols="auto">
        <router-link :to="{ name: 'analysis.upload' }" class="btn btn-primary">
          <i class="bx bx-upload me-1"></i> Upload New Dataset
        </router-link>
      </b-col>
    </b-row>

    <div v-if="store.loading" class="text-center py-5">
      <b-spinner variant="primary" />
    </div>

    <b-alert v-else-if="store.error" variant="danger" show>{{ store.error }}</b-alert>

    <div v-else-if="!store.hasDatasets" class="text-center py-5">
      <i class="bx bx-data fs-1 text-muted"></i>
      <h5 class="mt-3">No datasets yet</h5>
      <p class="text-muted">Upload your first conference attendance CSV to get started.</p>
      <router-link :to="{ name: 'analysis.upload' }" class="btn btn-primary mt-2">
        Upload Dataset
      </router-link>
    </div>

    <b-card v-else no-body>
      <b-table
        :items="store.datasets"
        :fields="fields"
        responsive
        hover
        class="mb-0"
      >
        <template #cell(name)="{ item }">
          <router-link
            v-if="item.status === 'ready'"
            :to="{ name: 'analysis.overview', params: { id: item.id } }"
            class="fw-semibold"
          >
            {{ item.name }}
          </router-link>
          <span v-else class="fw-semibold">{{ item.name }}</span>
        </template>

        <template #cell(status)="{ item }">
          <b-badge :variant="statusVariant(item.status)">{{ item.status }}</b-badge>
        </template>

        <template #cell(summary)="{ item }">
          <span v-if="item.status === 'ready'" class="text-muted small">
            {{ item.row_count?.toLocaleString() }} records ·
            {{ item.unique_orgs?.toLocaleString() }} orgs ·
            {{ item.unique_events }} events
            <span v-if="item.year_min"> · {{ item.year_min }}–{{ item.year_max }}</span>
          </span>
          <span v-else-if="item.status === 'error'" class="text-danger small">{{ item.error_message }}</span>
          <span v-else class="text-muted small">Processing…</span>
        </template>

        <template #cell(created_at)="{ item }">
          <span class="text-muted small">{{ formatDate(item.created_at) }}</span>
        </template>

        <template #cell(actions)="{ item }">
          <div class="d-flex gap-2">
            <router-link
              v-if="item.status === 'ready'"
              :to="{ name: 'analysis.overview', params: { id: item.id } }"
              class="btn btn-sm btn-outline-primary"
            >
              Open
            </router-link>
            <button
              class="btn btn-sm btn-outline-danger"
              @click="confirmDelete(item)"
            >
              <i class="bx bx-trash"></i>
            </button>
          </div>
        </template>
      </b-table>
    </b-card>

    <!-- Delete confirmation modal -->
    <b-modal
      v-model="showDeleteModal"
      title="Delete Dataset"
      ok-title="Delete"
      ok-variant="danger"
      @ok="doDelete"
    >
      <p>Delete <strong>{{ pendingDelete?.name }}</strong>? This cannot be undone.</p>
    </b-modal>
  </VerticalLayout>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import VerticalLayout from '@/layouts/VerticalLayout.vue'
import { useAnalysisStore } from '@/stores/analysis'
import type { Dataset } from '@/helpers/api/analysis'

const store = useAnalysisStore()

const fields = [
  { key: 'name', label: 'Name', sortable: true },
  { key: 'status', label: 'Status' },
  { key: 'summary', label: 'Summary' },
  { key: 'created_at', label: 'Uploaded' },
  { key: 'actions', label: '' },
]

const showDeleteModal = ref(false)
const pendingDelete = ref<Dataset | null>(null)

onMounted(() => store.fetchDatasets())

const statusVariant = (status: string) => ({
  ready: 'success',
  processing: 'warning',
  pending: 'secondary',
  error: 'danger',
}[status] ?? 'secondary')

const formatDate = (iso: string) =>
  new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })

const confirmDelete = (dataset: Dataset) => {
  pendingDelete.value = dataset
  showDeleteModal.value = true
}

const doDelete = async () => {
  if (pendingDelete.value) {
    await store.removeDataset(pendingDelete.value.id)
    pendingDelete.value = null
  }
}
</script>
