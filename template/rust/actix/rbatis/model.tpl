// Code generated by https://github.com/feihua/generate-code
// author：{{.Author}}
// createTime：{{.CreateTime}}

use rbatis::rbdc::datetime::DateTime;
use serde::{Deserialize, Serialize};

/**
 *{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct {{.JavaName}} {
{{- range .TableColumn}}
{{- if eq .IsNullable `YES` }}
    pub {{.RustName}}: Option<{{.RustType}}>
{{- else if eq .RustType `DateTime`}}
    pub {{.RustName}}: Option<{{.RustType}}>
{{- else if eq .ColumnKey `PRI`}}
    pub {{.RustName}}: Option<{{.RustType}}>
{{- else}}
    pub {{.RustName}}: {{.RustType}}
{{- end}},//{{.ColumnComment}}
{{- end}}
}

/**
 *{{.Comment}}基本操作
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
rbatis::crud!({{.JavaName}} {},"{{.OriginalName}}");

/**
 *根据id查询{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
impl_select!({{.JavaName}}{select_by_id(id:&i32) -> Option => "`where id = #{id} limit 1`"}, "{{.OriginalName}}");

/**
 *分页查询{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
impl_select_page!({{.JavaName}}{select_page() =>"
     if !sql.contains('count'):
       order by create_time desc"
},"{{.OriginalName}}");

/**
 *根据条件分页查询{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
impl_select_page!({{.JavaName}}{select_page_by_name(name:&str) =>"
     if name != null && name != '':
       where real_name != #{name}
     if name == '':
       where real_name != ''"
},"{{.OriginalName}}");