//
// Created by {{.Author}} on {{.CreateTime}}
//
#include "{{.GoName}}_dao.h"
#include "utils/db_connection.h"

/**
 * 创建新{{.Comment}}
 *
 * @param {{.LowerJavaName}} 待创建的{{.Comment}}对象
 * @return 创建成功的{{.Comment}}对象，包括生成的{{.Comment}}ID等信息
 */
int {{.JavaName}}DAO::create(const {{.JavaName}}Dto &{{.LowerJavaName}}) {
    auto conn = DBConnection::getConnection();

    pqxx::params params;
    {{- range .AddColumn}}
    params.append({{$.LowerJavaName}}.{{.JavaName}}); // {{.ColumnComment}}
    {{- end}}

    std::string sql = R"sql(INSERT INTO {{.OriginalName}}
    ({{- range .AddColumn}}{{.ColumnName}}, {{- end}})
    VALUES
    ({{- range .AddColumn}}${{.Sort}}, {{- end}}) RETURNING id)sql";

    pqxx::work txn(conn);
    auto result = txn.exec(sql, params);
    txn.commit();

    return result[0][0].as<int>();
}

/**
 * 删除指定ID的{{.Comment}}
 *
 * @param ids 待删除{{.Comment}}的ID
 * @return 删除操作是否成功
 */
void {{.JavaName}}DAO::remove(const std::vector<int64_t> &ids) {
    auto conn = DBConnection::getConnection();
    pqxx::work txn(conn);

    for (const auto &id: ids) {
        pqxx::params params;
        params.append(id);
        std::string sql = "DELETE FROM {{.OriginalName}} WHERE id = $1";
        auto result = txn.exec(sql, params);
    }

    txn.commit();
}

/**
 * 更新指定ID的{{.Comment}}信息
 *
 * @param id 待更新{{.Comment}}的ID
 * @param {{.LowerJavaName}} 新的{{.Comment}}信息
 * @return 更新操作是否成功
 */
int {{.JavaName}}DAO::update(int64_t id, const {{.JavaName}}Dto &{{.LowerJavaName}}) {
    auto conn = DBConnection::getConnection();

    pqxx::params params;
    {{- range .UpdateColumn}}
    params.append({{$.LowerJavaName}}.{{.JavaName}}); // {{.ColumnComment}}
    {{- end}}
    params.append(id);

    std::string sql = R"sql(UPDATE {{.OriginalName}} SET
    {{ range .UpdateColumn}}{{.ColumnName}}=${{.Sort}}, {{- end}} where id=$todo RETURNING id)sql";

    pqxx::work txn(conn);
    auto result = txn.exec(sql, params);
    txn.commit();

    return result[0][0].as<int>();
}

/**
 * 更新指定ID的{{.Comment}}状态
 *
 * @param ids 待更新{{.Comment}}的ID
 * @param status 新的{{.Comment}}状态
 * @return 更新操作是否成功
 */
void {{.JavaName}}DAO::updateStatus(const std::vector<int64_t> &ids, int64_t status) {
    auto conn = DBConnection::getConnection();
    pqxx::work txn(conn);

    for (const auto &id: ids) {
        pqxx::params params;
        params.append(status);
        params.append(id);

        std::string sql = "UPDATE {{.OriginalName}} SET status=$1 WHERE id = $2";

        auto result = txn.exec(sql, params);
    }

    txn.commit();
}

/**
 * 根据{{.Comment}}ID查找{{.Comment}}
 *
 * @param id 待查找{{.Comment}}的ID
 * @return 如果找到{{.Comment}}，则返回{{.Comment}}对象；否则返回std::nullopt
 */
std::optional<{{.JavaName}}Dto> {{.JavaName}}DAO::findById(int64_t id) {
    auto conn = DBConnection::getConnection();

    pqxx::params params;
    params.append(id);

    std::string sql = "SELECT * FROM {{.OriginalName}} WHERE id = $1";

    pqxx::work txn(conn);
    auto result = txn.exec(sql, params);
    txn.commit();

    if (result.empty()) {
        return std::nullopt;
    }

    auto row = result[0];
    {{.JavaName}}Dto dto;
    {{- range .TableColumn}}
    {{- if or (eq .JavaType `String`) (eq .JavaName `createTime`) }}
    dto.{{.JavaName}} = row[{{Sub .Sort 1}}].as<std::string>(); // {{.ColumnComment}}
    {{- else if eq .JavaName `updateTime` }}
    dto.{{.JavaName}} = row[{{Sub .Sort 1}}].is_null() ? "" : row[{{Sub .Sort 1}}].as<std::string>(); // {{.ColumnComment}}
    {{- else}}
    dto.{{.JavaName}} = row[{{Sub .Sort 1}}].as<int>(); // {{.ColumnComment}}
    {{- end}}
    {{- end}}

    return dto;
}

/**
 * 查找所有{{.Comment}}（支持分页）
 *
 * @param {{.LowerJavaName}} 查询条件
 * @return 包含所有{{.Comment}}对象
 */
