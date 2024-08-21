import { ref } from 'vue';
import { defineStore } from 'pinia';
import type { List{{.JavaName}}Param, {{.JavaName}}RecordVo } from '../data';
import { query{{.JavaName}}Detail1, query{{.JavaName}}List1 } from '../service';

export const use{{.JavaName}}Store = defineStore('{{.LowerJavaName}}', () => {
  const {{.LowerJavaName}}RecordVo = ref<{{.JavaName}}RecordVo>({
  {{range .TableColumn}}
    {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}{{end}}
  });

  const updateVisible = ref<boolean>(false);
  const detailVisible = ref<boolean>(false);

  const listParam = ref<List{{.JavaName}}Param>({
    current: 1,
    pageSize: 10,
  });
  const {{.LowerJavaName}}List = ref<{{.JavaName}}RecordVo[]>([]);

  function query{{.JavaName}}List(params: List{{.JavaName}}Param) {
    delete params.total;
    listParam.value = params;
    query{{.JavaName}}List1(params).then((res) => {
      {{.LowerJavaName}}List.value = res.data;
      listParam.value.total = res.total || 0;
    });
  }

  function query{{.JavaName}}Detail(id: number, flag: boolean) {
    flag ? (updateVisible.value = true) : (detailVisible.value = true);
    query{{.JavaName}}Detail1(id).then((res) => {
      {{.LowerJavaName}}RecordVo.value = res.data;
    });
  }

  function closeDetail() {
    detailVisible.value = false;
  }

  function closeUpdate() {
    updateVisible.value = false;
  }

  return {
    listParam,
    {{.LowerJavaName}}RecordVo,
    updateVisible,
    detailVisible,
    {{.LowerJavaName}}List,
    query{{.JavaName}}List,
    query{{.JavaName}}Detail,
    closeDetail,
    closeUpdate,
  };
});
