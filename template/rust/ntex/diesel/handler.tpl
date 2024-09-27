use log::info;
use ntex::web;
use ntex::web::{Error, HttpResponse, Responder};
use ntex::web::types::{Json, State};

use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl};
use diesel::associations::HasTable;
use diesel::sql_types::Integer;
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
#[web::post("/add{{.JavaName}}")]
pub async fn add_{{.RustName}}(item: Json<Add{{.JavaName}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("add_{{.RustName}} params: {:?}", &item);

    let req = item.0;

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


    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::insert_into({{.OriginalName}}::table()).values(add_{{.OriginalName}}).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    Ok(web::HttpResponse::Ok().json(&resp))
}


/**
 *删除{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/delete{{.JavaName}}")]
pub async fn delete_{{.RustName}}(item: Json<Delete{{.JavaName}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("delete_{{.RustName}} params: {:?}", &item);
    let req = item.0;


    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::delete({{.OriginalName}}.filter(id.eq_any(&req.ids))).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    Ok(web::HttpResponse::Ok().json(&resp))
}

/**
 *更新{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/update{{.JavaName}}")]
pub async fn update_{{.RustName}}(item: Json<Update{{.JavaName}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("update_{{.RustName}} params: {:?}", &item);

    let req = item.0;

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


    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::update({{.OriginalName}}).filter(id.eq(&req.id)).set(update_{{.OriginalName}}).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    Ok(web::HttpResponse::Ok().json(&resp))
}

/**
 *更新{{.Comment}}状态
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/update{{.JavaName}}Status")]
pub async fn update_{{.RustName}}_status(item: Json<Update{{.JavaName}}StatusReq>) -> Result<impl web::Responder, web::Error> {
    info!("update_{{.RustName}}_status params: {:?}", &item);
    let req = item.0;


    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::update({{.OriginalName}}).filter(id.eq_any(&req.ids)).set(status.eq(req.status)).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    Ok(web::HttpResponse::Ok().json(&resp))
}

/**
 *查询{{.Comment}}详情
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/query{{.JavaName}}Detail")]
pub async fn query_{{.RustName}}_detail(item: Json<Query{{.JavaName}}DetailReq>) -> Result<impl web::Responder, web::Error> {
    info!("query_{{.RustName}}_detail params: {:?}", &item);


    match &mut RB.clone().get() {
        Ok(conn) => {
            let result = {{.OriginalName}}.bind::<Integer, _>(req.id).get_result(conn);
            if let Ok(x) = result {
              let data  =Query{{.JavaName}}DetailResp {
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
                Ok(web::HttpResponse::Ok().json(&ok_result_data(data)))
                }
            }

        Err(err) => {
            error!("err:{}", err.to_string());
            Ok(web::HttpResponse::Ok().json(&err_result_msg(err.to_string())))
        }

}


/**
 *查询{{.Comment}}列表
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/query{{.JavaName}}List")]
pub async fn query_{{.RustName}}_list(item: Json<Query{{.JavaName}}ListReq>) -> Result<impl web::Responder, web::Error> {
    info!("query_{{.RustName}}_list params: {:?}", &item);

    let mut query = {{.OriginalName}}::table().into_boxed();

    //if let Some(i) = &req.status {
    //    query = query.filter(status_id.eq(i));
    //}

    debug!("SQL:{}", diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string());

    match &mut RB.clone().get() {
        Ok(conn) => {
            let mut {{.RustName}}_list_data: Vec<Query{{.JavaName}}ListDataResp> = Vec::new();
            if let Ok(list) = query.load::<{{.UpperOriginalName}}>(conn) {
                for x in list {
                    {{.RustName}}_list_data.push(Query{{.JavaName}}ListDataResp {
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
            }
            Ok(web::HttpResponse::Ok().json(&ok_result_page({{.RustName}}_list_data, 10)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Ok(web::HttpResponse::Ok().json(&err_result_msg(err.to_string())))
        }
    }
}
