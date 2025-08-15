//
// Created by {{.Author}} on {{.CreateTime}}
//

#pragma once

#include "dto/{{.ModuleName}}/{{.GoName}}_dto.cpp"
#include <vector>
#include <optional>

/**
 * {{.Comment}}数据访问对象类
 * 提供对{{.Comment}}数据进行操作的方法，如创建、删除、更新和查询{{.Comment}}信息
 */
class {{.JavaName}}DAO {
public:

    /**
     * 创建新{{.Comment}}
     *
     * @param user 待创建的{{.Comment}}对象
     * @return 创建成功的{{.Comment}}对象，包括生成的{{.Comment}}ID等信息
     */
    int create(const {{.JavaName}}Dto &user);

    /**
     * 删除指定ID的{{.Comment}}
     *
     * @param ids 待删除{{.Comment}}的ID
     * @return 删除操作是否成功
     */
    void remove(const std::vector<int64_t> &ids);

    /**
     * 更新指定ID的{{.Comment}}信息
     *
     * @param id 待更新{{.Comment}}的ID
     * @param user 新的{{.Comment}}信息
     * @return 更新操作是否成功
     */
    int update(int64_t id, const {{.JavaName}}Dto &user);

    /**
     * 更新指定ID的{{.Comment}}状态
     *
     * @param ids 待更新{{.Comment}}的ID
     * @param status 新的{{.Comment}}状态
     * @return 更新操作是否成功
     */
    void updateStatus(const std::vector<int64_t> &ids, int64_t status);

    /**
     * 根据{{.Comment}}ID查找{{.Comment}}
     *
     * @param id 待查找{{.Comment}}的ID
     * @return 如果找到{{.Comment}}，则返回{{.Comment}}对象；否则返回std::nullopt
     */
    std::optional<crow::json::wvalue> findById(int64_t id);

    /**
     * 查找所有{{.Comment}}
     *
     * @param user 查询条件
     * @return 包含所有{{.Comment}}对象的向量
     */
    crow::json::wvalue findAll(const {{.JavaName}}Dto &user);

    /**
     * 查找所有{{.Comment}}
     *
     * @param user 查询条件
     * @return 包含所有{{.Comment}}对象的向量
     */
    crow::json::wvalue findByConditions(const crow::json::rvalue &conditions);
};
