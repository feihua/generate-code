<template>
  <div>
    <a-button type="primary" @click="visible = true" style="width: 82px;">
      <template #icon>
        <PlusOutlined/>
      </template>
      新建
    </a-button>
    <a-modal
        v-model:open="visible"
        title="新建"
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
            <a-input-number v-model:value="formState.{{.JavaName}}" style="width: 234px"/>
        {{else if isContain .JavaName "sort"}}
            <a-input-number v-model:value="formState.{{.JavaName}}" style="width: 234px"/>
        {{else if isContain .JavaName "status"}}
            <a-radio-group v-model:value="formState.{{.JavaName}}">
                <a-radio :value="1">是</a-radio>
                <a-radio :value="0">否</a-radio>
            </a-radio-group>
        {{else if isContain .JavaName "Status"}}
            <a-radio-group v-model:value="formState.{{.JavaName}}">
                <a-radio :value="1">是</a-radio>
                <a-radio :value="0">否</a-radio>
            </a-radio-group>
        {{else if isContain .JavaName "Type"}}
            <a-radio-group v-model:value="formState.{{.JavaName}}">
                <a-radio :value="1">正常</a-radio>
                <a-radio :value="0">禁用</a-radio>
            </a-radio-group>
        {{else if isContain .JavaName "remark"}}
            <a-textarea v-model:value="formState.{{.JavaName}}" allow-clear/>
        {{else}}
            <a-input v-model:value="formState.{{.JavaName}}"/>
        {{end}}</a-form-item>{{end}}

      </a-form>
    </a-modal>
  </div>
</template>
<script lang="ts" setup>
import {reactive, ref} from 'vue';
import {type FormInstance, message} from 'ant-design-vue';

import {PlusOutlined} from "@ant-design/icons-vue"
import {use{{.JavaName}}Store} from "../store/{{.LowerJavaName}}Store";
import type {Add{{.JavaName}}Param} from "../data";
import {add{{.JavaName}}} from "../service";

const store = use{{.JavaName}}Store()

const {query{{.JavaName}}List} = store


const formRef = ref<FormInstance>();
const visible = ref(false);
const formState = reactive<Add{{.JavaName}}Param>({
  {{range .TableColumn}}
    {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}{{end}}

});

const onOk = () => {
  formRef.value?.validateFields()
      .then(async () => {
        const res = await add{{.JavaName}}(formState);
        if (res.code == 0) {
          message.success(res.message);
          query{{.JavaName}}List({});
          visible.value = false;
          formRef.value?.resetFields();
        } else {
          message.error(res.message);
        }

      })
      .catch(info => {
        message.error(info);
      });
};
</script>
<style scoped>

</style>
