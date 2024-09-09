<template>
  <a-form
      ref="formRef"
      :model="formState"
      name="horizontal_login"
      layout="inline"
      @finish="onFinish"
  >
    {{- range .TableColumn}}
    {{- if isContain .JavaName "create"}}
     {{- else if isContain .JavaName "update"}}
     {{- else if isContain .JavaName "id"}}
     {{- else if isContain .JavaName "remark"}}
     {{- else if isContain .JavaName "Sort"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "status"}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}">
      <a-select v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}" style="width: 183px">
        <a-select-option value="1">正常</a-select-option>
        <a-select-option value="0">禁用</a-select-option>
      </a-select>
    </a-form-item>
    {{- else if isContain .JavaName "Status"}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}">
      <a-select v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}" style="width: 183px">
        <a-select-option value="1">正常</a-select-option>
        <a-select-option value="0">禁用</a-select-option>
      </a-select>
    </a-form-item>
    {{- else if isContain .JavaName "Type"}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}">
      <a-select v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}" style="width: 183px">
        <a-select-option value="1">正常</a-select-option>
        <a-select-option value="0">禁用</a-select-option>
      </a-select>
    </a-form-item>
    {{- else if isContain .JavaName "remark"}}

    {{- else}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}">
        <a-input v-model:value="formState.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    </a-form-item>{{- end}}{{- end}}

    <a-form-item>
      <ASpace>
        <a-button type="primary" html-type="submit" style="width: 120px">
          <template #icon>
            <SearchOutlined/>
          </template>
          查询
        </a-button>
        <a-button style="margin: 0 8px;width: 100px" @click="resetFields">重置</a-button>
      </ASpace>
    </a-form-item>
  </a-form>
</template>
<script lang="ts" setup>
import {reactive, ref} from 'vue';
import type {FormInstance} from "ant-design-vue";

import {use{{.JavaName}}Store} from "../store/{{.LowerJavaName}}Store";
import {SearchOutlined} from "@ant-design/icons-vue";
import type {Search{{.JavaName}}Param} from "../data";

const store = use{{.JavaName}}Store()
const {query{{.JavaName}}List} = store
const formRef = ref<FormInstance>();

const formState = reactive<Search{{.JavaName}}Param>({
  {{range .TableColumn}}
    {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}{{end}}

});
const onFinish = (values: any) => {
  query{{.JavaName}}List({ ...values, current:1, pageSize: 10 })
};

const resetFields = () => {
  formRef.value?.resetFields();
  query{{.JavaName}}List({})
};

</script>

