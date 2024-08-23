<template>
  <el-divider />
  <el-table :data="{{.LowerJavaName}}List" table-layout="auto" @selection-change="handleSelectionChange" size="large">
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
        <el-button type="primary" link @click="query{{.JavaName}}Detail(scope.row.id, false)" icon="Setting">详情</el-button>
        <el-button type="primary" link @click="query{{.JavaName}}Detail(scope.row.id, true)" icon="EditPen">编辑</el-button>
        <el-button type="danger" link @click="handleDelete(scope.$index, scope.row)" icon="Delete">删除</el-button>
      </template>
    </el-table-column>
  </el-table>
  <el-pagination
    background
    style="margin-top: 12px; padding-bottom: 12px; padding-right: 12px"
    v-model:current-page="listParam.current"
    v-model:page-size="listParam.pageSize"
    :page-sizes="[10, 20, 30, 40]"
    layout="->,total, sizes, prev, pager, next, jumper"
    :total="listParam.total"
    @size-change="handleSizeChange"
    @current-change="handleCurrentChange" />
</template>

<script lang="ts" setup>
import type { {{.JavaName}}RecordVo } from '../data';
import type { IResponse } from '@/api/ajax';
import { remove{{.JavaName}} } from '../service';
import { onMounted, ref } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';

import { use{{.JavaName}}Store } from '../store/{{.LowerJavaName}}Store';
import { storeToRefs } from 'pinia';

const store = use{{.JavaName}}Store();

const { listParam, {{.LowerJavaName}}List } = storeToRefs(store);
const { query{{.JavaName}}List, query{{.JavaName}}Detail } = store;

const value = ref(true);

const handleDelete = (index: number, row: {{.JavaName}}RecordVo) => {
  ElMessageBox.confirm('确定删除?', {
    confirmButtonText: '删除',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    let res: IResponse = await remove{{.JavaName}}({ids:[row.id]});
    if (res.code === 0) {
      ElMessage.success(res.message);
      queryUserList(listParam.value);
    } else {
      ElMessage.error(res.message);
    }
  });
};

const handleSelectionChange = (recordVo: {{.JavaName}}RecordVo[]) => {
  // emit(
  //   'handleSelectMore',
  //   recordVo.map((value) => value.id),
  // );
};

const handleSizeChange = (val: number) => {
  query{{.JavaName}}List({ current: listParam.value.current, pageSize: val });
};

const handleCurrentChange = (val: number) => {
  query{{.JavaName}}List({ current: val, pageSize: listParam.value.pageSize });
};

onMounted(() => {
  query{{.JavaName}}List({ current: 1, pageSize: 10 });
});
</script>

<style scoped></style>
