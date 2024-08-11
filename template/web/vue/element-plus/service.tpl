import type {IResponse} from "@/api/ajax";
import type {Add{{.JavaName}}Param, Update{{.JavaName}}Param, List{{.JavaName}}Param} from "./data";
import {axiosInstance} from "@/api/ajax";
import { ElMessage } from 'element-plus'

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
export const remove{{.JavaName}} = async (ids: Number[]): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{.LowerJavaName}}/delete{{.JavaName}}?ids=[' + ids + "]").then(res => res.data);
};


/**
 * @description: 更新{{.Comment}}
 * @params {params} Update{{.JavaName}}Param
 * @return {Promise}
 */
export const update{{.JavaName}} = async (params: Update{{.JavaName}}Param): Promise<IResponse> => {
  return axiosInstance.post('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}', params).then(res => res.data);
};

/**
 * @description: 批量更新{{.Comment}}状态
 @params {ids} number[]
 @params { {{.LowerJavaName}}Status} number
 * @return {Promise}
 */
export const update{{.JavaName}}Status = async (params: { ids: number[], {{.LowerJavaName}}Status: number }): Promise<IResponse> => {
  return axiosInstance.post('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}Status', params).then(res => res.data);
};

/**
 * @description: 查询{{.Comment}}详情
 * @params {id} number
 * @return {Promise}
 */
export const query{{.JavaName}}Detail = async (id: number): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}Detail?id=' + id).then(res => res.data);
};


/**
 * @description: 分页查询{{.Comment}}列表
 * @params {params} List{{.JavaName}}Param
 * @return {Promise}
 */
export const query{{.JavaName}}List = async(params: List{{.JavaName}}Param): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}List', {params}).then(res => res.data);
};


/**
 * 统一处理
 * @param resp
 */
export const handleResp = (resp: IResponse): boolean => {
  resp.code === 0 ? ElMessage.success(resp.msg) : ElMessage.error(resp.msg);
  return resp.code === 0
};