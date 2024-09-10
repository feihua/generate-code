<template>
  <el-space direction="horizontal" size="large" style="margin-left: 20px;margin-top: 20px">
    <el-button type="primary" icon="Plus" @click="dialogFormVisible = true">新建</el-button>
    <el-button type="danger" icon="Delete" :disabled="btnDisabled" @click="handleDeleteMore">批量删除</el-button>
    <el-form :inline="true" :model="searchParam" class="demo-form-inline" style="height: 32px;margin-left: 60px">
    {{range .TableColumn}}

     <el-form-item label="{{.ColumnComment}}">{{if isContain .JavaName "Sort"}}
        <el-input-number v-model="searchParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    {{else if isContain .JavaName "sort"}}
        <el-input-number v-model="searchParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    {{else if isContain .JavaName "status"}}
        <el-select v-model="searchParam.{{.JavaName}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
    {{else if isContain .JavaName "Status"}}
       <el-select v-model="searchParam.{{.JavaName}}" placeholder="请选择状态">
         <el-option label="启用" value="1"/>
         <el-option label="禁用" value="0"/>
       </el-select>
   {{else if isContain .JavaName "Type"}}
        <el-select v-model="searchParam.{{.JavaName}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
     {{else if isContain .JavaName "remark"}}
        <el-input v-model="searchParam.{{.JavaName}}" :rows="2" type="textarea" 请输入备注/>
     {{else}}
        <el-input v-model="searchParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
     {{end}} </el-form-item>{{end}}

     <el-form-item>
        <el-button type="primary" @click="handleQuery" icon="Search" style="width: 120px">查询</el-button>
        <el-button @click="handleQueryReset" style="width: 100px">重置</el-button>
      </el-form-item>
    </el-form>
  </el-space>

  <el-dialog v-model="dialogFormVisible" title="新建" style="width: 480px;border-radius: 10px">
    <el-form
        label-width="100px"
        :model="addParam"
        style="max-width: 380px"
        :rules="rules"
        status-icon
        ref="ruleFormRef"
    >
    {{range .TableColumn}}

    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">{{if isContain .JavaName "Sort"}}
        <el-input-number v-model="addParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    {{else if isContain .JavaName "sort"}}
        <el-input-number v-model="addParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    {{else if isContain .JavaName "status"}}
        <el-radio-group v-model="addParam.{{.JavaName}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
    {{else if isContain .JavaName "Status"}}
       <el-radio-group v-model="addParam.{{.JavaName}}" placeholder="请选择状态">
         <el-radio :label="1">启用</el-radio>
         <el-radio :label="0">禁用</el-radio>
       </el-radio-group>
   {{else if isContain .JavaName "Type"}}
        <el-radio-group v-model="addParam.{{.JavaName}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
     {{else if isContain .JavaName "remark"}}
        <el-input v-model="addParam.{{.JavaName}}" :rows="2" type="textarea" 请输入备注/>
     {{else}}
        <el-input v-model="addParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
     {{end}} </el-form-item>{{end}}
      <el-form-item>
        <el-button type="primary" @click="handleAdd(ruleFormRef)">保存</el-button>
        <el-button @click="dialogFormVisible = false">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>

import {reactive, ref} from "vue";
import { type FormRules, type FormInstance, ElMessage, ElMessageBox } from 'element-plus'
import type {IResponse} from "@/api/ajax";
import {add{{.JavaName}}, remove{{.JavaName}} } from "../service";
import type {Add{{.JavaName}}Param, Search{{.JavaName}}Param} from "../data";

const dialogFormVisible = ref(false)

const btnDisabled = ref<boolean>(true)
const {{.LowerJavaName}}Ids = ref<number[]>([])

const ruleFormRef = ref<FormInstance>()

const addParam = reactive<Add{{.JavaName}}Param>({
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else if isContain .JavaName "id"}}
  {{- else}}
  {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}
  {{- end}}
  {{- end}}
})

const searchParam = reactive<Search{{.JavaName}}Param>({})

const rules = reactive<FormRules>({
    {{range .TableColumn}}
    {{.JavaName}}: [
        {required: true, message: '{{.ColumnComment}}不能为空', trigger: 'blur'},
        // {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
      ],
     {{end}}
})

const emit = defineEmits(['handleQuery'])

const handleAdd = async (formEl: FormInstance | undefined) => {
  if (!formEl) return
  await formEl.validate(async (valid, fields) => {
    if (valid) {
      const addResult: IResponse = await add{{.JavaName}}(addParam)
      if (addResult.code === 0) {
        dialogFormVisible.value = false
        formEl.resetFields()
        emit("handleQuery", {current: 1, pageSize: 10});
      }
      addResult.code === 0 ? ElMessage.success(addResult.msg) : ElMessage.error(addResult.msg)
    } else {
      ElMessage.error("数据不能为空")
    }
  })
}


const handleQuery = async () => {
  emit("handleQuery", searchParam);
}

const handleQueryReset = async () => {
  {{range .TableColumn}}
  searchParam.{{.JavaName}} = undefined
  {{end}}
  emit("handleQuery", {current: 1, pageSize: 10, ...searchParam});
}

const handleReceiveDeleteParam = async (ids: number[]) => {
  btnDisabled.value = ids.length <= 0;
  {{.LowerJavaName}}Ids.value = ids
}

const handleDeleteMore = () => {
  ElMessageBox.confirm(
      '确定删除记录不?',
      {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(async () => {
    const res: IResponse = await remove{{.JavaName}}({{.LowerJavaName}}Ids.value)
    if (res.code == 0) {
      emit("handleQuery", {current: 1, pageSize: 10});
    }
    ElMessage({
      type: res.code === 0 ? 'success' : "error",
      message: res.message,
    })
  })

}

defineExpose({
  handleReceiveDeleteParam
})

</script>

<style scoped>

</style>