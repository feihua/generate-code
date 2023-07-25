use actix_web::{post, Responder, Result, web};
use rbatis::rbdc::datetime::FastDateTime;
use rbatis::sql::{PageRequest};
use crate::AppState;

use crate::model::entity::{SysMenu};
use crate::vo::handle_result;
use crate::vo::{{.RustName}}_vo::{*};


#[post("/{{.RustName}}_list")]
pub async fn {{.RustName}}_list(item: web::Json<{{.JavaName}}ListReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_list params: {:?}", &item);
    let mut rb = &data.batis;

    let result = {{.JavaName}}::select_page(&mut rb, &PageRequest::new(1, 1000)).await;

    let resp = match result {
        Ok(d) => {
            let total = d.total;

            let mut {{.RustName}}_list: Vec<{{.JavaName}}ListData> = Vec::new();

            for x in d.records {
                {{.RustName}}_list.push(MenuListData {

                })
            }
            {{.JavaName}}ListResp {
                msg: "successful".to_string(),
                code: 0,
                total,
                data: Some({{.RustName}}_list),
            }
        }
        Err(err) => {
            {{.JavaName}}ListResp {
                msg: err.to_string(),
                code: 1,
                total: 0,
                data: None,
            }
        }
    };


    Ok(web::Json(resp))
}

#[post("/{{.RustName}}_save")]
pub async fn {{.RustName}}_save(item: web::Json<MenuSaveReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("{{.RustName}}_save params: {:?}", &item);
    let mut rb = &data.batis;

    let req = item.0;

    let role = {{.JavaName}} {

    };

    let result = {{.JavaName}}::insert(&mut rb, &role).await;

    Ok(web::Json(handle_result(result)))
}

#[post("/{{.RustName}}_update")]
pub async fn {{.RustName}}_update(item: web::Json<MenuUpdateReq>, data: web::Data<AppState>) -> Result<impl Responder> {
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