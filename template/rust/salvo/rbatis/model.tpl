// Code generated by https://github.com/feihua/generate-code
// author：{{.Author}}
// createTime：{{.CreateTime}}

use rbatis::rbdc::datetime::DateTime;
use serde::{Deserialize, Serialize};

/**
{{.Comment}}
*/
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct {{.JavaName}} {
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else if eq .RustType `DateTime`}}Option<{{.RustType}}>{{else if eq .ColumnKey `PRI`}}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},//{{.ColumnComment}}
{{end}}
}

/**
{{.Comment}}基本操作
*/
rbatis::crud!({{.JavaName}} {},"{{.OriginalName}}");

/**
分页查询{{.Comment}}
*/
impl_select_page!({{.JavaName}}{select_page() =>"
     if !sql.contains('count'):
       order by create_time desc"
},"{{.OriginalName}}");

/**
根据条件分页查询{{.Comment}}
*/
impl_select_page!({{.JavaName}}{select_page_by_name(name:&str) =>"
     if name != null && name != '':
       where real_name != #{name}
     if name == '':
       where real_name != ''"
},"{{.OriginalName}}");