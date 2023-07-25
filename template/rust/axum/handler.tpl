use std::sync::Arc;
use axum::extract::State;
use axum::Json;
use axum::response::IntoResponse;
use rbatis::rbdc::datetime::FastDateTime;
use rbatis::sql::{PageRequest};
use crate::{AppState};

use crate::model::entity::{ {{.JavaName}} };
use crate::vo::handle_result;
use crate::vo::{{.RustName}}_vo::{*};

// 添加{{.Comment}}
pub async fn {{.RustName}}_save(State(state): State<Arc<AppState>>, Json(item): Json<{{.JavaName}}SaveReq>) -> impl IntoResponse {
    log::info!("{{.RustName}}_save params: {:?}", &item);
    let mut rb = &state.batis;

    let {{.RustName}} = {{.JavaName}} {

    };

    let result = {{.JavaName}}::insert(&mut rb, &{{.RustName}}).await;

    Json(handle_result(result))
}

// 删除{{.Comment}}
pub async fn {{.RustName}}_delete(State(state): State<Arc<AppState>>, Json(item): Json<{{.JavaName}}DeleteReq>) -> impl IntoResponse {
    log::info!("{{.RustName}}_delete params: {:?}", &item);
    let mut rb = &state.batis;

    let result = {{.JavaName}}::delete_in_column(&mut rb, "id", &item.ids).await;

    Json(handle_result(result))
}

// 更新{{.Comment}}
pub async fn {{.RustName}}_update(State(state): State<Arc<AppState>>, Json(item): Json<{{.JavaName}}UpdateReq>) -> impl IntoResponse {
    log::info!("{{.RustName}}_update params: {:?}", &item);
    let mut rb = &state.batis;

    let {{.RustName}} = {{.JavaName}} {

    };

    let result = {{.JavaName}}::update_by_column(&mut rb, &{{.RustName}}, "id").await;

    Json(handle_result(result))
}

// 查询{{.Comment}}
pub async fn {{.RustName}}_list(State(state): State<Arc<AppState>>, Json(item): Json<{{.JavaName}}ListReq>) -> impl IntoResponse {
    log::info!("{{.RustName}}_list params: {:?}", &item);
    let mut rb = &state.batis;

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

    Json(resp)
}

