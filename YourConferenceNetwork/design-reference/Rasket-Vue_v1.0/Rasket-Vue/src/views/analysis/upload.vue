<template>
  <VerticalLayout>
    <b-row class="justify-content-center">
      <b-col xl="7" lg="9">

        <div class="mb-4">
          <h4>Upload Dataset</h4>
          <p class="text-muted">Upload a CSV of conference attendance records. Use our template to ensure correct column format.</p>
        </div>

        <!-- Step indicator -->
        <div class="d-flex align-items-center mb-4 gap-3">
          <div :class="['step-indicator', step >= 1 ? 'active' : '']">1</div>
          <div class="step-line flex-grow-1"></div>
          <div :class="['step-indicator', step >= 2 ? 'active' : '']">2</div>
          <div class="step-line flex-grow-1"></div>
          <div :class="['step-indicator', step >= 3 ? 'active' : '']">3</div>
        </div>

        <!-- Step 1: Prepare -->
        <b-card v-if="step === 1" class="mb-3">
          <h5 class="mb-3">Step 1 — Prepare Your Data</h5>
          <p>Download the CSV template and fill in your attendance records. Each row = one person at one conference.</p>

          <div class="bg-light rounded p-3 mb-3 font-monospace small">
            UniqueID, Salutation, First, Last, SNA Category - ORIGINAL,
            SNA Category - CLEANED, Title, Title - CLEANED,
            Organization - ORIGINAL, Organization - CLEANED,
            Active / Inactive, Address, City, State, Zip, Conference
          </div>

          <div class="mb-3">
            <strong>Key fields:</strong>
            <ul class="mt-2 mb-0">
              <li><code>Organization - CLEANED</code> — standardized org name (used for analysis)</li>
              <li><code>SNA Category - CLEANED</code> — sector type (Program, Business, Government, etc.)</li>
              <li><code>Conference</code> — date in <code>MM/YYYY</code> format (e.g. <code>05/2010</code>)</li>
              <li><code>State</code> — two-letter US state code</li>
            </ul>
          </div>

          <a :href="templateUrl" class="btn btn-outline-primary me-2" download>
            <i class="bx bx-download me-1"></i> Download Template CSV
          </a>
          <button class="btn btn-primary" @click="step = 2">
            I'm ready to upload <i class="bx bx-chevron-right ms-1"></i>
          </button>
        </b-card>

        <!-- Step 2: Upload -->
        <b-card v-else-if="step === 2" class="mb-3">
          <h5 class="mb-3">Step 2 — Upload Your File</h5>

          <b-alert v-if="store.error" variant="danger" show dismissible @dismissed="store.error = null">
            {{ store.error }}
          </b-alert>

          <div class="mb-3">
            <label class="form-label fw-semibold">Dataset Name</label>
            <b-form-input
              v-model="datasetName"
              placeholder="e.g. Chicago Network 2005–2015"
              :state="nameError ? false : null"
            />
            <div v-if="nameError" class="text-danger small mt-1">{{ nameError }}</div>
          </div>

          <div class="mb-4">
            <label class="form-label fw-semibold">CSV File</label>
            <div
              class="upload-drop-zone"
              :class="{ 'drag-over': isDragging, 'has-file': selectedFile }"
              @dragover.prevent="isDragging = true"
              @dragleave="isDragging = false"
              @drop.prevent="onDrop"
              @click="fileInput?.click()"
            >
              <input
                ref="fileInput"
                type="file"
                accept=".csv,text/csv"
                class="d-none"
                @change="onFileChange"
              />
              <div v-if="!selectedFile" class="text-center py-4">
                <i class="bx bx-cloud-upload fs-1 text-muted"></i>
                <p class="mb-1 mt-2">Drop your CSV here or <span class="text-primary">browse</span></p>
                <p class="text-muted small mb-0">Max 50 MB · .csv files only</p>
              </div>
              <div v-else class="text-center py-3">
                <i class="bx bx-file fs-2 text-success"></i>
                <p class="mb-0 mt-1 fw-semibold">{{ selectedFile.name }}</p>
                <p class="text-muted small mb-0">{{ formatFileSize(selectedFile.size) }}</p>
              </div>
            </div>
            <div v-if="fileError" class="text-danger small mt-1">{{ fileError }}</div>
          </div>

          <div class="d-flex gap-2">
            <button class="btn btn-outline-secondary" @click="step = 1">Back</button>
            <button
              class="btn btn-primary"
              :disabled="store.uploading"
              @click="doUpload"
            >
              <b-spinner v-if="store.uploading" small class="me-1" />
              {{ store.uploading ? 'Uploading…' : 'Upload & Process' }}
            </button>
          </div>
        </b-card>

        <!-- Step 3: Processing -->
        <b-card v-else class="mb-3 text-center py-5">
          <div v-if="processingStatus === 'processing' || processingStatus === 'pending'">
            <b-spinner variant="primary" style="width:3rem;height:3rem;" />
            <h5 class="mt-4">Processing your data…</h5>
            <p class="text-muted">Normalizing sectors, building indexes. This may take a minute.</p>
          </div>
          <div v-else-if="processingStatus === 'ready'">
            <i class="bx bx-check-circle fs-1 text-success"></i>
            <h5 class="mt-3">Ready!</h5>
            <p class="text-muted">Your dataset has been processed successfully.</p>
            <router-link
              :to="{ name: 'analysis.overview', params: { id: createdDatasetId } }"
              class="btn btn-primary mt-2"
            >
              View Dashboard <i class="bx bx-arrow-right ms-1"></i>
            </router-link>
          </div>
          <div v-else>
            <i class="bx bx-error-circle fs-1 text-danger"></i>
            <h5 class="mt-3">Processing failed</h5>
            <p class="text-muted">{{ processingError || 'An error occurred. Please check your CSV format and try again.' }}</p>
            <button class="btn btn-outline-secondary mt-2" @click="reset">Try Again</button>
          </div>
        </b-card>

      </b-col>
    </b-row>
  </VerticalLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import VerticalLayout from '@/layouts/VerticalLayout.vue'
