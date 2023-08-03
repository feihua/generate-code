use rbatis::rbdc::datetime::DateTime;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}SaveReq {
{{range .TableColumn}}    {{if ne .RustType `DateTime`}}pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},{{end}}
{{end}}
}

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}DeleteReq {
    pub ids: Vec<i32>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}UpdateReq {
{{range .TableColumn}}    {{if ne .RustType `DateTime`}}pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},{{end}}
{{end}}
}

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}ListReq {
    #[serde(rename = "current")]
    pub page_no: u64,
    #[serde(rename = "pageSize")]
    pub page_size: u64,
{{range .TableColumn}}    {{if ne .RustType `DateTime`}}pub {{.RustName}}: Option<{{.RustType}}>,{{end}}
{{end}}
}

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}ListResp {
    pub msg: String,
    pub code: i32,
    pub success: bool,
    pub total: u64,
    pub data: Option<Vec<{{.JavaName}}ListData>>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}ListData {
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .RustType `DateTime`}}String{{else}}{{.RustType}}{{end}},
{{end}}
}
