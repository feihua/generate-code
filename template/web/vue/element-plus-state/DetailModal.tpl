<template>
  <el-dialog :model-value="detailVisible" title="详情" style="width: 620px; border-radius: 6px" destroy-on-close @close="closeDetail">
    <el-descriptions column="2" style="padding-left: 50px; padding-top: 20px; padding-bottom: 50px">
  {{range .TableColumn}}<el-descriptions-item label="{{.ColumnComment}}">{ {detailRecordVo.{{.JavaName}} } }</el-descriptions-item>
   {{end}}
    </el-descriptions>
  </el-dialog>
</template>

<script lang="ts" setup>
import { use{{.JavaName}}Store } from '../store/{{.LowerJavaName}}Store';
import { storeToRefs } from 'pinia';

const store = use{{.JavaName}}Store();
const { detailRecordVo, detailVisible } = storeToRefs(store);
const { closeDetail } = store;
</script>

<style scoped></style>
