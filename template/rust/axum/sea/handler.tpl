use std::sync::Arc;
use axum::extract::State;
use axum::Json;
use axum::response::IntoResponse;
use sea_orm::{ColumnTrait, EntityTrait, NotSet, PaginatorTrait, QueryFilter, QueryOrder};
use sea_orm::ActiveValue::Set;
use crate::{AppState};

use crate::model::{ {{.OriginalName}} };
use crate::model::prelude::{ {{.UpperOriginalName}} };
use crate::vo::*;
use crate::vo::{{.RustName}}_vo::*;
use crate::vo::{err_result_msg, ok_result_msg, ok_result_page};

/**
 *添加{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn add_{{.RustName}}(State(state): State<Arc<AppState>>, Json(item): Json<Add{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("add_{{.RustName}} params: {:?}", &item);
    let conn = &state.conn;

    let {{.RustName}} = {{.OriginalName}}::ActiveModel {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: NotSet
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: NotSet
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: Set(String::from(""))
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: NotSet
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: NotSet
        {{- else}}
        {{.RustName}}: Set(item.{{.RustName}})
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    {{.UpperOriginalName}}::insert({{.RustName}}).exec(conn).await.unwrap();

    Json(ok_result_msg("添加{{.Comment}}成功!"))
}

/**
 *删除{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn delete_{{.RustName}}(State(state): State<Arc<AppState>>, Json(item): Json<Delete{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("delete_{{.RustName}} params: {:?}", &item);
    let conn = &state.conn;

   {{.UpperOriginalName}}::delete_many().filter({{.UpperOriginalName}}::Column::Id.is_in(item.ids)).exec(conn).await.unwrap();

    Json(ok_result_msg("删除{{.Comment}}成功!"))
}

/**
 *更新{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn update_{{.RustName}}(State(state): State<Arc<AppState>>, Json(item): Json<Update{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("update_{{.RustName}} params: {:?}", &item);
    let conn = &state.conn;

    if {{.UpperOriginalName}}::find_by_id(item.id.clone()).one(conn).await.unwrap_or_default().is_none() {
        return Json(err_result_msg("{{.Comment}}不存在,不能更新!"))
    }

    let {{.RustName}} = {{.OriginalName}}::ActiveModel {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: Set(item.{{.RustName}})
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: NotSet
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: NotSet
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: Set(String::from(""))
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: NotSet
        {{- else}}
        {{.RustName}}: Set(item.{{.RustName}})
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    {{.UpperOriginalName}}::update({{.RustName}}).exec(conn).await.unwrap();
    Json(ok_result_msg("更新{{.Comment}}成功!"))
}

/**
 *更新{{.Comment}}状态
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn update_{{.RustName}}_status(State(state): State<Arc<AppState>>, Json(item): Json<Update{{.JavaName}}StatusReq>) -> impl IntoResponse {
    log::info!("update_{{.RustName}}_status params: {:?}", &item);
    //let conn = &state.conn;

    //{{.UpperOriginalName}}::update_many()
    //    .col_expr({{.UpperOriginalName}}::Column::Status, Expr::value(item.status))
    //    .filter({{.UpperOriginalName}}::Column::Id.is_in(item.ids))
    //    .exec(&conn)
    //    .await.unwrap();
    Json(ok_result_msg("更新{{.Comment}}状态成功!"))
}

/**
 *查询{{.Comment}}详情
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn query_{{.RustName}}_detail(State(state): State<Arc<AppState>>, Json(item): Json<Query{{.JavaName}}DetailReq>) -> impl IntoResponse {
    log::info!("query_{{.RustName}}_detail params: {:?}", &item);
    let conn = &state.conn;

    let result = {{.UpperOriginalName}}::find_by_id(item.id.clone()).one(conn).await.unwrap_or_default();

    match result {
        Ok(d) => {
            let x = d.unwrap();

            let {{.RustName}} = Query{{.JavaName}}DetailResp {
            {{- range .TableColumn}}
            {{- if eq .ColumnKey `PRI`}}
                {{.RustName}}: x.{{.RustName}}.unwrap()
            {{- else if eq .IsNullable `YES` }}
                {{.RustName}}: x.{{.RustName}}.unwrap_or_default()
            {{- else if eq .RustType `DateTime`}}
                {{.RustName}}: x.{{.RustName}}.unwrap().0.to_string()
            {{- else}}
                {{.RustName}}: x.{{.RustName}}
            {{- end}},
            {{- end}}
            };

            Json(ok_result_data(alipay_info))
        }
        Err(err) => {
            Json(err_result_msg(err.to_string()))
        }
    }

}


/**
 *查询{{.Comment}}列表
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn query_{{.RustName}}_list(State(state): State<Arc<AppState>>, Json(item): Json<Query{{.JavaName}}ListReq>) -> impl IntoResponse {
    log::info!("query_{{.RustName}}_list params: {:?}", &item);
    let conn = &state.conn;

    {{- $lowerJavaName :=.UpperOriginalName}}
    let paginator = {{.UpperOriginalName}}::find()
        {{- range .TableColumn}}
        {{- if isContain .JavaName "create"}}
        {{- else if isContain .JavaName "update"}}
        {{- else if isContain .JavaName "remark"}}
        {{- else if isContain .JavaName "sort"}}
        {{- else if eq .ColumnKey "PRI"}}
        {{- else}}
        //.apply_if(item.{{.RustName}}.clone(), |query, v| { query.filter( {{$lowerJavaName}}::Column::{{.RustName}}.eq(v))})
        {{- end}}
        {{- end}}
        .paginate(conn, item.page_size.clone());

    let total = paginator.num_items().await.unwrap_or_default();

    let mut {{.RustName}}_list_data: Vec<{{.JavaName}}ListDataResp> = Vec::new();

    for x in paginator.fetch_page(item.page_no.clone() - 1).await.unwrap_or_default() {
        {{.RustName}}_list_data.push({{.JavaName}}ListDataResp {
        {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
            {{.RustName}}: x.{{.RustName}}.unwrap()
        {{- else if eq .IsNullable `YES` }}
            {{.RustName}}: x.{{.RustName}}.unwrap_or_default()
        {{- else if eq .RustType `DateTime`}}
            {{.RustName}}: x.{{.RustName}}.unwrap().0.to_string()
        {{- else}}
            {{.RustName}}: x.{{.RustName}}
        {{- end}},
        {{- end}}
        })
    }

    Json(ok_result_page({{.RustName}}_list_data, total))

}

