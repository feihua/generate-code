<template>
  <el-dialog :model-value="dialogUpdateFormVisible" title="更新" style="width: 480px;border-radius: 10px">
    <el-form
        label-width="100px"
        :model="props.update{{.JavaName}}Param"
        style="max-width: 380px"
        :rules="rules"
    >
    {{range .TableColumn}}

     <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">{{if isContain .JavaName "Sort"}}
        <el-input-number v-model="props.update{{.JavaName}}Param.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    {{else if isContain .JavaName "sort"}}
        <el-input-number v-model="props.update{{.JavaName}}Param.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    {{else if isContain .JavaName "status"}}
        <el-select v-model="props.update{{.JavaName}}Param.{{.JavaName}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
    {{else if isContain .JavaName "Status"}}
       <el-select v-model="props.update{{.JavaName}}Param.{{.JavaName}}" placeholder="请选择状态">
         <el-option label="启用" value="1"/>
         <el-option label="禁用" value="0"/>
       </el-select>
   {{else if isContain .JavaName "Type"}}
        <el-select v-model="props.update{{.JavaName}}Param.{{.JavaName}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
     {{else if isContain .JavaName "remark"}}
        <el-input v-model="props.update{{.JavaName}}Param.{{.JavaName}}" type="textarea" placeholder="请输入{{.ColumnComment}}"/>
     {{else}}
        <el-input v-model="props.update{{.JavaName}}Param.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
     {{end}} </el-form-item>{{end}}

      <el-form-item>
        <el-button type="primary" @click="handleEdit">保存</el-button>
        <el-button @click="handleEditViewClose">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>

import {reactive, ref} from "vue";
import type {Update{{.JavaName}}Param} from "../data.d";
import { type FormRules, type FormInstance, ElMessage, ElMessageBox } from 'element-plus'
import type {IResponse} from "@/api/ajax";
import {update{{.JavaName}} } from "../service";

const props = defineProps<{
  update{{.JavaName}}Param: Update{{.JavaName}}Param
}>()

const dialogUpdateFormVisible = ref(false)


const rules = reactive<FormRules>({
    {{range .TableColumn}}
    {{.JavaName}}: [
        {required: true, message: '{{.ColumnComment}}不能为空', trigger: 'blur'},
        // {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
      ],
     {{end}}
})

const emit = defineEmits(['handleQuery', 'handleEdit'])

const handleEditViewClose = () => {
  emit("handleEdit");
}

const handleEdit = async () => {
  if (props.update{{.JavaName}}Param) {
    let addResult: IResponse = await update{{.JavaName}}(props.update{{.JavaName}}Param)
    if (addResult.code === 0) {
      dialogUpdateFormVisible.value = false
      emit("handleQuery");
    }
    addResult.code === 0 ? ElMessage.success(addResult.msg) : ElMessage.error(addResult.msg)
  }
}

</script>

<style scoped>

</style>