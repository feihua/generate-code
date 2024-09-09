<template>
  <el-button type="primary" icon="Plus" @click="visible = true">新建</el-button>
  <el-dialog v-model="visible" title="新建" style="width: 480px; border-radius: 10px">
    <el-form label-width="100px" :model="addParam" style="max-width: 380px" :rules="rules" status-icon ref="ruleFormRef">
    {{range .TableColumn}}
   {{- if isContain .JavaName "create"}}
   {{- else if isContain .JavaName "update"}}
   {{- else if isContain .JavaName "id"}}
   {{- else if isContain .JavaName "Sort"}}
    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">
        <el-input-number v-model="addParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    </el-form-item>
    {{- else if isContain .JavaName "sort"}}
    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">
        <el-input-number v-model="addParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
    </el-form-item>
    {{- else if isContain .JavaName "status"}}
    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">
        <el-radio-group v-model="addParam.{{.JavaName}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
    </el-form-item>
    {{- else if isContain .JavaName "Status"}}
    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">
       <el-radio-group v-model="addParam.{{.JavaName}}" placeholder="请选择状态">
         <el-radio :label="1">启用</el-radio>
         <el-radio :label="0">禁用</el-radio>
       </el-radio-group>
    </el-form-item>
   {{- else if isContain .JavaName "Type"}}
    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">
        <el-radio-group v-model="addParam.{{.JavaName}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
    </el-form-item>
     {{- else if isContain .JavaName "remark"}}
    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">
        <el-input v-model="addParam.{{.JavaName}}" :rows="2" type="textarea" 请输入备注/>
    </el-form-item>
     {{- else}}
    <el-form-item label="{{.ColumnComment}}" prop="{{.JavaName}}">
        <el-input v-model="addParam.{{.JavaName}}" placeholder="请输入{{.ColumnComment}}"/>
     </el-form-item>{{- end}} {{- end}}

      <el-form-item>
        <el-button type="primary" @click="handleAdd(ruleFormRef)">保存</el-button>
        <el-button @click="visible = false">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue';
import { ElMessage, type FormInstance, type FormRules } from 'element-plus';
import { add{{.JavaName}} } from '../service';
import type { Add{{.JavaName}}Param } from '../data';
import { use{{.JavaName}}Store } from '../store/{{.LowerJavaName}}Store';

const store = use{{.JavaName}}Store();

const { query{{.JavaName}}List } = store;
const visible = ref(false);

const ruleFormRef = ref<FormInstance>();

const addParam = reactive<Add{{.JavaName}}Param>({
  {{range .TableColumn}}
    {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}{{end}}
});

const rules = reactive<FormRules>({
    {{range .TableColumn}}
    {{- if isContain .JavaName "create"}}
    {{- else if isContain .JavaName "update"}}
    {{- else if isContain .JavaName "id"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else}}
    {{.JavaName}}: [
        {required: true, message: '{{.ColumnComment}}不能为空', trigger: 'blur'},
        // {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
      ],
     {{end}}
     {{end}}
})

const handleAdd = async (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  await formEl.validate(async (valid) => {
    if (valid) {
      const res = await add{{.JavaName}}(addParam);
      if (res.code == 0) {
        ElMessage.success(res.message);
        query{{.JavaName}}List({ current: 1, pageSize: 10 });
        visible.value = false;
        ruleFormRef.value?.resetFields();
      } else {
        ElMessage.error(res.message);
      }
    } else {
      ElMessage.error('数据不能为空');
    }
  });
};
</script>

<style scoped></style>
