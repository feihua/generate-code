use actix_web::{post, Responder, Result, web};
use rbatis::rbdc::datetime::DateTime;
use rbatis::plugin::page::PageRequest;
use rbs::to_value;
use crate::AppState;

use crate::common::error::AppError;
use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::vo::*;
use crate::vo::{{.RustName}}_vo::{*};

/**
 *添加{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/add{{.JavaName}}")]
pub async fn add_{{.RustName}}(item: web::Json<Add{{.JavaName}}Req>, data: web::Data<AppState>) -> Result<impl Responder, AppError> {
    log::info!("add_{{.RustName}} params: {:?}", &item);
    let mut rb = &data.batis;

    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: None
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: None
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: String::from("")
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: String::from("")
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: None
        {{- else}}
        {{.RustName}}: req.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    {{.JavaName}}::insert(&mut rb, &{{.RustName}}).await?;

    BaseResponse::<String>::ok_result()
}

/**
 *删除{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/delete{{.JavaName}}")]
pub async fn delete_{{.RustName}}(item: web::Json<Delete{{.JavaName}}Req>, data: web::Data<AppState>) -> Result<impl Responder, AppError> {
    log::info!("delete_{{.RustName}} params: {:?}", &item);
    let mut rb = &data.batis;

    {{.JavaName}}::delete_in_column(&mut rb, "id", &item.ids).await?;

    BaseResponse::<String>::ok_result()
}

/**
 *更新{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/update{{.JavaName}}")]
pub async fn update_{{.RustName}}(item: web::Json<Update{{.JavaName}}Req>, data: web::Data<AppState>) -> Result<impl Responder, AppError> {
    log::info!("update_{{.RustName}} params: {:?}", &item);
    let mut rb = &data.batis;
    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: Some(item.{{.RustName}})
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: None
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: String::from("")
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: String::from("")
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: None
        {{- else}}
        {{.RustName}}: req.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    {{.JavaName}}::update_by_column(&mut rb, &{{.RustName}}, "id").await?;

    BaseResponse::<String>::ok_result()
}

/**
 *更新{{.Comment}}状态
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/update{{.JavaName}}Status")]
pub async fn update_{{.RustName}}_status(item: web::Json<Update{{.JavaName}}StatusReq>, data: web::Data<AppState>) -> Result<impl Responder, AppError> {
    log::info!("update_{{.RustName}}_status params: {:?}", &item);
    let mut rb = &data.batis;
    let req = item.0;

   let param = vec![to_value!(1), to_value!(1)];
   rb.exec("update {{.OriginalName}} set status = ? where id in ?", param).await?;

   BaseResponse::<String>::ok_result()
}

/**
 *查询{{.Comment}}详情
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/query{{.JavaName}}Detail")]
pub async fn query_{{.RustName}}_detail(item: web::Json<Query{{.JavaName}}DetailReq>, data: web::Data<AppState>) -> Result<impl Responder, AppError> {
    log::info!("query_{{.RustName}}_detail params: {:?}", &item);
    let mut rb = &data.batis;

    let result = {{.JavaName}}::select_by_id(&mut rb, &item.id).await?;

    match result {
        None => {
            return BaseResponse::<Query{{.JavaName}}DetailResp>::err_result_data(
                QueryMenuDetailResp::new(),
                "{{.Comment}}不存在",
            );
        }
        Some(x) => {
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

            BaseResponse::<Query{{.JavaName}}DetailResp>::ok_result_data({{.RustName}})
        }

    }

}

/**
 *查询{{.Comment}}列表
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[post("/query{{.JavaName}}List")]
pub async fn query_{{.RustName}}_list(item: web::Json<Query{{.JavaName}}ListReq>, data: web::Data<AppState>) -> Result<impl Responder, AppError> {
    log::info!("query_{{.RustName}}_list params: {:?}", &item);
    let mut rb = &data.batis;

    let page=&PageRequest::new(item.page_no.clone(), item.page_size.clone());
    let d = {{.JavaName}}::select_page(&mut rb, page).await?;

    let mut data: Vec<{{.JavaName}}ListDataResp> = Vec::new();

    let total = d.total;

    for x in d.records {
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

    BaseResponse::ok_result_page(data, total)

}
