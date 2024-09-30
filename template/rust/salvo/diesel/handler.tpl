use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl, sql_query};
use diesel::associations::HasTable;
use diesel::sql_types::*;
use log::{debug, error};
use salvo::{Request, Response};
use salvo::prelude::*;

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
#[handler]
pub async fn add_{{.RustName}}(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<Add{{.JavaName}}Req>().await.unwrap();
    log::info!("add_{{.RustName}} params: {:?}", &item);

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
        {{.RustName}}: item.{{.RustName}}
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

    res.render(Json(resp))
}

/**
 *删除{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[handler]
pub async fn delete_{{.RustName}}(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<Delete{{.JavaName}}Req>().await.unwrap();
    log::info!("delete_{{.RustName}} params: {:?}", &item);
    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::delete({{.OriginalName}}.filter(id.eq_any(&item.ids))).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    res.render(Json(resp))
}

/**
 *更新{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[handler]
pub async fn update_{{.RustName}}(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<Update{{.JavaName}}Req>().await.unwrap();
    log::info!("update_{{.RustName}} params: {:?}", &item);

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
        {{.RustName}}: item.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };


    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::update({{.OriginalName}}).filter(id.eq(&item.id)).set(update_{{.OriginalName}}).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    res.render(Json(resp))
}

/**
 *更新{{.Comment}}状态
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[handler]
pub async fn update_{{.RustName}}_status(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<Update{{.JavaName}}StatusReq>().await.unwrap();
    log::info!("update_{{.RustName}}_status params: {:?}", &item);

    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::update({{.OriginalName}}).filter(id.eq_any(&item.ids)).set(status.eq(item.status)).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    res.render(Json(resp))
}

/**
 *查询{{.Comment}}详情
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[handler]
pub async fn query_{{.RustName}}_detail(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<Query{{.JavaName}}DetailReq>().await.unwrap();

    log::info!("query_{{.RustName}}_detail params: {:?}", &item);

    match &mut RB.clone().get() {
        Ok(conn) => {
            let {{.OriginalName}}_sql = sql_query("SELECT * FROM {{.OriginalName}} WHERE id = ?");
            let result = {{.OriginalName}}_sql.bind::<Bigint, _>(&item.id).get_result(conn);
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

              res.render(Json(ok_result_data(data)))
           }

        }
        Err(err) => {
            error!("err:{}", err.to_string());
            res.render(Json(err_result_msg(err.to_string())))
        }
    }
}

/**
 *查询{{.Comment}}列表
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[handler]
pub async fn query_{{.RustName}}_list(req: &mut Request, res: &mut Response) {
    let item = req.parse_json::<Query{{.JavaName}}ListReq>().await.unwrap();
    log::info!("query_{{.RustName}}_list params: {:?}", &item);

    let mut query = {{.OriginalName}}::table().into_boxed();

    //if let Some(i) = &item.status {
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
            res.render(Json(ok_result_page(list, 10)))
            }
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            res.render(Json(err_result_msg(err.to_string())))
        }
    }

}
