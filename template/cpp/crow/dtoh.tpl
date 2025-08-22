//
// Created by {{.Author}} on {{.CreateTime}}
//
#pragma once

#include <string>
#include <crow/json.h>

class {{.JavaName}}Dto {
private:
    int64_t pageNo{}; // 页码
    int64_t pageSize{}; // 每页大小
{{- range .TableColumn}}
    {{- if eq .JavaType `String` }}
    std::string {{.JavaName}}{}; // {{.ColumnComment}}
    {{- else if isContain .JavaName "create"}}
    std::string {{.JavaName}}{}; // {{.ColumnComment}}
    {{- else if isContain .JavaName "update"}}
    std::string {{.JavaName}}{}; // {{.ColumnComment}}
    {{- else}}
    int64_t {{.JavaName}}{}; // {{.ColumnComment}}
    {{- end}}
{{- end}}

public:
    {{.JavaName}}Dto() = default;
    [[nodiscard]] crow::json::wvalue toJson() const;

    static crow::json::wvalue toJsonArr(const std::vector<{{.JavaName}}Dto>& items);

    static {{.JavaName}}Dto fromJson(const crow::json::rvalue &json);

{{- range .TableColumn}}
    {{- if or (eq .JavaType `String`) (isContain .JavaName "create") (isContain .JavaName "update") }}
    [[nodiscard]] const std::string &get{{.GoNamePublic}}() const {
        return {{.JavaName}};
    }

    void set{{.GoNamePublic}}(const std::string &{{.JavaName}}) {
        {{$.JavaName}}Dto::{{.JavaName}} = {{.JavaName}};
    }
    {{- else}}
    [[nodiscard]] int64_t get{{.GoNamePublic}}() const {
        return {{.JavaName}};
    }

    void set{{.GoNamePublic}}(int64_t {{.JavaName}}) {
        {{$.JavaName}}Dto::{{.JavaName}} = {{.JavaName}};
    }
    {{- end}}
{{- end}}
};
