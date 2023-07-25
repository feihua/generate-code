use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize)]
pub struct {{.JavaName}}SaveReq {
{{range .TableColumn}}    pub {{.RustName}}: {{.RustType}},
{{end}}

#[derive(Debug, Deserialize)]
pub struct {{.JavaName}}DeleteReq {
    pub ids: Vec<i32>,
}

#[derive(Debug, Deserialize)]
pub struct {{.JavaName}}UpdateReq {
{{range .TableColumn}}    pub {{.RustName}}: {{.RustType}},
{{end}}
}

#[derive(Debug, Deserialize)]
pub struct {{.JavaName}}ListReq {
{{range .TableColumn}}    pub {{.RustName}}: {{.RustType}},
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
{{range .TableColumn}}    pub {{.RustName}}: {{.RustType}},
{{end}}
}
