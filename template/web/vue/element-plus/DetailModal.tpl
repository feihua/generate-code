<template>
  <el-dialog :model-value="detailFormVisible" title="详情" style="width: 880px;border-radius: 10px" destroy-on-close :close="handleViewClose">
      <el-descriptions title="{{.Comment}}详情">
      {{range .TableColumn}}<el-descriptions-item label="{{.ColumnComment}}">{ {detailParam.{{.JavaName}} } }</el-descriptions-item>
      {{end}}
      </el-descriptions>
    <el-form
        label-width="100px"
        :model="detailParam"
        style="max-width: 380px"
        status-icon
        ref="ruleFormRef"
    >
    <el-row :gutter="20">
    {{range .TableColumn}}
    <el-col :span="6">
    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">{{if isContain .JavaName "Sort"}}
        <el-input-number v-model="detailParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    {{else if isContain .JavaName "sort"}}
        <el-input-number v-model="detailParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    {{else if isContain .JavaName "status"}}
        <el-radio-group v-model="detailParam.{{.JavaName}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
    {{else if isContain .JavaName "Status"}}
       <el-radio-group v-model="detailParam.{{.JavaName}}" placeholder="请选择状态">
         <el-radio :label="1">启用</el-radio>
         <el-radio :label="0">禁用</el-radio>
       </el-radio-group>
   {{else if isContain .JavaName "Type"}}
        <el-radio-group v-model="detailParam.{{.JavaName}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
     {{else if isContain .JavaName "remark"}}
        <el-input v-model="detailParam.{{.JavaName}}" :rows="2" type="textarea" 请输入备注/>
     {{else}}
        <el-input v-model="detailParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
     {{end}} </el-form-item></el-col>{{end}}
     </el-row>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>

import {ref} from "vue";
import type {IResponse} from "@/api/ajax";
import {query{{.JavaName}}Detail} from "../service";
import type { {{.JavaName}}RecordVo} from "../data.d";

const detailFormVisible = ref(false)
const detailParam = ref<{{.JavaName}}RecordVo>({
{{range .TableColumn}}
  {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}{{end}}

})

const query{{.JavaName}}Info = async (id: number) => {
  let res: IResponse = await query{{.JavaName}}Detail(id)
  detailParam.value = res.data

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