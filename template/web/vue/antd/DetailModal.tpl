<template>
  <div>
    <a-modal
        v-model:open="detailVisible"
        title="{{.Comment}}详情"
        footer=""
        width="480px"
        style="padding-top: 15px"
    >
    <a-form ref="formRef" :model="formState" name="form_in_modal" :label-col="{ span: 7 }"
            :wrapper-col="{ span: 13 }">
      {{range .TableColumn}}
      <a-form-item
          name="{{.JavaName}}"
          label="{{.ColumnComment}}"
          :rules="[{ required: true, message: '请输入{{.ColumnComment}}' }]"
      >{{if isContain .JavaName "Sort"}}
          <a-input-number v-model:value="formState.{{.JavaName}}" style="width: 234px" :bordered="false"/>
      {{else if isContain .JavaName "sort"}}
          <a-input-number v-model:value="formState.{{.JavaName}}" style="width: 234px" :bordered="false"/>
      {{else if isContain .JavaName "status"}}
          <a-radio-group v-model:value="formState.{{.JavaName}}" :bordered="false" disabled>
              <a-radio :value="1">是</a-radio>
              <a-radio :value="0">否</a-radio>
          </a-radio-group>
      {{else if isContain .JavaName "Status"}}
          <a-radio-group v-model:value="formState.{{.JavaName}}" disabled>
              <a-radio :value="1">是</a-radio>
              <a-radio :value="0">否</a-radio>
          </a-radio-group>
      {{else if isContain .JavaName "Type"}}
          <a-radio-group v-model:value="formState.{{.JavaName}}" disabled>
              <a-radio :value="1">正常</a-radio>
              <a-radio :value="0">禁用</a-radio>
          </a-radio-group>
      {{else if isContain .JavaName "remark"}}
          <a-textarea v-model:value="formState.{{.JavaName}}" allow-clear :bordered="false"/>
      {{else}}
          <a-input v-model:value="formState.{{.JavaName}}" :bordered="false"/>
      {{end}}</a-form-item>{{end}}

    </a-form>
    </a-modal>
  </div>
</template>
<script lang="ts" setup>
import {ref} from 'vue';
import {type FormInstance} from 'ant-design-vue';

import type {Update{{.JavaName}}Param} from "../data";
import {query{{.JavaName}}Detail} from "../service";
import type {IResponse} from "@/utils/ajax";

const formRef = ref<FormInstance>();
const detailVisible = ref(false);
const formState = ref<Update{{.JavaName}}Param>({
  {{range .TableColumn}}
    {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}{{end}}

});

const handleVisible = async (id: number, open: boolean) => {
  detailVisible.value = open
  let res: IResponse = await query{{.JavaName}}Detail(id)
  formState.value = res.data
}

defineExpose({
  handleVisible
})
</script>
<style scoped>

</style>
