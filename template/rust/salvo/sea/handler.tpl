use rbatis::rbdc::datetime::DateTime;
use rbatis::sql::{PageRequest};
use salvo::{Request, Response};
use salvo::prelude::*;

use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::RB;
use crate::vo::{err_result_page, handle_result, ok_result_page};
use crate::vo::{{.RustName}}_vo::*;


// 添加{{.Comment}}
#[handler]
pub async fn {{.RustName}}_save(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<{{.JavaName}}SaveReq>().await.unwrap();
    log::info!("{{.RustName}}_save params: {:?}", &item);

    let {{.RustName}} = {{.JavaName}} {
    {{range .TableColumn}}    {{.RustName}}: {{if eq .ColumnKey `PRI`}}None{{else if eq .RustType `DateTime`}}Some(DateTime::now()){{else}}item.{{.RustName}}{{end}},
    {{end}}
    };

    let result = {{.JavaName}}::insert(&mut RB.clone(), &{{.RustName}}).await;

    res.render(Json(handle_result(result)))
}

// 删除{{.Comment}}
#[handler]
pub async fn {{.RustName}}_delete(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<{{.JavaName}}DeleteReq>().await.unwrap();
    log::info!("{{.RustName}}_delete params: {:?}", &item);

    let result = {{.JavaName}}::delete_in_column(&mut RB.clone(), "id", &item.ids).await;

    res.render(Json(handle_result(result)))
}

// 更新{{.Comment}}
#[handler]
pub async fn {{.RustName}}_update(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<{{.JavaName}}UpdateReq>().await.unwrap();
    log::info!("{{.RustName}}_update params: {:?}", &item);

    let {{.RustName}} = {{.JavaName}} {
    {{range .TableColumn}}    {{.RustName}}: {{if eq .RustType `DateTime`}}Some(DateTime::now()){{else}}item.{{.RustName}}{{end}},
    {{end}}
    };

    let result = {{.JavaName}}::update_by_column(&mut RB.clone(), &{{.RustName}}, "id").await;

    res.render(Json(handle_result(result)))
}

// 查询{{.Comment}}
#[handler]
pub async fn {{.RustName}}_list(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<{{.JavaName}}ListReq>().await.unwrap();
    log::info!("{{.RustName}}_list params: {:?}", &item);

    let page=&PageRequest::new(item.page_no, item.page_size);
    let result = {{.JavaName}}::select_page(&mut RB.clone(), page).await;

    match result {
        Ok(d) => {
            let total = d.total;

            let mut {{.RustName}}_list_data: Vec<{{.JavaName}}ListData> = Vec::new();

            for x in d.records {
                {{.RustName}}_list_data.push({{.JavaName}}ListData {
                    {{range .TableColumn}}    {{.RustName}}: {{if eq .IsNullable `YES` }}x.{{.RustName}}.unwrap_or_default(){{else if eq .RustType `DateTime`}}x.{{.RustName}}.unwrap().0.to_string(){{else}}x.{{.RustName}}{{end}},
                    {{end}}
                })
            }

            res.render(Json(ok_result_page({{.RustName}}_list_data, total)))
        }
        Err(err) => {
            res.render(Json(err_result_page(err.to_string())))
        }
    }

}
