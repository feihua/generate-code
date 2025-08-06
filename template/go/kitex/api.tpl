namespace go {{.ModuleName}}.{{.OriginalName}}

struct Add{{.JavaName}}Req {
{{- range .AddColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.body="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

struct {{.JavaName}}Resp {
    1: string code
    2: string msg
}

struct Delete{{.JavaName}}Req {
    1: list<i64> Ids (api.body="ids"); // id集合
}

struct Update{{.JavaName}}Req {
{{- range .UpdateColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.body="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

struct Update{{.JavaName}}StatusReq {
    1: list<i64> Ids (api.body="ids"); // id集合
    2: i8 Status (api.body="status"); // 状态
}

struct Query{{.JavaName}}DetailReq {
    1: i64 Id (api.query="id"); //id
}

struct {{.JavaName}}Data {
{{- range .TableColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.query="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

struct Query{{.JavaName}}DetailResp {
    1: {{.JavaName}}Data data
    2: string code
    3: string msg
}

struct Query{{.JavaName}}ListReq {
{{- range .ListColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.body="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

struct Query{{.JavaName}}ListResp {
    1: {{.JavaName}}Data list
    2: bool Success
    3: i64 Total
    4: i64 Current
    5: i64 PageSize
    6: string code
    7: string msg
}

service {{.UpperOriginalName}}Service {
  // 添加{{.Comment}}
    {{.JavaName}}Resp Add{{.JavaName}}(1: Add{{.JavaName}}Req request) (api.post="/add{{.JavaName}}");
  // 删除{{.Comment}}
    {{.JavaName}}Resp Delete{{.JavaName}}(1: Delete{{.JavaName}}Req request) (api.post="/delete{{.JavaName}}");
  // 更新{{.Comment}}
    {{.JavaName}}Resp Update{{.JavaName}}(1: Update{{.JavaName}}Req request) (api.post="/update{{.JavaName}}");
  // 更新{{.Comment}}状态
    {{.JavaName}}Resp Update{{.JavaName}}Status(1: Update{{.JavaName}}StatusReq request) (api.post="/update{{.JavaName}}Status");
  // 查询{{.Comment}}详情
    Query{{.JavaName}}DetailResp Query{{.JavaName}}Detail(1: Query{{.JavaName}}DetailReq request) (api.post="/query{{.JavaName}}Detail");
  // 查询{{.Comment}}列表
    Query{{.JavaName}}ListResp Query{{.JavaName}}List(1: Query{{.JavaName}}ListReq request) (api.post="/query{{.JavaName}}List");
}
