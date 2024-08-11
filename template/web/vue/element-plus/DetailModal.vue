<template>
  <el-dialog :model-value="roleFormVisible" title="设置角色" style="width: 880px;border-radius: 10px" destroy-on-close>
    <el-table row-key="id" :data="tableData" table-layout="auto" @selection-change="handleSelectionChange" size="large" ref="multipleTableRef">
      <el-table-column type="selection" width="55"/>
      <el-table-column label="角色姓名" prop="role_name"/>
      <el-table-column label="排序" prop="sort"/>
      <el-table-column label="状态" prop="status_id"/>
      <el-table-column label="备注" prop="remark"/>
      <el-table-column label="创建时间" prop="create_time"/>
      <el-table-column label="更新时间" prop="update_time"/>
    </el-table>
    <el-space direction="vertical" size="large" style="width:100%;margin-top: 20px;align-items: center">
      <el-button type="primary" icon="Select" :disabled="btnDisabled" @click="handleUserRole" style="width: 120px">保存</el-button>
    </el-space>
  </el-dialog>
</template>

<script lang="ts" setup>

import {ref} from "vue";
import type {IResponse} from "@/api/ajax";
import {query_user_role, update_user_role} from "@/views/user/service";
import type {RecordVo} from "@/views/role/data.d";
import type {ElTable} from "element-plus";

const roleFormVisible = ref(false)
const iResponse = ref<IResponse>()
const tableData = ref<RecordVo[]>([])
const btnDisabled = ref<boolean>(true)
const role_ids = ref<number[]>([])
const user_id = ref<number>()
const user_name = ref<string>()


const multipleTableRef = ref<InstanceType<typeof ElTable>>()

const toggleSelection = () => {
  if (role_ids.value.length > 0) {
    role_ids.value.forEach((item) => {
      const row = tableData.value.find((it) => it.id === item);
      multipleTableRef.value!.toggleRowSelection(row, true)
    })
  } else {
    multipleTableRef.value!.clearSelection()
  }
}

const handleSelectionChange = (recordVo: RecordVo[]) => {
  btnDisabled.value = recordVo.length <= 0;
  role_ids.value = recordVo.map((value) => value.id)
}

const handleUserRole = () => {
  ElMessageBox.confirm(
      '确定设置用户' + user_name.value + '的角色不?',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(async () => {
    let res: IResponse = await update_user_role(user_id.value || 0, role_ids.value)
    let code = res.code === 0;

    ElMessage({
      type: code ? 'success' : "error",
      message: res.msg,
    })

    if (code) {
      emit("handleQuery");
    }
  })

}

const emit = defineEmits(['handleQuery'])

const queryUserRole = async (id: number, name: string) => {
  user_id.value = id
  user_name.value = name
  let res: IResponse = await query_user_role(id)
  iResponse.value = {...res}
  tableData.value = res.data.sys_role_list
  role_ids.value = res.data.user_role_ids
  setTimeout(toggleSelection, 500)

}


defineExpose({
  queryUserRole
});

</script>

<style scoped>

</style>