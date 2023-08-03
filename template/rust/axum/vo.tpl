use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize)]
pub struct {{.JavaName}}SaveReq {
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else if eq .RustType `DateTime`}}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},
{{end}}
}

#[derive(Debug, Deserialize)]
pub struct {{.JavaName}}DeleteReq {
    pub ids: Vec<i32>,
}

#[derive(Debug, Deserialize)]
pub struct {{.JavaName}}UpdateReq {
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else if eq .RustType `DateTime`}}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},
{{end}}
}

#[derive(Debug, Deserialize)]
pub struct {{.JavaName}}ListReq {
    #[serde(rename = "current")]
    pub page_no: u64,
    #[serde(rename = "pageSize")]
    pub page_size: u64,
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else if eq .RustType `DateTime`}}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},
{{end}}
}

#[derive(Debug, Serialize)]
pub struct {{.JavaName}}ListResp {
    pub msg: String,
    pub code: i32,
    pub total: u64,
    pub data: Option<Vec{{.JavaName}}ListData>>,
}

#[derive(Debug, Serialize)]
pub struct {{.JavaName}}ListData {
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .RustType `DateTime`}}String{{else}}{{.RustType}}{{end}},
{{end}}
}
