<template>
  <div v-if="auth.isImpersonating" class="impersonation-banner d-flex align-items-center justify-content-between px-4 py-2">
    <div class="d-flex align-items-center gap-2">
      <i class="bx bx-user-check fs-5"></i>
      <span>
        Viewing as <strong>{{ auth.user?.email }}</strong> —
        billing actions are disabled during impersonation.
      </span>
    </div>
    <button class="btn btn-sm btn-light" :disabled="stopping" @click="stopImpersonating">
      <b-spinner v-if="stopping" small class="me-1" />
      Exit to admin
    </button>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useAuthStore } from '@/stores/auth'
import httpClient from '@/helpers/http-client'

const auth = useAuthStore()
const stopping = ref(false)

const stopImpersonating = async () => {
  stopping.value = true
  try {
    const res = await httpClient.post<{ access: string; refresh: string; user: object }>(
      '/api/v1/admin/impersonate/stop/'
    )
    auth.restoreAdminSession(res.data as any)
  } catch {
    // If the stop call fails, just clear the session so the admin can re-login
    auth.removeSession()
  } finally {
    stopping.value = false
  }
}
</script>

<style scoped>
.impersonation-banner {
  background: #fef3c7;
  border-bottom: 1px solid #f59e0b;
  color: #78350f;
  font-size: 0.875rem;
  position: sticky;
  top: 0;
  z-index: 1050;
}
</style>
