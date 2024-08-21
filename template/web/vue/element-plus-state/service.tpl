import type { IResponse } from '@/api/ajax'
import { axiosInstance } from '@/api/ajax'
import type {Add{{.JavaName}}Param, Update{{.JavaName}}Param, List{{.JavaName}}Param, Update{{.JavaName}}StatusParam, Delete{{.JavaName}}Param} from "./data";

/**
 * @description: 添加{{.Comment}}
 * @params {params} Add{{.JavaName}}Param
 * @return {Promise}
 */
export const add{{.JavaName}} = async (params: Add{{.JavaName}}Param): Promise<IResponse> => {
  return axiosInstance.post('/api/demo/{{.LowerJavaName}}/add{{.JavaName}}', params).then(res => res.data);
};

/**
 * @description: 删除{{.Comment}}
 * @params {ids} number[]
 * @return {Promise}
 */
export const remove{{.JavaName}} = async (params: Delete{{.JavaName}}Param): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{.LowerJavaName}}/delete{{.JavaName}}?ids=[' + params.ids + "]").then(res => res.data);
};


/**
 * @description: 修改{{.Comment}}
 * @params {params} Update{{.JavaName}}Param
 * @return {Promise}
 */
export const update{{.JavaName}} = async (params: Update{{.JavaName}}Param): Promise<IResponse> => {
  return axiosInstance.post('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}', params).then(res => res.data);
};

/**
 * @description: 批量修改{{.Comment}}状态
 @params {ids} number[
 @params { {{.LowerJavaName}}Status} number
 * @return {Promise}
 */
export const update{{.JavaName}}Status = async (params: Update{{.JavaName}}StatusParam): Promise<IResponse> => {
  return axiosInstance.post('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}Status', params).then(res => res.data);
};

/**
 * @description: 查询{{.Comment}}详情
 * @params {id} number
 * @return {Promise}
 */
export const query{{.JavaName}}Detail1 = async (id: number): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}Detail?id=' + id).then(res => res.data);
};


/**
 * @description: 分页查询{{.Comment}}列表
 * @params {params} List{{.JavaName}}Param
 * @return {Promise}
 */
export const query{{.JavaName}}List1 = async(params: List{{.JavaName}}Param): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}List', {params}).then(res => res.data);
};
