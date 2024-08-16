import {ref} from 'vue'
import {defineStore} from 'pinia'
import type {List{{.JavaName}}Param, {{.JavaName}}RecordVo} from "../data";
import {query{{.JavaName}}List1} from "../service";

export const use{{.JavaName}}Store = defineStore('{{.LowerJavaName}}', () => {
    const page = ref({
        current: 1,
        pageSize: 10,
        total: 0
    })
    const {{.LowerJavaName}}List = ref<{{.JavaName}}RecordVo[]>([])

    function query{{.JavaName}}List(params: List{{.JavaName}}Param) {
        query{{.JavaName}}List1(params).then(res => {
            {{.LowerJavaName}}List.value = res.data
            page.value.current = params.current || 1
            page.value.pageSize = params.pageSize || 10
            page.value.total = res.total || 0
        })

    }


    return {page, {{.LowerJavaName}}List, query{{.JavaName}}List}
})