import { useAnalysisStore } from '@/stores/analysis'
import { templateDownloadUrl } from '@/helpers/api/analysis'

const store = useAnalysisStore()

const step = ref(1)
const datasetName = ref('')
const selectedFile = ref<File | null>(null)
const isDragging = ref(false)
const fileInput = ref<HTMLInputElement | null>(null)
const nameError = ref('')
const fileError = ref('')
const processingStatus = ref<string>('pending')
const processingError = ref('')
const createdDatasetId = ref<number | null>(null)

const templateUrl = templateDownloadUrl()

const formatFileSize = (bytes: number) => {
  if (bytes < 1024) return `${bytes} B`
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`
  return `${(bytes / 1024 / 1024).toFixed(1)} MB`
}

const onFileChange = (e: Event) => {
  const input = e.target as HTMLInputElement
  if (input.files?.[0]) selectedFile.value = input.files[0]
}

const onDrop = (e: DragEvent) => {
  isDragging.value = false
  const file = e.dataTransfer?.files[0]
  if (file?.name.endsWith('.csv')) {
    selectedFile.value = file
  } else {
    fileError.value = 'Please drop a .csv file.'
  }
}

const validate = () => {
  nameError.value = ''
  fileError.value = ''
  if (!datasetName.value.trim()) nameError.value = 'Dataset name is required.'
  if (!selectedFile.value) fileError.value = 'Please select a CSV file.'
  return !nameError.value && !fileError.value
}

const doUpload = async () => {
  if (!validate()) return
  const dataset = await store.uploadDataset(datasetName.value.trim(), selectedFile.value!)
  if (!dataset) return
  createdDatasetId.value = dataset.id
  step.value = 3
  processingStatus.value = dataset.status
  if (dataset.status !== 'ready' && dataset.status !== 'error') {
    processingStatus.value = await store.pollStatus(dataset.id)
    // Get error message if failed
    if (processingStatus.value === 'error') {
      const d = store.datasets.find(d => d.id === dataset.id)
      processingError.value = d?.error_message ?? ''
    }
  }
}

const reset = () => {
  step.value = 1
  datasetName.value = ''
  selectedFile.value = null
  processingStatus.value = 'pending'
  processingError.value = ''
  createdDatasetId.value = null
  store.error = null
}
</script>

<style scoped>
.step-indicator {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #e9ecef;
  color: #6c757d;
  font-weight: 600;
  font-size: 0.85rem;
  flex-shrink: 0;
}
.step-indicator.active {
  background: #3b82f6;
  color: #fff;
}
.step-line {
  height: 2px;
  background: #e9ecef;
}
.upload-drop-zone {
  border: 2px dashed #dee2e6;
  border-radius: 8px;
  cursor: pointer;
  transition: border-color 0.2s, background 0.2s;
  min-height: 130px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.upload-drop-zone:hover,
.upload-drop-zone.drag-over {
  border-color: #3b82f6;
  background: #f0f7ff;
}
.upload-drop-zone.has-file {
  border-color: #22c55e;
  background: #f0fdf4;
}
</style>
