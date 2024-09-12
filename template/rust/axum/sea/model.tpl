use rbatis::rbdc::datetime::DateTime;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct {{.JavaName}} {
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}>{{else if eq .RustType `DateTime`}}Option<{{.RustType}}>{{else if eq .ColumnKey `PRI`}}Option<{{.RustType}}>{{else}}{{.RustType}}{{end}},
{{end}}
}

rbatis::crud!({{.JavaName}} {},"{{.OriginalName}}");
impl_select_page!({{.JavaName}}{select_page() =>"
     if !sql.contains('count'):
       order by gmt_create desc"
},"{{.OriginalName}}");

impl_select_page!({{.JavaName}}{select_page_by_name(name:&str) =>"
     if name != null && name != '':
       where real_name != #{name}
     if name == '':
       where real_name != ''"
},"{{.OriginalName}}");