use actix_web::{post, Responder, Result, web};
use rbatis::rbdc::datetime::FastDateTime;
use rbatis::sql::{PageRequest};
use crate::AppState;

use crate::model::entity::{ {{.JavaName}} };
use crate::vo::handle_result;
use crate::vo::{{.RustName}}_vo::{*};


#[post("/{{.RustName}}_list")]
pub async fn {{.RustName}}_list(item: web::Json<{{.JavaName}}ListReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_list params: {:?}", &item);
    let mut rb = &data.batis;

    let page=&PageRequest::new(item.page_no, item.page_size);
    let result = {{.JavaName}}::select_page(&mut rb, page).await;

    let resp = match result {
                Ok(d) => {
                    let total = d.total;
                    let page_no = d.page_no;
                    let page_size = d.page_size;

                    let mut {{.RustName}}_list: Vec<{{.JavaName}}ListData> = Vec::new();

                    for x in d.records {
                        {{.RustName}}_list.push({{.JavaName}}ListData {

                        })
                    }

                    {{.JavaName}}ListResp {
                        msg: "successful".to_string(),
                        code: 0,
                        page_no,
                        page_size,
                        success: true,
                        total,
                        data: Some({{.RustName}}_list),
                    }
                }
                Err(err) => {
                    {{.JavaName}}ListResp {
                        msg: err.to_string(),
                        code: 1,
                        page_no: 0,
                        page_size: 0,
                        success: true,
                        total: 0,
                        data: None,
                    }
                }
            };

    Ok(web::Json(resp))
}

#[post("/{{.RustName}}_save")]
pub async fn {{.RustName}}_save(item: web::Json<{{.JavaName}}SaveReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_save params: {:?}", &item);
    let mut rb = &data.batis;

    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {

    };

    let result = {{.JavaName}}::insert(&mut rb, &{{.RustName}}).await;

    Ok(web::Json(handle_result(result)))
}

#[post("/{{.RustName}}_update")]
pub async fn {{.RustName}}_update(item: web::Json<{{.JavaName}}UpdateReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_update params: {:?}", &item);
    let mut rb = &data.batis;
    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {

    };

    let result = {{.JavaName}}::update_by_column(&mut rb, &{{.RustName}}, "id").await;

    Ok(web::Json(handle_result(result)))
}


#[post("/{{.RustName}}_delete")]
pub async fn {{.RustName}}_delete(item: web::Json<{{.JavaName}}DeleteReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_delete params: {:?}", &item);
    let mut rb = &data.batis;

    let result = {{.JavaName}}::delete_in_column(&mut rb, "id", &item.ids).await;

    Ok(web::Json(handle_result(result)))
}