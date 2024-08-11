<template>
  <el-space direction="horizontal" size="large" style="margin-left: 20px;margin-top: 20px">
    <el-button type="primary" icon="Plus" @click="dialogFormVisible = true">新建</el-button>
    <el-button type="danger" icon="Delete" :disabled="btnDisabled" @click="handleDeleteMore">批量删除</el-button>
    <el-form :inline="true" :model="searchParam" class="demo-form-inline" style="height: 32px;margin-left: 60px">
      <el-form-item label="手机号码">
        <el-input v-model="searchParam.mobile" placeholder="手机号码"/>
      </el-form-item>
      <el-form-item label="状态">
        <el-select v-model="searchParam.status_id" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
      </el-form-item>
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
      <el-form-item label="手机号" prop="mobile">
        <el-input v-model="addParam.mobile"/>
      </el-form-item>
      <el-form-item label="用户名" prop="real_name">
        <el-input v-model="addParam.real_name"/>
      </el-form-item>
      <el-form-item label="排序" prop="sort">
        <el-input-number v-model="addParam.sort" :min="1" :max="10"/>
      </el-form-item>
      <el-form-item label="状态" prop="status_id">
        <el-radio-group v-model="addParam.status_id">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="addParam.remark" :rows="2" type="textarea"/>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleAdd(ruleFormRef)">保存</el-button>
        <el-button @click="dialogFormVisible = false">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>

import {reactive, ref} from "vue";
import type {FormRules, FormInstance} from "element-plus";
import type {IResponse} from "@/api/ajax";
import {add} from "@/views/user/service";
import type {AddParam, SearchParam} from "@/views/user/data";
import {remove} from "@/views/log/service";

const dialogFormVisible = ref(false)

const btnDisabled = ref<boolean>(true)
const user_ids = ref<number[]>([])

const ruleFormRef = ref<FormInstance>()

const addParam = reactive<AddParam>({
  mobile: "", real_name: "", remark: "", sort: 0, status_id: 1

})

const searchParam = reactive<SearchParam>({})

const rules = reactive<FormRules>({
  mobile: [
    {required: true, message: '手机号不能为空', trigger: 'blur'},
    // {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
  ],
  real_name: [
    {required: true, message: '用户名不能为空', trigger: 'blur'},
    // {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
  ],
})

const emit = defineEmits(['handleQuery'])

const handleAdd = async (formEl: FormInstance | undefined) => {
  if (!formEl) return
  await formEl.validate(async (valid, fields) => {
    if (valid) {
      const addResult: IResponse = await add(addParam)
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
  searchParam.mobile = ''
  searchParam.status_id = undefined
  emit("handleQuery", {current: 1, pageSize: 10, ...searchParam});
}

const handleReceiveDeleteParam = async (ids: number[]) => {
  btnDisabled.value = ids.length <= 0;
  user_ids.value = ids
}

const handleDeleteMore = () => {
  ElMessageBox.confirm(
      '确定删除用户' + user_ids.value.length + '条记录不?',
      {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(async () => {
    let res: IResponse = await remove(user_ids.value)
    if (res.code == 0) {
      emit("handleQuery", {current: 1, pageSize: 10});
    }
    ElMessage({
      type: res.code === 0 ? 'success' : "error",
      message: res.msg,
    })
  })

}

defineExpose({
  handleReceiveDeleteParam
})

</script>

<style scoped>

</style>