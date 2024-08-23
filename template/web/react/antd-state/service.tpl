import type { IResponse } from '@/api/ajax'
import { axiosInstance } from '@/api/ajax'
import { {{.JavaName}}ListParam, {{.JavaName}}Vo } from './data';

/**
 * @description: 添加{{.Comment}}
 * @params {record} {{.JavaName}}Vo
 * @return {Promise}
 */
export const add{{.JavaName}} = async (params: {{.JavaName}}Vo): Promise<IResponse> => {
  const res = await axiosInstance.post('/api/demo/{{.LowerJavaName}}/add{{.JavaName}}', params);
  return res.data;
};

/**
 * @description: 删除{{.Comment}}
 * @params {ids} number[]
 * @return {Promise}
 */
export const remove{{.JavaName}} = async (ids: number[]): Promise<IResponse> => {
  const res = await axiosInstance.get('/api/demo/{{.LowerJavaName}}/delete{{.JavaName}}?ids=[' + ids + ']');
  return res.data;
};

/**
 * @description: 更新{{.Comment}}
 * @params {record} {{.JavaName}}Vo
 * @return {Promise}
 */
export const update{{.JavaName}} = async (params: {{.JavaName}}Vo): Promise<IResponse> => {
  const res = await axiosInstance.post('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}', params);
  return res.data;
};

/**
 * @description: 批量更新{{.Comment}}状态
 @params {ids} number[]
 @params { {{.LowerJavaName}}Status} number
 * @return {Promise}
 */
export const update{{.JavaName}}Status = async (params: { ids: number[]; {{.LowerJavaName}}Status: number }): Promise<IResponse> => {
  const res = await axiosInstance.post('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}Status', params);
  return res.data;
};

/**
 * @description: 查询{{.Comment}}详情
 * @params {id} number
 * @return {Promise}
 */
export const query{{.JavaName}}Detail = async (id: number): Promise<IResponse> => {
  const res = await axiosInstance.get('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}Detail?id=' + id);
  return res.data;
};

/**
 * @description: 分页查询{{.Comment}}列表
 * @params {params} {{.JavaName}}ListParam
 * @return {Promise}
 */
export const query{{.JavaName}}List1 = async (params: {{.JavaName}}ListParam): Promise<IResponse> => {
  const res = await axiosInstance.get('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}List', { params });
  return res.data;
};
