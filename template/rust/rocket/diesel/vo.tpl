// Code generated by https://github.com/feihua/generate-code
// author：{{.Author}}
// createTime：{{.CreateTime}}

use serde::{Deserialize, Serialize};

/**
添加{{.Comment}}请求参数
*/
#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Add{{.JavaName}}Req {
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else}}
    #[serde(rename = "{{.JavaName}}")]
    {{if eq .IsNullable `YES` }}pub {{.RustName}}: Option<{{.RustType}}>{{else}}pub {{.RustName}}: {{.RustType}}{{end}}, //{{.ColumnComment}}
{{- end}}
{{- end}}
}

/**
删除{{.Comment}}请求参数
*/
#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Delete{{.JavaName}}Req {
    pub ids: Vec<i64>,
}

/**
更新{{.Comment}}请求参数
*/
#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Update{{.JavaName}}Req {
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else}}
    #[serde(rename = "{{.JavaName}}")]
    {{if eq .IsNullable `YES` }}pub {{.RustName}}: Option<{{.RustType}}>{{else}}pub {{.RustName}}: {{.RustType}}{{end}}, //{{.ColumnComment}}
{{- end}}
{{- end}}
}

/**
更新{{.Comment}}状态请求参数
*/
#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Update{{.JavaName}}StatusReq {
    pub ids: Vec<i64>,
    pub status: i8,
}

/**
查询{{.Comment}}详情请求参数
*/
#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Query{{.JavaName}}DetailReq {
    pub id: i64,
}

/**
查询{{.Comment}}详情响应参数
*/
#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Query{{.JavaName}}DetailResp {
{{- range .TableColumn}}
    #[serde(rename = "{{.JavaName}}")]
    pub {{.RustName}}: {{if eq .RustType "DateTime" }}String{{else}}{{.RustType}}{{end}}, //{{.ColumnComment}}
{{- end}}
}

/**
查询{{.Comment}}列表请求参数
*/
#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Query{{.JavaName}}ListReq {
    #[serde(rename = "current")]
    pub page_no: u64,
    #[serde(rename = "pageSize")]
    pub page_size: u64,
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if isContain .JavaName "remark"}}
{{- else if isContain .JavaName "sort"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else}}
    #[serde(rename = "{{.JavaName}}")]
    pub {{.RustName}}: Option<{{.RustType}}>, //{{.ColumnComment}}
{{- end}}
{{- end}}
}

/**
查询{{.Comment}}列表响应参数
*/
#[derive(Debug, Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct Query{{.JavaName}}ListDataResp {
{{- range .TableColumn}}
    #[serde(rename = "{{.JavaName}}")]
    pub {{.RustName}}: {{if eq .RustType "DateTime" }}String{{else}}{{.RustType}}{{end}}, //{{.ColumnComment}}
{{- end}}
}
