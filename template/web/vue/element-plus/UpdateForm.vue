<template>
  <el-dialog :model-value="dialogUpdateFormVisible" title="更新" style="width: 480px;border-radius: 10px">
    <el-form
        label-width="100px"
        :model="props.record"
        style="max-width: 380px"
        :rules="rules"
    >
      <el-form-item label="手机号" prop="mobile">
        <el-input v-model="props.record.mobile"/>
      </el-form-item>
      <el-form-item label="用户名" prop="username">
        <el-input v-model="props.record.real_name"/>
      </el-form-item>
      <el-form-item label="排序" prop="sort">
        <el-input-number v-model="props.record.sort" :min="1" :max="10"/>
      </el-form-item>
      <el-form-item label="状态" prop="status_id">
        <el-radio-group v-model="props.record.status_id">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="props.record.remark" :rows="2" type="textarea"/>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleEdit">保存</el-button>
        <el-button @click="handleEditViewClose">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>

import {reactive, ref} from "vue";
import type {UpdateParam} from "@/views/user/data.d";
import type {FormRules} from "element-plus";
import type {IResponse} from "@/api/ajax";
import {update} from "@/views/user/service";

const props = defineProps<{
  record: UpdateParam
}>()

const dialogUpdateFormVisible = ref(false)


const rules = reactive<FormRules>({
  mobile: [
    {required: true, message: 'Please input Activity name', trigger: 'blur'},
    {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
  ],
  real_name: [
    {required: true, message: 'Please input Activity name', trigger: 'blur'},
    {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
  ],
  remark: [
    {required: true, message: 'Please input Activity name', trigger: 'blur'},
    {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
  ],
})


const emit = defineEmits(['handleQuery', 'handleEdit'])

const handleEditViewClose = () => {
  emit("handleEdit");
}

const handleEdit = async () => {
  if (props.record) {
    let addResult: IResponse = await update(props.record)
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