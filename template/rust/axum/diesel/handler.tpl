use axum::Json;
use axum::response::IntoResponse;
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl, sql_query};
use diesel::associations::HasTable;
use diesel::sql_types::*;
use log::{debug, error};

use crate::{RB, schema};

use crate::model::{{.RustName}}::{{.UpperOriginalName}};
use crate::schema::{{.OriginalName}}::*;
use crate::schema::{{.OriginalName}}::dsl::{{.OriginalName}};
use crate::vo::*;
use crate::vo::{{.RustName}}_vo::{*};


/**
 *添加{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn add_{{.RustName}}(Json(req): Json<Add{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("add_{{.RustName}} params: {:?}", &req);
    let add_{{.OriginalName}} = {{.UpperOriginalName}} {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: 0
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: Default::default()
        {{- else}}
        {{.RustName}}: req.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    match &mut RB.clone().get() {
        Ok(conn) => {
            Json(handle_result(diesel::insert_into({{.OriginalName}}::table()).values(add_{{.OriginalName}}).execute(conn)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Json(err_result_msg(err.to_string()))
        }
    }
}

/**
 *删除{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn delete_{{.RustName}}(Json(req): Json<Delete{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("delete_{{.RustName}} params: {:?}", &req);
    match &mut RB.clone().get() {
        Ok(conn) => {
            Json(handle_result(diesel::delete({{.OriginalName}}.filter(id.eq_any(&req.ids))).execute(conn)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Json(err_result_msg(err.to_string()))
        }
    }
}

/**
 *更新{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn update_{{.RustName}}(Json(req): Json<Update{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("update_{{.RustName}} params: {:?}", &req);
    let update_{{.OriginalName}} = {{.UpperOriginalName}} {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: 0
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: Default::default()
        {{- else}}
        {{.RustName}}: req.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    match &mut RB.clone().get() {
        Ok(conn) => {
            Json(handle_result(diesel::update({{.OriginalName}}).filter(id.eq(&req.id)).set(update_{{.OriginalName}}).execute(conn)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Json(err_result_msg(err.to_string()))
        }
    }
}

/**
 *更新{{.Comment}}状态
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn update_{{.RustName}}_status(Json(req): Json<Update{{.JavaName}}StatusReq>) -> impl IntoResponse {
    log::info!("update_{{.RustName}}_status params: {:?}", &req);

    match &mut RB.clone().get() {
        Ok(conn) => {
            Json(handle_result(diesel::update({{.OriginalName}}).filter(id.eq_any(&req.ids)).set(status.eq(req.status)).execute(conn)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Json(err_result_msg(err.to_string()))
        }
    }
}

/**
 *查询{{.Comment}}详情
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn query_{{.RustName}}_detail(Json(req): Json<Query{{.JavaName}}DetailReq>) -> Result<impl IntoResponse, impl IntoResponse> {
    log::info!("query_{{.RustName}}_detail params: {:?}", &req);

    match &mut RB.clone().get() {
        Ok(conn) => {
            let {{.OriginalName}}_sql = sql_query("SELECT * FROM {{.OriginalName}} WHERE id = ?");
            let result = {{.OriginalName}}_sql.bind::<Bigint, _>(&req.id).get_result(conn);
            if let Ok(x) = result {
              let data  =Query{{.JavaName}}DetailResp {
                    {{- range .TableColumn}}
                    {{- if eq .ColumnKey `PRI`}}
                        {{.RustName}}: x.{{.RustName}}
                    {{- else if eq .IsNullable `YES` }}
                        {{.RustName}}: x.{{.RustName}}.unwrap_or_default()
                    {{- else if eq .RustType `DateTime`}}
                        {{.RustName}}: x.{{.RustName}}.unwrap().0.to_string()
                    {{- else}}
                        {{.RustName}}: x.{{.RustName}}
                    {{- end}},
                    {{- end}}
                };
                Ok(Json(ok_result_data(data)))
            }

        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Err(Json(err_result_msg(err.to_string())))
        }
    }
}

/**
 *查询{{.Comment}}列表
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn query_{{.RustName}}_list(Json(req): Json<Query{{.JavaName}}ListReq>) -> Result<impl IntoResponse, impl IntoResponse> {
    log::info!("query_{{.RustName}}_list params: {:?}", &req);
    let mut query = {{.OriginalName}}::table().into_boxed();

    //if let Some(i) = &req.status {
    //    query = query.filter(status_id.eq(i));
    //}

    debug!("SQL:{}", diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string());

    match &mut RB.clone().get() {
        Ok(conn) => {
            let result = query.load::<SysRole>(conn);
            let mut {{.RustName}}_list_data: Vec<Query{{.JavaName}}ListDataResp> = Vec::new();
            if let Ok(role_list) = result {
                for x in role_list {
                    {{.RustName}}_list_data.push(Query{{.JavaName}}ListDataResp {
                    {{- range .TableColumn}}
                    {{- if eq .ColumnKey `PRI`}}
                        {{.RustName}}: x.{{.RustName}}
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
            }

            Ok(Json(ok_result_page({{.RustName}}_list_data, 10)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Err(Json(err_result_msg(err.to_string())))
        }
    }
}

