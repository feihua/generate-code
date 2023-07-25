use rbatis::rbatis::Rbatis;
use rbatis::rbdc::datetime::FastDateTime;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct {{.JavaName}} {
{{range .TableColumn}}    pub {{.RustName}}: {{if eq .IsNullable `YES` }}Option<{{.RustType}}> {{else}}{{.RustType}} {{end}},
{{end}}
}

rbatis::crud!({{.JavaName}} {});
impl_select_page!({{.JavaName}}{select_page() =>"
     if !sql.contains('count'):
       order by gmt_create desc"
});

impl_select_page!({{.JavaName}}{select_page_by_name(name:&str) =>"
     if name != null && name != '':
       where real_name != #{name}
     if name == '':
       where real_name != ''"
});