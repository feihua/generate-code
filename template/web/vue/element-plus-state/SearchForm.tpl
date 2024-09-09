<template>
  <el-form :inline="true" :model="searchParam" class="demo-form-inline" style="height: 32px; margin-left: 20px" ref="formRef">
    {{range .TableColumn}}
    {{- if isContain .JavaName "create"}}
    {{- else if isContain .JavaName "update"}}
    {{- else if isContain .JavaName "id"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "Sort"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "status"}}
     <el-form-item label="{{.ColumnComment}}">
        <el-select v-model="searchParam.{{.JavaName}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
     </el-form-item>
    {{- else if isContain .JavaName "Status"}}
     <el-form-item label="{{.ColumnComment}}">
       <el-select v-model="searchParam.{{.JavaName}}" placeholder="请选择状态">
         <el-option label="启用" value="1"/>
         <el-option label="禁用" value="0"/>
       </el-select>
     </el-form-item>
   {{- else if isContain .JavaName "Type"}}
     <el-form-item label="{{.ColumnComment}}">
        <el-select v-model="searchParam.{{.JavaName}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
     </el-form-item>
     {{- else if isContain .JavaName "remark"}}
     <el-form-item label="{{.ColumnComment}}">
        <el-input v-model="searchParam.{{.JavaName}}" :rows="2" type="textarea" 请输入备注/>
     </el-form-item>
     {{- else}}
     <el-form-item label="{{.ColumnComment}}">
        <el-input v-model="searchParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
     </el-form-item>{{- end}}{{- end}}

     <el-form-item>
        <el-button type="primary" @click="onFinish" icon="Search" style="width: 120px">查询</el-button>
        <el-button @click="resetFields" style="width: 100px">重置</el-button>
      </el-form-item>
  </el-form>
</template>
<script lang="ts" setup>
import { reactive, ref } from 'vue';

import { use{{.JavaName}}Store } from '../store/{{.LowerJavaName}}Store';
import type { List{{.JavaName}}Param } from '../data';
import type { FormInstance } from 'element-plus';

const store = use{{.JavaName}}Store();
const { query{{.JavaName}}List } = store;
const formRef = ref<FormInstance>();

const searchParam = reactive<List{{.JavaName}}Param>({
  current: 1,
  pageSize: 10,
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else if isContain .JavaName "id"}}
  {{- else if isContain .JavaName "remark"}}
  {{- else}}
  {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}
  {{- end}}
  {{- end}}
});

const onFinish = () => {
  query{{.JavaName}}List(searchParam);
};

const resetFields = () => {
  formRef.value?.resetFields();
  query{{.JavaName}}List({ current: 1, pageSize: 10 });
};
</script>
