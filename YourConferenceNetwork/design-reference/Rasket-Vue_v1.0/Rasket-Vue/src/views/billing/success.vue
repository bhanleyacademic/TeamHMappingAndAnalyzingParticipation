<template>
  <VerticalLayout>
    <b-row class="justify-content-center">
      <b-col md="7" lg="5" class="text-center py-5">
        <i class="bx bx-check-circle fs-1 text-success mb-3"></i>
        <h4>Subscription activated!</h4>
        <p class="text-muted">
          Your plan is now active. You can now download network maps and export CSV files.
        </p>
        <div class="d-flex justify-content-center gap-3 mt-4">
          <router-link :to="{ name: 'analysis.datasets' }" class="btn btn-primary">
            Go to Datasets
          </router-link>
          <router-link :to="{ name: 'billing.portal' }" class="btn btn-outline-secondary">
            Manage Billing
          </router-link>
        </div>
      </b-col>
    </b-row>
  </VerticalLayout>
</template>

<script setup lang="ts">
import VerticalLayout from '@/layouts/VerticalLayout.vue'
</script>