crow::json::wvalue {{.JavaName}}DAO::findAll(const {{.JavaName}}Dto &{{.LowerJavaName}}) {

    auto conn = DBConnection::getConnection();
    pqxx::work txn{conn};

    pqxx::params sqlParams;
    std::string whereClause = " WHERE 1=1";
    std::string countSql = "SELECT COUNT(*) FROM {{.OriginalName}}";
    std::string selectSql = "SELECT * FROM {{.OriginalName}}";

    {{- range .ListColumn}}
    {{- if eq .JavaName `pageNo` }}
    {{- else if eq .JavaName `pageSize` }}
    {{- else if eq .JavaType `String` }}
    // {{.ColumnComment}}
    if (!{{$.LowerJavaName}}.{{.JavaName}}.empty()) {
        std::string param = "%" + std::string({{.LowerJavaName}}.{{.JavaName}}) + "%";
        sqlParams.append(param);

        whereClause += " AND {{.ColumnName}} LIKE $" + std::to_string(sqlParams.size());
    }
    {{- else}}
    // {{.ColumnComment}}
    if ({{$.LowerJavaName}}.{{.JavaName}} != 2) {
        sqlParams.append({{.LowerJavaName}}.{{.JavaName}});

        whereClause += " AND {{.ColumnName}} = $" + std::to_string(sqlParams.size());
    }
    {{- end}}
    {{- end}}

    countSql += whereClause;
    pqxx::result countResult = txn.exec(countSql, sqlParams);

    int64_t offset = ({{.LowerJavaName}}.pageNo - 1) * {{.LowerJavaName}}.pageSize;
    selectSql += whereClause + " ORDER BY id LIMIT $" + std::to_string(sqlParams.size() + 1)
           + " OFFSET $" + std::to_string(sqlParams.size() + 2);
    sqlParams.append({{.LowerJavaName}}.pageSize);
    sqlParams.append(offset);

    pqxx::result result = txn.exec(selectSql, sqlParams);
    txn.commit();

    std::vector<crow::json::wvalue> list;
    for (const auto &row: result) {
        crow::json::wvalue json;
        {{- range .TableColumn}}
        {{- if or (eq .JavaType `String`) (eq .JavaName `createTime`) }}
        json["{{.JavaName}}"] = row[{{Sub .Sort 1}}].as<std::string>(); // {{.ColumnComment}}
        {{- else if eq .JavaName `updateTime` }}
        json["{{.JavaName}}"] = row[{{Sub .Sort 1}}].is_null() ? "" : row[{{Sub .Sort 1}}].as<std::string>(); // {{.ColumnComment}}
        {{- else}}
        json["{{.JavaName}}"] = row[{{Sub .Sort 1}}].as<int>(); // {{.ColumnComment}}
        {{- end}}
        {{- end}}
        list.push_back(json);
    }

    crow::json::wvalue json;
    json["list"] = crow::json::wvalue::list(list.begin(), list.end());
    json["total"] = countResult[0][0].as<int>();

    return json;
}

crow::json::wvalue {{.JavaName}}DAO::findByConditions(const crow::json::rvalue &conditions) {

    auto conn = DBConnection::getConnection();
    pqxx::work txn(conn);

    std::string whereClause = " WHERE 1=1";
    std::string countSql = "SELECT COUNT(*) FROM {{.OriginalName}}";
    std::string selectSql = "SELECT * FROM {{.OriginalName}}";
    pqxx::params sqlParams;

    {{- range .ListColumn}}
    {{- if eq .JavaName `pageNo` }}
    {{- else if eq .JavaName `pageSize` }}
    {{- else if eq .JavaType `String` }}
    // {{.ColumnComment}}
    if (conditions.has("{{.JavaName}}") && conditions["{{.JavaName}}"].s() != "") {
        std::string param = conditions["{{.JavaName}}"].s();
        sqlParams.append("%" + param + "%");

        whereClause += " AND {{.ColumnName}} LIKE $" + std::to_string(sqlParams.size());
    }
    {{- else}}
    // {{.ColumnComment}}
    if (conditions.has("{{.JavaName}}")) {
        int64_t param = conditions["{{.JavaName}}"].i();
        sqlParams.append(param);

        whereClause += " AND {{.ColumnName}} = $" + std::to_string(sqlParams.size());
    }
    {{- end}}
    {{- end}}

    countSql += whereClause;
    pqxx::result countResult = txn.exec(countSql, sqlParams);

    if (conditions.has("pageNo") && conditions.has("pageSize")) {
        int64_t param = conditions["pageSize"].i();
        sqlParams.append(param);

        whereClause += " ORDER BY id LIMIT $" + std::to_string(sqlParams.size());

        int64_t pageNo = conditions["pageNo"].i();
        int64_t offset = (pageNo - 1) * param;
        sqlParams.append(offset);

        whereClause += " OFFSET $" + std::to_string(sqlParams.size());
    }

    selectSql += whereClause;
    pqxx::result result = txn.exec(selectSql, sqlParams);
    txn.commit();

    std::vector<crow::json::wvalue> list;
    for (const auto &row: result) {
        crow::json::wvalue json;
        {{- range .TableColumn}}
        {{- if or (eq .JavaType `String`) (eq .JavaName `createTime`) }}
        json["{{.JavaName}}"] = row[{{Sub .Sort 1}}].as<std::string>(); // {{.ColumnComment}}
        {{- else if eq .JavaName `updateTime` }}
        json["{{.JavaName}}"] = row[{{Sub .Sort 1}}].is_null() ? "" : row[{{Sub .Sort 1}}].as<std::string>(); // {{.ColumnComment}}
        {{- else}}
        json["{{.JavaName}}"] = row[{{Sub .Sort 1}}].as<int>(); // {{.ColumnComment}}
        {{- end}}
        {{- end}}
        list.push_back(json);
    }

    crow::json::wvalue json;
    json["list"] = crow::json::wvalue::list(list.begin(), list.end());
    json["total"] = countResult[0][0].as<int>();

    return json;
}
