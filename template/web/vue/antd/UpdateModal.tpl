<template>
  <div>
    <a-modal
        v-model:open="updateVisible"
        title="编辑"
        ok-text="保存"
        cancel-text="取消"
        @ok="onOk"
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
          <a-input-number v-model:value="formState.{{.JavaName}}" style="width: 234px" placeholder="请选择{{.ColumnComment}}"/>
      {{else if isContain .JavaName "sort"}}
          <a-input-number v-model:value="formState.{{.JavaName}}" style="width: 234px" placeholder="请选择{{.ColumnComment}}"/>
      {{else if isContain .JavaName "status"}}
          <a-radio-group v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}">
              <a-radio :value="1">是</a-radio>
              <a-radio :value="0">否</a-radio>
          </a-radio-group>
      {{else if isContain .JavaName "Status"}}
          <a-radio-group v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}">
              <a-radio :value="1">是</a-radio>
              <a-radio :value="0">否</a-radio>
          </a-radio-group>
      {{else if isContain .JavaName "Type"}}
          <a-radio-group v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}">
              <a-radio :value="1">正常</a-radio>
              <a-radio :value="0">禁用</a-radio>
          </a-radio-group>
      {{else if isContain .JavaName "remark"}}
          <a-textarea v-model:value="formState.{{.JavaName}}" allow-clear  placeholder="请选择{{.ColumnComment}}"/>
      {{else}}
          <a-input v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}"/>
      {{end}}</a-form-item>{{end}}

    </a-form>
    </a-modal>
  </div>
</template>
<script lang="ts" setup>
import {ref} from 'vue';
import {type FormInstance, message} from 'ant-design-vue';

import {use{{.JavaName}}Store} from "../store/{{.LowerJavaName}}Store";
import type {Update{{.JavaName}}Param} from "../data";
import {query{{.JavaName}}Detail, update{{.JavaName}}} from "../service";
import type {IResponse} from "@/utils/ajax";
import {storeToRefs} from "pinia";

const store = use{{.JavaName}}Store()
const {page} = storeToRefs(store)
const {query{{.JavaName}}List} = store


const formRef = ref<FormInstance>();
const updateVisible = ref(false);
const formState = ref<Update{{.JavaName}}Param>({
  {{range .TableColumn}}
    {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}{{end}}

});

const onOk = () => {

  formRef.value?.validateFields()
      .then(async () => {
        const res = await update{{.JavaName}}(formState.value);
        if (res.code == 0) {
          message.success(res.message);
          query{{.JavaName}}List({current: page.value.current, pageSize: page.value.pageSize});
          updateVisible.value = false;
          formRef.value?.resetFields();
        } else {
          message.error(res.message);
        }
      })
      .catch(info => {
        message.error(info);
      });
};

const handleVisible = async (id: number, open: boolean) => {
  updateVisible.value = open
  let res: IResponse = await query{{.JavaName}}Detail(id)
  formState.value = res.data
}

defineExpose({
  handleVisible
})
</script>
<style scoped>

</style>
