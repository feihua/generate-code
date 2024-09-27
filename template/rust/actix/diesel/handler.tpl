use actix_web::{post, Responder, Result, web};
use sea_orm::{ColumnTrait, EntityTrait, NotSet, PaginatorTrait, QueryFilter, QueryOrder};
use sea_orm::ActiveValue::Set;
use crate::AppState;

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
#[post("/add{{.JavaName}}")]
pub async fn add_{{.RustName}}(item: web::Json<Add{{.JavaName}}Req>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("add_{{.RustName}} params: {:?}", &item);
    let conn = &data.conn;

    let req = item.0;

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
        {{.RustName}}: Set(req.{{.RustName}})
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    {{.UpperOriginalName}}::insert({{.RustName}}).exec(conn).await.unwrap();
    Ok(web::Json(ok_result_msg("添加{{.Comment}}成功!")))
}

/**
 *删除{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/delete{{.JavaName}}")]
pub async fn delete_{{.RustName}}(item: web::Json<Delete{{.JavaName}}Req>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("delete_{{.RustName}} params: {:?}", &item);
    let conn = &data.conn;
    let req = item.0;

    {{.UpperOriginalName}}::delete_many().filter({{.UpperOriginalName}}::Column::Id.is_in(req.ids)).exec(conn).await.unwrap();

    Ok(web::Json(ok_result_msg("删除{{.Comment}}成功!")))
}

/**
 *更新{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/update{{.JavaName}}")]
pub async fn update_{{.RustName}}(item: web::Json<Update{{.JavaName}}Req>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("update_{{.RustName}} params: {:?}", &item);
    let conn = &data.conn;
    let req = item.0;

    if {{.UpperOriginalName}}::find_by_id(item.id.clone()).one(conn).await.unwrap_or_default().is_none() {
        return Ok(web::Json(err_result_msg("{{.Comment}}不存在,不能更新!")))
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
        {{.RustName}}: Set(req.{{.RustName}})
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    {{.UpperOriginalName}}::update({{.RustName}}).exec(conn).await.unwrap();
    Ok(web::Json(ok_result_msg("更新{{.Comment}}成功!")))
}

/**
 *更新{{.Comment}}状态
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/update{{.JavaName}}Status")]
pub async fn update_{{.RustName}}_status(item: web::Json<Update{{.JavaName}}StatusReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("update_{{.RustName}}_status params: {:?}", &item);
    let conn = &data.conn;
    //let req = item.0;

    //{{.UpperOriginalName}}::update_many()
    //    .col_expr({{.UpperOriginalName}}::Column::Status, Expr::value(item.status))
    //    .filter({{.UpperOriginalName}}::Column::Id.is_in(item.ids))
    //    .exec(&conn)
    //    .await.unwrap();

    Ok(web::Json(ok_result_msg("更新{{.Comment}}状态成功!")))
}

/**
 *查询{{.Comment}}详情
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/query{{.JavaName}}Detail")]
pub async fn query_{{.RustName}}_detail(item: web::Json<Query{{.JavaName}}DetailReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("query_{{.RustName}}_detail params: {:?}", &item);
    let conn = &data.conn;

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

            Ok(web::Json(ok_result_data({{.RustName}})))
        }
        Err(err) => {
            Ok(web::Json(err_result_msg(err.to_string())))
        }
    }

}

/**
 *查询{{.Comment}}列表
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/query{{.JavaName}}List")]
pub async fn query_{{.RustName}}_list(item: web::Json<Query{{.JavaName}}ListReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("query_{{.RustName}}_list params: {:?}", &item);
    let conn = &data.conn;

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

    Ok(web::Json(ok_result_page({{.RustName}}_list_data, total)))

}
