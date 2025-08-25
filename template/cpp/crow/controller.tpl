//
// Created by {{.Author}} on {{.CreateTime}}
//

#include "{{.GoName}}_controller.h"


void {{.JavaName}}Controller::registerRoutes(crow::SimpleApp &app) {

    /**
     * 添加{{.Comment}}
     *
     * @param {{.LowerJavaName}} 待创建的{{.Comment}}对象
     * @return 创建成功的{{.Comment}}对象，包括生成的{{.Comment}}ID等信息
     */
    CROW_ROUTE(app, "/api/{{.ModuleName}}/{{.LowerJavaName}}/add").methods("POST"_method)([this, &app](const crow::request &req) {
        LOG_INFO("添加{{.Comment}}，请求参数：" + req.body);
        try {
            auto json = crow::json::load(req.body);
            if (!json) return crow::response(400, "Invalid JSON");

            {{.JavaName}}Dto {{.LowerJavaName}} = {{.JavaName}}Dto::fromJson(json);
            {{.LowerJavaName}}.setCreateBy(app.get_context<AuthMiddleware>(req).username);
            auto id = {{.LowerJavaName}}Service.create{{.JavaName}}({{.LowerJavaName}});

            return ResponseUtil::success(id);
        } catch (const std::exception &e) {
            return ResponseUtil::serverError(e.what());
        }
    });

    /**
     * 删除指定ID的{{.Comment}}
     *
     * @param ids 待删除{{.Comment}}的ID集合
     * @return 删除操作是否成功
     */
    CROW_ROUTE(app, "/api/{{.ModuleName}}/{{.LowerJavaName}}/delete").methods("POST"_method)([this](const crow::request &req) {
        LOG_INFO("删除{{.Comment}}，请求参数：" + req.body);
        try {
            auto json = crow::json::load(req.body);
            if (!json) return crow::response(400, "Invalid JSON");

            std::vector<int64_t> ids;
            for (const auto &item: json["ids"]) {
                int64_t id = item.i();
                ids.push_back(id);
            }

            {{.LowerJavaName}}Service.delete{{.JavaName}}(ids);

            return ResponseUtil::success();
        } catch (const std::exception &e) {
            return ResponseUtil::serverError(e.what());
        }
    });

    /**
     * 更新指定ID的{{.Comment}}信息
     *
     * @param id 待更新{{.Comment}}的ID
     * @param {{.LowerJavaName}} 新的{{.Comment}}信息
     * @return 更新操作是否成功
     */
    CROW_ROUTE(app, "/api/{{.ModuleName}}/{{.LowerJavaName}}/update").methods("POST"_method)([this, &app](const crow::request &req) {
        LOG_INFO("更新{{.Comment}}，请求参数：" + req.body);
        try {
            auto json = crow::json::load(req.body);
            if (!json) return crow::response(400, "Invalid JSON");

            {{.JavaName}}Dto {{.LowerJavaName}} = {{.JavaName}}Dto::fromJson(json);
            {{.LowerJavaName}}.setUpdateBy(app.get_context<AuthMiddleware>(req).username);
            auto id = {{.LowerJavaName}}Service.update{{.JavaName}}({{.LowerJavaName}});

            return ResponseUtil::success(id);
        } catch (const std::exception &e) {
            return ResponseUtil::serverError(e.what());
        }
    });

    /**
     * 更新指定ID集合的{{.Comment}}状态
     *
     * @param ids 待更新{{.Comment}}的ID集合
     * @param status 新的{{.Comment}}状态
     * @return 更新操作是否成功
     */
    CROW_ROUTE(app, "/api/{{.ModuleName}}/{{.LowerJavaName}}/update{{.JavaName}}Status").methods("POST"_method)([this, &app](const crow::request &req) {
        LOG_INFO("更新{{.Comment}}状态，请求参数：" + req.body);
        try {
            auto json = crow::json::load(req.body);
            if (!json) return crow::response(400, "Invalid JSON");

            std::vector<int64_t> ids;
            for (const auto &item: json["ids"]) {
                ids.push_back(item.i());
            }

            auto status = json["status"].i();
            auto userName = app.get_context<AuthMiddleware>(req).username
            {{.LowerJavaName}}Service.update{{.JavaName}}Status(ids, status, userName);

            return ResponseUtil::success();
        } catch (const std::exception &e) {
            return ResponseUtil::serverError(e.what());
        }
    });

    /**
    * 根据{{.Comment}}ID查找{{.Comment}}
    *
    * @param id 待查找{{.Comment}}的ID
    * @return 如果找到{{.Comment}}，则返回{{.Comment}}对象；否则返回std::nullptr
    */
    CROW_ROUTE(app, "/api/{{.ModuleName}}/{{.LowerJavaName}}/findById/<int>").methods("GET"_method)([this](int id) {
        LOG_INFO("根据id获取{{.Comment}}，请求参数：" + std::to_string(id));
        try {

            auto {{.LowerJavaName}} = {{.LowerJavaName}}Service.findById(id);

            return ResponseUtil::success({{.LowerJavaName}}.toJson());
        } catch (const std::exception &e) {
            return ResponseUtil::serverError(e.what());
        }
    });


    /**
    * 查找所有{{.Comment}}
    *
    * @param {{.LowerJavaName}} 查询条件
    * @return 包含所有{{.Comment}}对象集合
    */
    CROW_ROUTE(app, "/api/{{.ModuleName}}/{{.LowerJavaName}}/findAll").methods("POST"_method)([this](const crow::request &req) {
        LOG_INFO("查询{{.Comment}}列表，请求参数：" + req.body);
        try {
            {{.JavaName}}Dto {{.LowerJavaName}}Dto;
            if (!req.body.empty()) {
                auto json = crow::json::load(req.body);
                if (!json) return crow::response(400, "Invalid JSON");
                {{.LowerJavaName}}Dto = {{.JavaName}}Dto::fromJson(json);
            }
            auto res = {{.LowerJavaName}}Service.findAll({{.LowerJavaName}}Dto);

            return ResponseUtil::success(res);
        } catch (const std::exception &e) {
            return ResponseUtil::serverError(e.what());
        }
    });

    /**
     * 查找所有{{.Comment}}
     *
     * @param {{.LowerJavaName}} 查询条件
     * @return 包含所有{{.Comment}}对象集合
     */
    CROW_ROUTE(app, "/api/{{.ModuleName}}/{{.LowerJavaName}}/search").methods("POST"_method)([this](const crow::request &req) {
        LOG_INFO("搜索{{.Comment}}列表，请求参数：" + req.body);
        try {
            auto json = crow::json::load(req.body);
            if (!json) {
                return crow::response(400, "Invalid JSON");
            }

            auto res = {{.LowerJavaName}}Service.findByConditions(json);

            return ResponseUtil::success(res);
        } catch (const std::exception &e) {
            return ResponseUtil::serverError(e.what());
        }
    });

}

