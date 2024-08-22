<template>
  <div style="background-color: white">
    <el-space style="margin-left: 20px; margin-top: 20px">
      <AddModal />
      <SearchForm />
    </el-space>
    <ListTable />
    <UpdateModal />
    <DetailModal />
  </div>
</template>

<script lang="ts" setup>
import AddModal from './components/AddModal.vue';
import SearchForm from './components/SearchForm.vue';
import UpdateModal from './components/UpdateModal.vue';
import DetailModal from './components/DetailModal.vue';
import ListTable from './components/ListTable.vue';
</script>

<style scoped></style>
