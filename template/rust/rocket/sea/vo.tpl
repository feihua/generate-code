use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct {{.JavaName}}SaveReq {
{{range .TableColumn}}    {{if ne .RustType `DateTime`}}pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},{{end}}
{{end}}
}

#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct {{.JavaName}}DeleteReq {
    pub ids: Vec<i32>,
}

#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct {{.JavaName}}UpdateReq {
{{range .TableColumn}}    {{if ne .RustType `DateTime`}}pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else if eq .ColumnKey `PRI`}}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},{{end}}
{{end}}
}

#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct {{.JavaName}}ListReq {
    #[serde(rename = "current")]
    pub page_no: u64,
    #[serde(rename = "pageSize")]
    pub page_size: u64,
{{range .TableColumn}}    {{if ne .RustType `DateTime`}}pub {{.RustName}}: Option<{{.RustType}}>,{{end}}
{{end}}
}

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}ListData {
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .RustType `DateTime`}}String{{else if eq .ColumnKey `PRI`}}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},
{{end}}
}