use std::sync::Arc;
use axum::extract::State;
use axum::Json;
use axum::response::IntoResponse;
use rbatis::rbdc::datetime::DateTime;
use rbatis::sql::{PageRequest};
use crate::{AppState};

use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::vo::{err_result_page, handle_result, ok_result_page};
use crate::vo::{{.RustName}}_vo::{*};

// 添加{{.Comment}}
pub async fn {{.RustName}}_save(State(state): State<Arc<AppState>>, Json(item): Json<{{.JavaName}}SaveReq>) -> impl IntoResponse {
    log::info!("{{.RustName}}_save params: {:?}", &item);
    let mut rb = &state.batis;

    let {{.RustName}} = {{.JavaName}} {
    {{range .TableColumn}}    {{.RustName}}: {{if eq .ColumnKey `PRI`}}None{{else if eq .RustType `DateTime`}}Some(DateTime::now()){{else}}item.{{.RustName}}{{end}},
    {{end}}
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
    {{range .TableColumn}}    {{.RustName}}: {{if eq .RustType `DateTime`}}Some(DateTime::now()){{else}}item.{{.RustName}}{{end}},
    {{end}}
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

            Json(ok_result_page({{.RustName}}_list_data, total))
        }
        Err(err) => {
            Json(err_result_page({{.RustName}}_list_data, err.to_string()))
        }
    }

}

