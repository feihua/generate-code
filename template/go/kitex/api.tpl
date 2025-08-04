namespace go {{.ModuleName}}.{{.OriginalName}}

struct Add{{.JavaName}}Req {
{{- range .AddColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.body="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

struct Add{{.JavaName}}Resp {
    1: string RespBody;
}

struct Delete{{.JavaName}}Req {
    1: list<i64> Ids (api.body="ids"); // id集合
}

struct Delete{{.JavaName}}Resp {
    1: string RespBody;
}

struct Update{{.JavaName}}Req {
{{- range .UpdateColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.body="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

struct Update{{.JavaName}}Resp {
    1: string RespBody;
}

struct Update{{.JavaName}}StatusReq {
    1: list<i64> Ids (api.body="ids"); // id集合
    2: i8 Status (api.body="status"); // 状态
}

struct Update{{.JavaName}}StatusResp {
    1: string RespBody;
}

struct Query{{.JavaName}}DetailReq {
    1: i64 Id (api.query="id"); //id
}

struct Query{{.JavaName}}DetailResp {
{{- range .TableColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.query="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

struct Query{{.JavaName}}ListReq {
{{- range .ListColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.body="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

struct Query{{.JavaName}}ListResp {
{{- range .TableColumn}}
    {{.Sort}}: {{.ThriftType}} {{.GoName}} (api.query="{{.JavaName}}"); // {{.ColumnComment}}
{{- end}}
}

service {{.UpperOriginalName}}Service {
    Add{{.JavaName}}Resp Add{{.JavaName}}(1: Add{{.JavaName}}Req request) (api.post="/add{{.JavaName}}");
    Delete{{.JavaName}}Resp DeleteHello(1: Delete{{.JavaName}}Req request) (api.post="/delete{{.JavaName}}");
    Update{{.JavaName}}Resp Update{{.JavaName}}(1: Update{{.JavaName}}Req request) (api.post="/update{{.JavaName}}Req");
    Update{{.JavaName}}StatusResp Update{{.JavaName}}Status(1: Update{{.JavaName}}StatusReq request) (api.post="/update{{.JavaName}}StatusReq");
    Query{{.JavaName}}DetailResp Query{{.JavaName}}Detail(1: Query{{.JavaName}}DetailReq request) (api.post="/query{{.JavaName}}DetailReq");
    Query{{.JavaName}}ListResp Query{{.JavaName}}List(1: Query{{.JavaName}}ListReq request) (api.post="/query{{.JavaName}}ListReq");
}
