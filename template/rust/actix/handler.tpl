use actix_web::{post, Responder, Result, web};
use rbatis::rbdc::datetime::DateTime;
use rbatis::sql::{PageRequest};
use crate::AppState;

use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::vo::{err_result_page, handle_result, ok_result_page};
use crate::vo::{{.RustName}}_vo::{*};

// 添加{{.Comment}}
#[post("/{{.RustName}}_save")]
pub async fn {{.RustName}}_save(item: web::Json<{{.JavaName}}SaveReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_save params: {:?}", &item);
    let mut rb = &data.batis;

    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {
    {{range .TableColumn}}    {{.RustName}}: {{if eq .ColumnKey `PRI`}}None{{else if eq .RustType `DateTime`}}Some(DateTime::now()){{else}}req.{{.RustName}}{{end}},
    {{end}}
    };

    let result = {{.JavaName}}::insert(&mut rb, &{{.RustName}}).await;

    Ok(web::Json(handle_result(result)))
}

// 删除{{.Comment}}
#[post("/{{.RustName}}_delete")]
pub async fn {{.RustName}}_delete(item: web::Json<{{.JavaName}}DeleteReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_delete params: {:?}", &item);
    let mut rb = &data.batis;

    let result = {{.JavaName}}::delete_in_column(&mut rb, "id", &item.ids).await;

    Ok(web::Json(handle_result(result)))
}

// 更新{{.Comment}}
#[post("/{{.RustName}}_update")]
pub async fn {{.RustName}}_update(item: web::Json<{{.JavaName}}UpdateReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_update params: {:?}", &item);
    let mut rb = &data.batis;
    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {
    {{range .TableColumn}}    {{.RustName}}: {{if eq .RustType `DateTime`}}Some(DateTime::now()){{else}}req.{{.RustName}}{{end}},
    {{end}}
    };

    let result = {{.JavaName}}::update_by_column(&mut rb, &{{.RustName}}, "id").await;

    Ok(web::Json(handle_result(result)))
}

// 查询{{.Comment}}
#[post("/{{.RustName}}_list")]
pub async fn {{.RustName}}_list(item: web::Json<{{.JavaName}}ListReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_list params: {:?}", &item);
    let mut rb = &data.batis;

    let page=&PageRequest::new(item.page_no.clone(), item.page_size.clone());
    let result = {{.JavaName}}::select_page(&mut rb, page).await;

    let mut {{.RustName}}_list_data: Vec<{{.JavaName}}ListData> = Vec::new();

    match result {
        Ok(d) => {
            let total = d.total;



            for x in d.records {
                {{.RustName}}_list_data.push({{.JavaName}}ListData {
                    {{range .TableColumn}}    {{.RustName}}: {{if eq .IsNullable `YES` }}x.{{.RustName}}.unwrap_or_default(){{else if eq .RustType `DateTime`}}x.{{.RustName}}.unwrap().0.to_string(){{else}}x.{{.RustName}}{{end}},
                    {{end}}
                })
            }

            Ok(web::Json(ok_result_page({{.RustName}}_list_data, total)))
        }
        Err(err) => {
            Ok(web::Json(err_result_page({{.RustName}}_list_data, err.to_string())))
        }
    }

}
