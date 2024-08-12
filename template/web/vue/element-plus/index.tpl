<template>

  <div style=";background-color: white">
    <AddForm @handleQuery="handleQueryWithPageParam" ref="addChildrenRef"/>
    <ListTable :tableData="tableData" @handleEditView="handleEditView" @handleDetailView="handleDetailView" @handleQuery="handleQueryWithPageParam"
               @handleSelectMore="handleSelectMore"/>
    <UpdateForm v-model="dialogUpdateFormVisible" @handleQuery="handleQuery" @handleEdit="dialogUpdateFormVisible = false" :updateParam="recordVo"/>
    <DetailModal v-model="detailFormVisible" ref="childrenRef" @handleEdit="detailFormVisible = false"/>
  </div>

</template>

<script lang="ts" setup>
import {onMounted, ref} from 'vue'
import {query{{.JavaName}}List} from "./service";
import type {IResponse} from "@/api/ajax";
import type {Search{{.JavaName}}Param, List{{.JavaName}}Param, {{.JavaName}}RecordVo} from "./data.d";
import AddForm from "./components/AddForm.vue";
import UpdateForm from "./components/UpdateForm.vue";
import ListTable from "./components/ListTable.vue";
import DetailModal from "./components/DetailModal.vue";

const dialogUpdateFormVisible = ref(false)
const detailFormVisible = ref(false)
const childrenRef = ref();
const addChildrenRef = ref();

const tableData = ref<IResponse>({code: 0, data: [], msg: ""})
const searchParam = ref<Search{{.JavaName}}Param>({})

const currentPage = ref(1)
const pageSize = ref(10)

const recordVo = ref<{{.JavaName}}RecordVo>({
{{range .TableColumn}}
  {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}{{end}}
})

const handleQuery = async (data: List{{.JavaName}}Param) => {
  dialogUpdateFormVisible.value = false
  detailFormVisible.value = false
  searchParam.value = {...data}
  let res: IResponse = await query{{.JavaName}}List({...data, ...searchParam.value, current: currentPage.value, pageSize: pageSize.value})
  tableData.value = {...res}
}

const handleQueryWithPageParam = async (data: List{{.JavaName}}Param) => {
  currentPage.value = data.current || 1
  pageSize.value = data.pageSize || 10
  await handleQuery(data)
}

const handleEditView = (row: {{.JavaName}}RecordVo) => {
  recordVo.value = row
  dialogUpdateFormVisible.value = true
}

const handleDetailView = (row: {{.JavaName}}RecordVo) => {
  recordVo.value = row
  detailFormVisible.value = true
  childrenRef.value.query{{.JavaName}}Info(row.id)
}

const handleSelectMore = (ids: number[]) => {
  addChildrenRef.value.handleReceiveDeleteParam(ids)
}


onMounted(async () => {
  await handleQuery({current: currentPage.value, pageSize: pageSize.value})
})


</script>

<style scoped>

</style>
