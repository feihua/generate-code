use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct {{.JavaName}}SaveReq {
{{range .TableColumn}}    pub {{.RustName}}: {{.RustType}},
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
{{range .TableColumn}}    pub {{.RustName}}: {{.RustType}},
{{end}}
}

#[derive(Debug, Deserialize)]
#[serde(crate = "rocket::serde")]
pub struct {{.JavaName}}ListReq {
{{range .TableColumn}}    pub {{.RustName}}: Option<{{.RustType}}>,
{{end}}
}

#[derive(Debug, Serialize)]
#[serde(crate = "rocket::serde")]
pub struct {{.JavaName}}ListResp {
    pub msg: String,
    pub code: i32,
    pub total: u64,
    pub data: Option<Vec<{{.JavaName}}ListData>>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct {{.JavaName}}ListData {
{{range .TableColumn}}    pub {{.RustName}}: {{.RustType}},
{{end}}
}