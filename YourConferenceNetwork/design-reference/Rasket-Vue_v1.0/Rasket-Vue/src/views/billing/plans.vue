<template>
  <VerticalLayout>
    <b-row class="mb-3">
      <b-col>
        <h4 class="mb-0">Subscription</h4>
        <p class="text-muted mb-0 small">Plan information for YourConferenceNetwork.</p>
      </b-col>
    </b-row>

    <b-row class="justify-content-center">
      <b-col md="8" lg="6">
        <b-card class="text-center py-5">
          <i class="bx bx-gift fs-1 text-primary mb-3 d-block"></i>
          <h4 class="mb-2">Free During Beta</h4>
          <p class="text-muted mb-4">
            YourConferenceNetwork is currently in open beta. All features — including network
            maps, Kumu.io exports, CSV/Gephi exports, and unlimited datasets — are available
            to all users at no cost.
          </p>
          <p class="text-muted small mb-0">
            Paid plans will be introduced in the future. You'll be notified before anything changes,
            and early beta users will receive preferred pricing.
          </p>
        </b-card>
      </b-col>
    </b-row>
  </VerticalLayout>
</template>

<script setup lang="ts">
import VerticalLayout from '@/layouts/VerticalLayout.vue'
</script>
