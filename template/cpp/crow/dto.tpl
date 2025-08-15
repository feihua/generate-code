//
// Created by {{.Author}} on {{.CreateTime}}
//
#pragma once

#include <string>
#include <crow/json.h>

struct {{.JavaName}}Dto {

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

    [[nodiscard]] crow::json::wvalue toJson() const {
        crow::json::wvalue json;
        {{- range .TableColumn}}
        json["{{.JavaName}}"] = {{.JavaName}};
        {{- end}}
        return json;
    }

    static {{.JavaName}}Dto fromJson(const crow::json::rvalue &json) {
        {{.JavaName}}Dto dto;
        {{- range .TableColumn}}
        {{- if isContain .JavaName "create"}}
        {{- else if isContain .JavaName "update"}}
        {{- else if eq .JavaType `String` }}
        if (json.has("{{.JavaName}}")) {
            dto.{{.JavaName}} = json["{{.JavaName}}"].s();
        }
        {{- else}}
        if (json.has("{{.JavaName}}")) {
            dto.{{.JavaName}} = json["{{.JavaName}}"].i();
        }
        {{- end}}
        {{- end}}
        if (json.has("pageNo")) {
            dto.pageNo = json["pageNo"].i();
        }
        if (json.has("pageSize")) {
            dto.pageSize = json["pageSize"].i();
        }
        return dto;
    }

};
