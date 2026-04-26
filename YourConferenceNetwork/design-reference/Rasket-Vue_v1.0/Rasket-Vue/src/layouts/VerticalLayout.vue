<template>
  <div class="wrapper">
    <TopBar />
    <LeftSideBar />
    <div class="page-content">
      <ImpersonationBanner />
      <b-container fluid>
        <slot />
      </b-container>
      <Footer />
      <RightSideBar />
    </div>
  </div>
</template>

<script setup lang="ts">
import TopBar from "@/layouts/partials/TopBar.vue";
import Footer from "@/layouts/partials/Footer.vue";
import LeftSideBar from "@/layouts/partials/LeftSideBar.vue";
import RightSideBar from "@/layouts/partials/RightSideBar.vue";
import ImpersonationBanner from "@/components/ImpersonationBanner.vue";
</script>