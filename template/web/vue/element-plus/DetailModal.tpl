<template>
  <el-dialog :model-value="detailFormVisible" title="详情" style="width: 880px;border-radius: 10px" destroy-on-close :close="handleViewClose">
    <el-descriptions title="{{.Comment}}详情">
    {{range .TableColumn}}<el-descriptions-item label="{{.ColumnComment}}">{{.LowerJavaName}}Vo.{{.JavaName}}</el-descriptions-item>
    {{end}}
    </el-descriptions>
  </el-dialog>
</template>

<script lang="ts" setup>

import {ref} from "vue";
import type {IResponse} from "@/api/ajax";
import {query{{.JavaName}}Detail} from "../service";
import type { {{.JavaName}}RecordVo} from "../data.d";

const detailFormVisible = ref(false)
const {{.LowerJavaName}}Vo = ref<{{.JavaName}}RecordVo>()

const query{{.JavaName}}Info = async (id: number) => {
  let res: IResponse = await query{{.JavaName}}Detail(id)
  {{.LowerJavaName}}Vo.value = res.data

}

const emit = defineEmits(['handleEdit'])

const handleViewClose = () => {
  emit("handleEdit");
}

defineExpose({
  query{{.JavaName}}Info
});

</script>

<style scoped>

</style>