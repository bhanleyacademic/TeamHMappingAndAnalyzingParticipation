<template>
  <VerticalLayout>
    <b-row class="mb-4">
      <b-col>
        <h4 class="mb-0">Manage Subscription</h4>
        <p class="text-muted mb-0 small">Update payment method, view invoices, or cancel your plan.</p>
      </b-col>
    </b-row>

    <b-row class="justify-content-center">
      <b-col md="8" lg="6">
        <b-card class="text-center py-4">
          <i class="bx bx-credit-card fs-1 text-primary mb-3"></i>
          <h5>Stripe Customer Portal</h5>
          <p class="text-muted">
            Click below to open the Stripe portal where you can manage your billing details,
            update your payment method, download invoices, or cancel your subscription.
          </p>
          <b-alert v-if="error" variant="danger" show class="text-start mb-3">{{ error }}</b-alert>
          <button class="btn btn-primary px-5" :disabled="loading" @click="openPortal">
            <b-spinner v-if="loading" small class="me-1" />
            Open Billing Portal
          </button>
          <div class="mt-3">
            <router-link :to="{ name: 'billing.plans' }" class="text-muted small">
              View plans &amp; pricing
            </router-link>
          </div>
        </b-card>
      </b-col>
    </b-row>
  </VerticalLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import VerticalLayout from '@/layouts/VerticalLayout.vue'
import httpClient from '@/helpers/http-client'

const loading = ref(false)
const error = ref('')

const openPortal = async () => {
  loading.value = true
  error.value = ''
  try {
    const res = await httpClient.post<{ url: string }>('/api/v1/billing/portal/')
    window.location.href = res.data.url
  } catch {
    error.value = 'Failed to open billing portal. Please try again.'
  } finally {
    loading.value = false
  }
}
</script>
