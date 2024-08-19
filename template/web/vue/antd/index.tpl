<template>
  <ASpace style="margin-bottom: 10px">
    <AddModal />
    <SearchForm style="margin-left: 20px" />
  </ASpace>
  <a-table :columns="columns" :data-source="{{.LowerJavaName}}List" :pagination="page" @change="handlePageChange"
           table-layout="fixed">
    <template #bodyCell="{ column, record }">
      <template v-if="column.key === '{{.LowerJavaName}}Name'">
        <a-button type="link" @click="handleDetail(record)">{ { record.{{.LowerJavaName}}Name } }</a-button>
      </template>
      <template v-if="column.key === 'status'">
        <a-switch :checked="record.status===1" size="small"
                  @click="(value: boolean, event: Event) => handleSwitchChange(value, event, record)"/>
      </template>
      <template v-else-if="column.key === 'action'">
        <span>
          <a-button type="link" @click="handleDetail(record)">
            <template #icon>
              <EditOutlined/>
            </template>
            详情
          </a-button>
          <a-button type="link" @click="handleEdit(record)">
            <template #icon>
              <EditOutlined/>
            </template>
            编辑
          </a-button>
          <a-button danger type="link" @click="handleDelete(record)">
            <template #icon>
              <DeleteOutlined/>
            </template>
            删除
          </a-button>
        </span>
      </template>
    </template>
  </a-table>

  <UpdateModal ref="updateChildrenRef" v-model="updateVisible"></UpdateModal>
  <DetailModal ref="detailChildrenRef" v-model="detailVisible"></DetailModal>
</template>

<script lang="ts" setup>
import {DeleteOutlined, EditOutlined, ExclamationCircleOutlined} from '@ant-design/icons-vue';
import AddModal from "./components/AddModal.vue";
import {use{{.JavaName}}Store} from "./store/{{.LowerJavaName}}Store";
import type { {{.JavaName}}RecordVo} from "./data";
import {createVNode, onMounted, ref} from "vue";
import {storeToRefs} from "pinia";
import UpdateModal from "./components/UpdateModal.vue";
import DetailModal from "./components/DetailModal.vue";
import {message, Modal} from "ant-design-vue";
import {remove{{.JavaName}}, update{{.JavaName}}Status} from "./service";
import SearchForm from "./components/SearchForm.vue";

const updateVisible = ref(false);
const detailVisible = ref(false);
const updateChildrenRef = ref()
const detailChildrenRef = ref()

const store = use{{.JavaName}}Store()
const {page, {{.LowerJavaName}}List,} = storeToRefs(store)
const {query{{.JavaName}}List} = store

const columns = [
{{range .TableColumn}}
    {
        title: '{{.ColumnComment}}',
        dataIndex: '{{.JavaName}}',
        key: '{{.JavaName}}',
    },
{{end}}
    {
      title: '操作',
      key: 'action',
    },
];

const handleDetail = (record: {{.JavaName}}RecordVo) => {
  detailChildrenRef.value.handleVisible(record.id, true)
}

const handleEdit = (record: {{.JavaName}}RecordVo) => {
  updateChildrenRef.value.handleVisible(record.id, true)
}

const handleDelete = (record: {{.JavaName}}RecordVo) => {
  Modal.confirm({
    cancelText: "取消",
    okText: "确定",
    centered: true,
    title: '确定删除?',
    icon: createVNode(ExclamationCircleOutlined),
    async onOk() {
      const res = await remove{{.JavaName}}({ids:[record.id]});
      if (res.code == 0) {
        message.success(res.message);
        query{{.JavaName}}List({current: page.value.current, pageSize: page.value.pageSize});
      } else {
        message.error(res.message);
      }
    },
    onCancel() {
    },
  });
}


const handlePageChange = (obj: any) => {
  delete obj.total
  query{{.JavaName}}List({...obj})
}

const handleSwitchChange = async (checked: boolean, event: Event, record: {{.JavaName}}RecordVo) => {
  const res = await update{{.JavaName}}Status({ids: [record.id], status: checked ? 1 : 0});
  if (res.code == 0) {
    message.success(res.message);
    query{{.JavaName}}List({current: page.value.current, pageSize: page.value.pageSize});
  } else {
    message.error(res.message);
  }
}

onMounted(() => {
  query{{.JavaName}}List({current: 1, pageSize: 10});
})

</script>

