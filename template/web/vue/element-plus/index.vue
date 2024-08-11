<template>

  <div style=";background-color: white">
    <AddForm @handleQuery="handleQueryWithPageParam" ref="addChildrenRef"/>
    <ListTable :tableData="tableData" @handleEditView="handleEditView" @handleSetRoleView="handleSetRoleView" @handleQuery="handleQueryWithPageParam"
               @handleSelectMore="handleSelectMore"/>
    <UpdateForm v-model="dialogUpdateFormVisible" @handleQuery="handleQuery" @handleEdit="dialogUpdateFormVisible = false" :record="recordVo"/>
    <SetUserRoleForm v-model="roleFormVisible" ref="childrenRef" @handleQuery="handleQuery" @handleEdit="roleFormVisible = false"/>
  </div>

</template>

<script lang="ts" setup>
import {onMounted, ref} from 'vue'
import {listData} from "@/views/user/service";
import type {IResponse} from "@/api/ajax";
import type {SearchParam, ListParam, RecordVo} from "@/views/user/data.d";
import AddForm from "@/views/user/components/AddForm.vue";
import UpdateForm from "@/views/user/components/UpdateForm.vue";
import ListTable from "@/views/user/components/ListTable.vue";
import SetUserRoleForm from "@/views/user/components/SetUserRoleForm.vue";

const dialogUpdateFormVisible = ref(false)
const roleFormVisible = ref(false)
const childrenRef = ref();
const addChildrenRef = ref();

const tableData = ref<IResponse>({code: 0, data: [], msg: ""})
const searchParam = ref<SearchParam>({})

const currentPage = ref(1)
const pageSize = ref(10)

const recordVo = ref<RecordVo>({
  create_time: "", id: 0, mobile: "", real_name: "", remark: "", sort: 0, status_id: 0, update_time: ""
})

const handleQuery = async (data: ListParam) => {
  dialogUpdateFormVisible.value = false
  roleFormVisible.value = false
  searchParam.value = {...data}
  let res: IResponse = await listData({...data, ...searchParam.value, current: currentPage.value, pageSize: pageSize.value})
  tableData.value = {...res}
}

const handleQueryWithPageParam = async (data: ListParam) => {
  currentPage.value = data.current || 1
  pageSize.value = data.pageSize || 10
  await handleQuery(data)
}

const handleEditView = (row: RecordVo) => {
  recordVo.value = row
  dialogUpdateFormVisible.value = true
}

const handleSetRoleView = (row: RecordVo) => {
  recordVo.value = row
  roleFormVisible.value = true
  childrenRef.value.queryUserRole(row.id, row.real_name)
}

const handleSelectMore = (ids: number[]) => {
  addChildrenRef.value.handleReceiveDeleteParam(ids)
}


onMounted(async () => {
  await handleQuery({current: currentPage.value, pageSize: pageSize.value})
})


</script>

<style lang="less" scoped>

</style>
