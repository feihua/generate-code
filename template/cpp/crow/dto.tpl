//
// Created by {{.Author}} on {{.CreateTime}}
//

#include "{{.GoName}}_dto.h"



 crow::json::wvalue {{.JavaName}}Dto::toJson() const {
    crow::json::wvalue json;
    {{- range .TableColumn}}
    json["{{.JavaName}}"] = {{.JavaName}};
    {{- end}}
    return json;
}

crow::json::wvalue {{.JavaName}}Dto::toJsonArr(const std::vector<{{.JavaName}}Dto>& items) {
    std::vector<crow::json::wvalue> list;
    for (const auto& item : items) {
        list.push_back(item.toJson());
    }
    return crow::json::wvalue::list(list.begin(), list.end());
}

{{.JavaName}}Dto {{.JavaName}}Dto::fromJson(const crow::json::rvalue &json) {
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


