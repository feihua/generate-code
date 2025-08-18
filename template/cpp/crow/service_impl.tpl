//
// Created by {{.Author}} on {{.CreateTime}}
//

#include "{{.GoName}}_service.h"

/**
 * 创建新{{.Comment}}
 *
 * @param {{.LowerJavaName}} 待创建的{{.Comment}}对象
 * @return 创建成功的{{.Comment}}对象，包括生成的{{.Comment}}ID等信息
 */
int {{.JavaName}}Service::create{{.JavaName}}(const {{.JavaName}}Dto &{{.LowerJavaName}}) {
    return {{.LowerJavaName}}Dao.create({{.LowerJavaName}});
}

/**
 * 删除指定ID的{{.Comment}}
 *
 * @param id 待删除{{.Comment}}的ID
 * @return 删除操作是否成功
 */
void {{.JavaName}}Service::delete{{.JavaName}}(const std::vector<int64_t> &id) {
    return {{.LowerJavaName}}Dao.remove(id);
}

/**
 * 更新指定ID的{{.Comment}}信息
 *
 * @param id 待更新{{.Comment}}的ID
 * @param {{.LowerJavaName}} 新的{{.Comment}}信息
 * @return 更新操作是否成功
 */
int {{.JavaName}}Service::update{{.JavaName}}(const {{.JavaName}}Dto &{{.LowerJavaName}}) {
    auto exist = {{.LowerJavaName}}Dao.findById({{.LowerJavaName}}.id);
    if (!exist) {
        throw std::runtime_error("{{.JavaName}}Dto not found");
    }
    return {{.LowerJavaName}}Dao.update({{.LowerJavaName}}.id, {{.LowerJavaName}});
}

/**
 * 更新指定ID的{{.Comment}}状态
 *
 * @param ids 待更新{{.Comment}}的ID
 * @param status 新的{{.Comment}}状态
 * @return 更新操作是否成功
 */
void {{.JavaName}}Service::update{{.JavaName}}Status(const std::vector<int64_t> &ids, int64_t status) {
    return {{.LowerJavaName}}Dao.updateStatus(ids, status);
}

/**
 * 根据{{.Comment}}ID查找{{.Comment}}
 *
 * @param id 待查找{{.Comment}}的ID
 * @return 如果找到{{.Comment}}，则返回{{.Comment}}对象；否则返回std::nullopt
 */
{{.JavaName}}Dto {{.JavaName}}Service::findById(int64_t id) {
    auto {{.LowerJavaName}} = {{.LowerJavaName}}Dao.findById(id);
    if (!{{.LowerJavaName}}) {
        throw std::runtime_error("{{.JavaName}}Dto not found");
    }
    return {{.LowerJavaName}}.value();
}

/**
 * 查找所有{{.Comment}}
 *
 * @param {{.LowerJavaName}} 查询条件
 * @return 包含所有{{.Comment}}对象集合
 */
crow::json::wvalue {{.JavaName}}Service::findAll(const {{.JavaName}}Dto &{{.LowerJavaName}}) {
    return {{.LowerJavaName}}Dao.findAll({{.LowerJavaName}});
}

/**
 * 查找所有{{.Comment}}
 *
 * @param {{.LowerJavaName}} 查询条件
 * @return 包含所有{{.Comment}}对象集合
 */
crow::json::wvalue {{.JavaName}}Service::findByConditions(const crow::json::rvalue &conditions) {

    return {{.LowerJavaName}}Dao.findByConditions(conditions);

}
