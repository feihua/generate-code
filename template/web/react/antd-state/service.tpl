import {axiosInstance, IResponse} from "../../../api/ajax.ts";
import { {{.JavaName}}Vo, {{.JavaName}}ListParam} from "./data";
import {message} from "antd";

/**
 * @description: 添加{{.Comment}}
 * @params {record} {{.JavaName}}Vo
 * @return {Promise}
 */
export const add{{.JavaName}} = (params: {{.JavaName}}Vo): Promise<IResponse> => {
    return axiosInstance.post('/api/demo/{{.LowerJavaName}}/add{{.JavaName}}', params).then(res => res.data);
};

/**
 * @description: 删除{{.Comment}}
 * @params {ids} number[]
 * @return {Promise}
 */
export const remove{{.JavaName}} = (ids: number[]): Promise<IResponse> => {
    return axiosInstance.get('/api/demo/{{.LowerJavaName}}/delete{{.JavaName}}?ids=[' + ids + "]").then(res => res.data);
};


/**
 * @description: 更新{{.Comment}}
 * @params {record} {{.JavaName}}Vo
 * @return {Promise}
 */
export const update{{.JavaName}} = (params: {{.JavaName}}Vo): Promise<IResponse> => {
    return axiosInstance.post('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}', params).then(res => res.data);
};

/**
 * @description: 批量更新{{.Comment}}状态
 @params {ids} number[]
 @params { {{.LowerJavaName}}Status} number
 * @return {Promise}
 */
export const update{{.JavaName}}Status = (params: { ids: number[], {{.LowerJavaName}}Status: number }): Promise<IResponse> => {
    return axiosInstance.post('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}Status', params).then(res => res.data);
};

/**
 * @description: 查询{{.Comment}}详情
 * @params {id} number
 * @return {Promise}
 */
export const query{{.JavaName}}Detail = (id: number): Promise<IResponse> => {
    return axiosInstance.get('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}Detail?id=' + id).then(res => res.data);
};


/**
 * @description: 分页查询{{.Comment}}列表
 * @params {params} {{.JavaName}}ListParam
 * @return {Promise}
 */
export const query{{.JavaName}}List = (params: {{.JavaName}}ListParam): Promise<IResponse> => {
    return axiosInstance.get('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}List', {params}).then(res => res.data);
};


/**
 * 统一处理
 * @param resp
 */
export const handleResp = (resp: IResponse): boolean => {
    resp.code === 0 ? message.success(resp.msg) : message.error(resp.msg);
    return resp.code === 0
};