namespace go {{.ModuleName}}.{{.OriginalName}}

struct Add{{.JavaName}}Req {
{{- range .AddColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} // {{.ColumnComment}}
{{- end}}
}

struct Delete{{.JavaName}}Req {
    1: list<i64> Ids // id集合
}

struct Update{{.JavaName}}Req {
{{- range .UpdateColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} // {{.ColumnComment}}
{{- end}}
}

struct Update{{.JavaName}}StatusReq {
    1: list<i64> Ids // id集合
    2: i8 Status // 状态
}

struct Query{{.JavaName}}DetailReq {
    1: i64 Id //id
}

struct {{.JavaName}}Item {
{{- range .TableColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} // {{.ColumnComment}}
{{- end}}
}

struct Query{{.JavaName}}DetailResp {
    1: {{.JavaName}}Item data
    255: base.BaseResp baseResp
}


struct Query{{.JavaName}}ListReq {
{{- range .ListColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}}; // {{.ColumnComment}}
{{- end}}

}

struct Query{{.JavaName}}ListResp {
    1: {{.JavaName}}Item list
    2: i64 total
    255: base.BaseResp baseResp
}

service {{.UpperOriginalName}}Service {
    // 添加{{.Comment}}
    base.BaseResp Add{{.JavaName}}(1: Add{{.JavaName}}Req request);
    // 删除{{.Comment}}
    base.BaseResp Delete{{.JavaName}}(1: Delete{{.JavaName}}Req request);
    // 更新{{.Comment}}
    base.BaseResp Update{{.JavaName}}(1: Update{{.JavaName}}Req request);
    // 更新{{.Comment}}状态
    base.BaseResp Update{{.JavaName}}Status(1: Update{{.JavaName}}StatusReq request);
    // 查询{{.Comment}}详情
    Query{{.JavaName}}DetailResp Query{{.JavaName}}Detail(1: Query{{.JavaName}}DetailReq request);
    // 查询{{.Comment}}列表
    Query{{.JavaName}}ListResp Query{{.JavaName}}List(1: Query{{.JavaName}}ListReq request);
}
