import {request} from 'umi';
import type { {{.JavaName}}ListParams, {{.JavaName}}ListItem } from './data.d';

// 添加{{.Comment}}
export async function add{{.JavaName}}(params: {{.JavaName}}ListItem) {
  return request('/api/demo/{{.LowerJavaName}}/add{{.JavaName}}', {
    method: 'POST',
    data: {
      ...params,
    },
  });
}

// 删除{{.Comment}}
export async function remove{{.JavaName}}(ids: number[]) {
  return request('/api/demo/{{.LowerJavaName}}/delete{{.JavaName}}?ids=[' + ids + "]", {
    method: 'GET',
  });
}


// 更新{{.Comment}}
export async function update{{.JavaName}}(params: {{.JavaName}}ListItem) {
  return request('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}', {
    method: 'POST',
    data: {
      ...params,
    },
  });
}

// 批量更新{{.Comment}}状态
export async function update{{.JavaName}}Status(params: { {{.LowerJavaName}}Ids: number[], {{.LowerJavaName}}Status: number }) {
  return request('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}Status', {
    method: 'POST',
    data: {
      ...params,
    },

  });
}


// 查询{{.Comment}}详情
export async function query{{.JavaName}}Detail(id: number) {
  return request('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}Detail?id=' + id, {
    method: 'GET',
  });
}

// 分页查询{{.Comment}}列表
export async function query{{.JavaName}}List(params: {{.JavaName}}ListParams) {

  return request('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}List', {
    method: 'GET',
    params: {
      ...params,
    },
  });
}
