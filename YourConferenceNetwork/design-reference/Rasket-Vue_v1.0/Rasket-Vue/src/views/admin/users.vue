<template>
  <b-row>
    <!-- Site Settings card -->
    <b-col cols="12" class="mb-3">
      <b-card>
        <h5 class="card-title mb-1">Site Settings</h5>
        <p class="text-muted small mb-3">When <strong>Free Tier Override</strong> is ON, all authenticated users have full feature access — no paywall or subscription required.</p>
        <div v-if="settingsLoading" class="text-muted small">Loading…</div>
        <div v-else class="d-flex align-items-center gap-3">
          <div class="form-check form-switch mb-0">
            <input
              class="form-check-input"
              type="checkbox"
              role="switch"
              id="freeTierOverride"
              :checked="freeTierOverride"
              :disabled="settingsSaving"
              @change="toggleFreeTier"
            />
            <label class="form-check-label" for="freeTierOverride">
              Free Tier Override
            </label>
          </div>
          <span :class="freeTierOverride ? 'badge bg-success' : 'badge bg-secondary'">
            {{ freeTierOverride ? 'ON — All features unlocked' : 'OFF — Subscription required' }}
          </span>
        </div>
        <div v-if="settingsError" class="text-danger small mt-2">{{ settingsError }}</div>
      </b-card>
    </b-col>

    <b-col cols="12">
      <b-card>
        <div class="d-flex align-items-center justify-content-between mb-3">
          <h5 class="card-title mb-0">User Management</h5>
          <span class="text-muted small">{{ users.length }} users</span>
        </div>

        <b-alert v-if="error" variant="danger" show class="mb-3">{{ error }}</b-alert>

        <div v-if="loading" class="text-center py-5">
          <b-spinner variant="primary" />
        </div>

        <div v-else class="table-responsive">
          <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
              <tr>
                <th>User</th>
                <th>Role</th>
                <th>Joined</th>
                <th>Datasets</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="u in users" :key="u.id">
                <td>
                  <div class="fw-semibold">{{ u.first_name }} {{ u.last_name }}</div>
                  <div class="text-muted small">{{ u.email }}</div>
                </td>
                <td>
                  <span :class="roleBadge(u.role)" class="badge">{{ u.role }}</span>
                </td>
                <td class="text-muted small">{{ formatDate(u.date_joined) }}</td>
                <td class="text-muted small">{{ u.profile?.organization || '—' }}</td>
                <td class="text-end">
                  <button
                    v-if="u.role !== 'admin'"
                    class="btn btn-sm btn-outline-warning"
                    :disabled="impersonatingId === u.id"
                    @click="startImpersonation(u)"
                  >
                    <b-spinner v-if="impersonatingId === u.id" small class="me-1" />
                    <i v-else class="bx bx-user-check me-1"></i>
                    Use as
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </b-card>
    </b-col>
  </b-row>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import httpClient from '@/helpers/http-client'
import { useAuthStore } from '@/stores/auth'

const auth = useAuthStore()
const router = useRouter()

const users = ref<any[]>([])
const loading = ref(true)
const error = ref('')
const impersonatingId = ref<number | null>(null)

const freeTierOverride = ref(false)
const settingsLoading = ref(true)
const settingsSaving = ref(false)
const settingsError = ref('')

onMounted(async () => {
  // Load users and site settings in parallel
  const [usersResult, settingsResult] = await Promise.allSettled([
    httpClient.get<any[]>('/api/v1/admin/users/'),
    httpClient.get<{ free_tier_override: boolean }>('/api/v1/admin/site-settings/'),
  ])

  if (usersResult.status === 'fulfilled') {
    users.value = usersResult.value.data
  } else {
    const e = usersResult.reason as any
    error.value = e.response?.status === 403 ? 'Admin role required.' : 'Failed to load users.'
  }
  loading.value = false

  if (settingsResult.status === 'fulfilled') {
    freeTierOverride.value = settingsResult.value.data.free_tier_override
  } else {
    settingsError.value = 'Failed to load site settings.'
  }
  settingsLoading.value = false
})

async function toggleFreeTier(event: Event) {
  const newVal = (event.target as HTMLInputElement).checked
  settingsSaving.value = true
  settingsError.value = ''
  try {
    const res = await httpClient.patch<{ free_tier_override: boolean }>('/api/v1/admin/site-settings/', {
      free_tier_override: newVal,
    })
    freeTierOverride.value = res.data.free_tier_override
  } catch (e: any) {
    settingsError.value = e.response?.data?.detail || 'Failed to save setting.'
  } finally {
    settingsSaving.value = false
  }
}

async function startImpersonation(u: any) {
  impersonatingId.value = u.id
  try {
    const res = await httpClient.post<{
      access: string
      refresh: string
      impersonating: { id: number; email: string; firstName: string; lastName: string }
    }>(`/api/v1/admin/users/${u.id}/impersonate/`)

    auth.saveSession({
      access: res.data.access,
      refresh: res.data.refresh,
      user: {
        id: res.data.impersonating.id,
        email: res.data.impersonating.email,
        firstName: res.data.impersonating.firstName,
        lastName: res.data.impersonating.lastName,
        username: res.data.impersonating.email,
        role: 'user',
      },
    })

    router.push('/')
  } catch (e: any) {
    error.value = e.response?.data?.detail || 'Failed to start impersonation.'
  } finally {
    impersonatingId.value = null
  }
}

function roleBadge(role: string) {
  return role === 'admin' ? 'bg-danger' : 'bg-secondary'
}

function formatDate(iso: string) {
  return iso ? new Date(iso).toLocaleDateString() : '—'
}
</script>
