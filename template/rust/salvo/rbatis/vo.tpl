use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
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

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}DeleteReq {
    pub ids: Vec<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
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

#[derive(Debug, Serialize, Deserialize)]
pub struct Update{{.JavaName}}StatusReq {
    pub ids: Vec<i32>,
    pub status: i32,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Query{{.JavaName}}DetailReq {
    pub id: i32,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Query{{.JavaName}}DetailResp {
{{- range .TableColumn}}
    #[serde(rename = "{{.JavaName}}")]
    pub {{.RustName}}: {{.RustType}}, //{{.ColumnComment}}
{{- end}}
}

#[derive(Debug, Serialize, Deserialize)]
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
    {{if eq .IsNullable `YES` }}pub {{.RustName}}: Option<{{.RustType}}>{{else}}pub {{.RustName}}: {{.RustType}}{{end}}, //{{.ColumnComment}}
{{- end}}
{{- end}}
}

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}ListDataResp {
{{- range .TableColumn}}
    #[serde(rename = "{{.JavaName}}")]
    pub {{.RustName}}: {{.RustType}}, //{{.ColumnComment}}
{{- end}}
}
