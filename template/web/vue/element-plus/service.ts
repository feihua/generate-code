import type {IResponse} from "@/api/ajax";
import type {AddParam, UpdateParam, ListParam} from "@/views/user/data";
import {axiosInstance} from "@/api/ajax";

/**
 * @description: 用户列表
 * @params {param} ListParam
 * @return {Promise}
 */
export const listData = (param: ListParam): Promise<IResponse> => {
    console.log(param)
    return axiosInstance.post('api/user_list', param).then(res => res.data);
};

/**
 * @description: 添加用户
 * @params {param} AddParam
 * @return {Promise}
 */
export const add = (param: AddParam): Promise<IResponse> => {
    return axiosInstance.post('api/user_save', param).then(res => res.data);
};

/**
 * @description: 更新用户
 * @params {{param} UpdateParam
 * @return {Promise}
 */
export const update = (param: UpdateParam): Promise<IResponse> => {
    return axiosInstance.post('api/user_update', param).then(res => res.data);
};

/**
 * @description: 删除用户
 * @params {ids} number[]
 * @return {Promise}
 */
export const remove = (ids: Number[]): Promise<IResponse> => {
    return axiosInstance.post('api/user_delete', {ids: ids}).then(res => res.data);
};

/**
 * @description: 查询用户角色
 * @params {ids} number[]
 * @return {Promise}
 */
export const query_user_role = (user_id: Number): Promise<IResponse> => {
    return axiosInstance.post('api/query_user_role', {user_id: user_id}).then(res => res.data);
};

/**
 * @description: 更新用户角色
 * @params {ids} number[]
 * @return {Promise}
 */
export const update_user_role = (user_id: Number, role_ids: Number[]): Promise<IResponse> => {
    return axiosInstance.post('api/update_user_role', {user_id: user_id, role_ids: role_ids}).then(res => res.data);
};

/**
 * 统一处理
 * @param resp
 */
export const handleResp = (resp: IResponse): boolean => {
    resp.code === 0 ? ElMessage.success(resp.msg) : ElMessage.error(resp.msg);
    return resp.code === 0
};