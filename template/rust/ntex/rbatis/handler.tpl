use log::info;
use ntex::web;
use ntex::web::types::Json;
use rbatis::rbdc::datetime::DateTime;
use rbatis::plugin::page::PageRequest;
use rbs::to_value;

use crate::common::error::{AppError, AppResult};
use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::RB;
use crate::vo::*;
use crate::vo::{{.RustName}}_vo::{*};


/**
 *添加{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/add{{.JavaName}}")]
pub async fn add_{{.RustName}}(item: Json<Add{{.JavaName}}Req>) -> AppResult<Response> {
    info!("add_{{.RustName}} params: {:?}", &item);

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

    {{.JavaName}}::insert(&mut RB.clone(),&{{.RustName}}).await?;

    ok_result()
}


/**
 *删除{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/delete{{.JavaName}}")]
pub async fn delete_{{.RustName}}(item: Json<Delete{{.JavaName}}Req>) -> AppResult<Response> {
    info!("delete_{{.RustName}} params: {:?}", &item);

    {{.JavaName}}::delete_in_column(&mut RB.clone(), "id", &item.ids).await?;

    ok_result()
}

/**
 *更新{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/update{{.JavaName}}")]
pub async fn update_{{.RustName}}(item: Json<Update{{.JavaName}}Req>) -> AppResult<Response> {
    info!("update_{{.RustName}} params: {:?}", &item);

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

    {{.JavaName}}::update_by_column(&mut RB.clone(), &{{.RustName}}, "id").await?;

    ok_result()
}

/**
 *更新{{.Comment}}状态
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/update{{.JavaName}}Status")]
pub async fn update_{{.RustName}}_status(item: Json<Update{{.JavaName}}Req>) -> AppResult<Response> {
    info!("update_{{.RustName}}_status params: {:?}", &item);
    let rb=&mut RB.clone();

    let req = item.0;

   let param = vec![to_value!(1), to_value!(1)];
   rb.exec("update {{.OriginalName}} set status = ? where id in ?", param).await?;

   ok_result()
}

/**
 *查询{{.Comment}}详情
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/query{{.JavaName}}Detail")]
pub async fn query_{{.RustName}}_detail(item: Json<Query{{.JavaName}}DetailReq>) -> AppResult<Response> {
    info!("query_{{.RustName}}_detail params: {:?}", &item);

   let result = {{.JavaName}}::select_by_id(&mut RB.clone(), &item.id).await?;

    match result {
       None => Err(AppError::BusinessError("{{.Comment}}不存在")),
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

            ok_result_data({{.RustName}})
        }

    }
}


/**
 *查询{{.Comment}}列表
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
#[web::post("/query{{.JavaName}}List")]
pub async fn query_{{.RustName}}_list(item: Json<Query{{.JavaName}}ListReq>) -> AppResult<Response> {
    info!("query_{{.RustName}}_list params: {:?}", &item);


    let page=&PageRequest::new(item.page_no.clone(), item.page_size.clone());
    let d = {{.JavaName}}::select_page(&mut RB.clone(), page).await?;

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

        ok_result_page(data, total)
}
