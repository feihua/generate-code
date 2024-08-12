<template>
  <el-divider />
  <el-table :data="props.tableData.data" table-layout="auto" @selection-change="handleSelectionChange" size="large">
  <el-table-column type="selection" width="55" />
  {{range .TableColumn}}{{if isContain .JavaName "Name"}}
  <el-table-column label="{{.ColumnComment}}" prop="{{.JavaName}}" />
  {{else if isContain .JavaName "name"}}
  <el-table-column label="{{.ColumnComment}}" prop="{{.JavaName}}" />
  {{else if isContain .JavaName "Type"}}
  <el-table-column label="{{.ColumnComment}}" prop="{{.JavaName}}" >
    <template #default="scope">
          <el-tag
            :type="scope.row.{{.JavaName}} === 0 ? 'danger' : 'success'"
            disable-transitions
            size="large"
            effect="dark"
          >{ { scope.row.{{.JavaName}} === 0 ? '禁用' : '启用' } }
          </el-tag
          >
    </template>
  </el-table-column>
  {{else if isContain .JavaName "status"}}
  <el-table-column label="{{.ColumnComment}}" prop="{{.JavaName}}" >
      <template #default="scope">
            <el-tag
              :type="scope.row.{{.JavaName}} === 0 ? 'danger' : 'success'"
              disable-transitions
              size="large"
              effect="dark"
            >{ { scope.row.{{.JavaName}} === 0 ? '禁用' : '启用' } }
            </el-tag
            >
      </template>
    </el-table-column>
  {{else if isContain .JavaName "Status"}}
  <el-table-column label="{{.ColumnComment}}" prop="{{.JavaName}}" >
      <template #default="scope">
            <el-tag
              :type="scope.row.{{.JavaName}} === 0 ? 'danger' : 'success'"
              disable-transitions
              size="large"
              effect="dark"
            >{ { scope.row.{{.JavaName}} === 0 ? '禁用' : '启用' } }
            </el-tag
            >
      </template>
    </el-table-column>
  {{else}}
  <el-table-column label="{{.ColumnComment}}" prop="{{.JavaName}}" />
  {{end}}{{end}}

    <el-table-column label="操作">
      <template #default="scope">
      <el-button type="primary" link @click="handleDetailView(scope.$index, scope.row)" icon="Setting">详情 </el-button>
        <el-button type="primary" link @click="handleEditView(scope.$index, scope.row)" icon="EditPen">编辑</el-button>
        <el-button type="danger" link @click="handleDelete(scope.$index, scope.row)" icon="Delete">删除</el-button>
      </template>
    </el-table-column>
  </el-table>
  <el-pagination
    background
    style="margin-top: 12px;padding-bottom: 12px;padding-right: 12px"
    v-model:current-page="props.tableData.page_no"
    v-model:page-size="pageSize"
    :page-sizes="[10, 20, 30, 40]"
    layout="->,total, sizes, prev, pager, next, jumper"
    :total="props.tableData.total"
    @size-change="handleSizeChange"
    @current-change="handleCurrentChange"
  />
</template>

<script lang="ts" setup>

import type { {{.JavaName}}RecordVo } from '../data'
import type { IResponse } from '@/api/ajax'
import { remove{{.JavaName}} } from '../service'
import { ref } from 'vue'
import { EditPen } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'

const props = defineProps<{
  tableData: IResponse
}>()


const currentPage = ref(1)
const pageSize = ref(10)


const emit = defineEmits(['handleQuery', 'handleEditView', 'handleDetailView', 'handleSelectMore'])

const handleEditView = (index: number, row: {{.JavaName}}RecordVo) => {
  emit('handleEditView', row)
}

const handleDetailView = (index: number, row: {{.JavaName}}RecordVo) => {
  emit('handleDetailView', row)
}

const handleDelete = (index: number, row: {{.JavaName}}RecordVo) => {
  ElMessageBox.confirm(
    '确定删除?',
    {
      confirmButtonText: '删除',
      cancelButtonText: '取消',
      type: 'warning'
    }
  ).then(async () => {
    let res: IResponse = await remove{{.JavaName}}([row.id])
    if (res.code == 0) {
      emit('handleQuery', { current: currentPage.value, pageSize: pageSize.value })
    }
    ElMessage({
      type: res.code === 0 ? 'success' : 'error',
      message: res.msg
    })
  })

}

const handleSelectionChange = (recordVo: {{.JavaName}}RecordVo[]) => {
  emit('handleSelectMore', recordVo.map((value) => value.id))
}

const handleSizeChange = (val: number) => {
  pageSize.value = val
  emit('handleQuery', { current: currentPage.value, pageSize: pageSize.value })
}

const handleCurrentChange = (val: number) => {
  currentPage.value = val
  props.tableData.page_no = val
  emit('handleQuery', { current: currentPage.value, pageSize: pageSize.value })
}

</script>

<style scoped>

</style>
