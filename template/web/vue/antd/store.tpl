import {ref} from 'vue'
import {defineStore} from 'pinia'
import type {List{{.JavaName}}Param, {{.JavaName}}RecordVo} from "../data";
import {query{{.JavaName}}List1} from "../service";

export const use{{.JavaName}}Store = defineStore('{{.LowerJavaName}}', () => {
    const listParam = ref<List{{.JavaName}}Param>({
        current: 1,
        pageSize: 10,
      });
    const {{.LowerJavaName}}List = ref<{{.JavaName}}RecordVo[]>([])

    function query{{.JavaName}}List(params: List{{.JavaName}}Param) {
        delete params.total;
        listParam.value = params;
        query{{.JavaName}}List1(params).then(res => {
            {{.LowerJavaName}}List.value = res.data
            listParam.value.total = res.total || 0;
        })

    }


    return {listParam, {{.LowerJavaName}}List, query{{.JavaName}}List}
})
