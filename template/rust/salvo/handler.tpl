use rbatis::rbdc::datetime::DateTime;
use rbatis::sql::{PageRequest};
use salvo::{Request, Response};
use salvo::prelude::*;

use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::RB;
use crate::vo::handle_result;
use crate::vo::{{.RustName}}_vo::*;


// 添加{{.Comment}}
#[handler]
pub async fn {{.RustName}}_save(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<{{.JavaName}}SaveReq>().await.unwrap();
    log::info!("{{.RustName}}_save params: {:?}", &item);

    let {{.RustName}} = {{.JavaName}} {
    {{range .TableColumn}}    {{.RustName}}: item.{{.RustName}},
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
    {{range .TableColumn}}    {{.RustName}}: item.{{.RustName}},
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

    let resp = match result {
        Ok(d) => {
            let total = d.total;

            let mut {{.RustName}}_list_res: Vec<{{.JavaName}}ListData> = Vec::new();

            for x in d.records {
                {{.RustName}}_list_res.push({{.JavaName}}ListData {
                    {{range .TableColumn}}    {{.RustName}}: {{if eq .IsNullable `YES` }}x.{{.RustName}}.unwrap_or_default(){{else if eq .RustType `DateTime`}}x.{{.RustName}}.unwrap().0.to_string(){{else}}x.{{.RustName}}{{end}},
                    {{end}}
                })
            }

            {{.JavaName}}ListResp {
                msg: "successful".to_string(),
                code: 0,
                success: true,
                total,
                data: Some({{.RustName}}_list_res),
            }
        }
        Err(err) => {
            {{.JavaName}}ListResp {
                msg: err.to_string(),
                code: 1,
                success: false,
                total: 0,
                data: None,
            }
        }
    };

    res.render(Json(resp))
}
