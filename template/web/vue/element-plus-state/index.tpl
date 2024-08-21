<template>
  <div style="background-color: white">
    <el-space style="margin-left: 20px; margin-top: 20px">
      <AddForm />
      <SearchForm />
    </el-space>
    <ListTable />
    <UpdateForm />
    <DetailModal />
  </div>
</template>

<script lang="ts" setup>
import AddForm from './components/AddForm.vue';
import SearchForm from './components/SearchForm.vue';
import UpdateForm from './components/UpdateForm.vue';
import DetailModal from './components/DetailModal.vue';
import ListTable from './components/ListTable.vue';
</script>

<style scoped></style>
