use std::sync::Arc;
use axum::extract::State;
use axum::Json;
use axum::response::IntoResponse;
use rbatis::rbdc::datetime::DateTime;
use rbatis::plugin::page::PageRequest;
use rbs::to_value;
use crate::{AppState};

use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::vo::*;
use crate::vo::{{.RustName}}_vo::{*};

/**
 *添加{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn add_{{.RustName}}(State(state): State<Arc<AppState>>, Json(item): Json<Add{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("add_{{.RustName}} params: {:?}", &item);
    let mut rb = &state.batis;

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
        {{.RustName}}: item.{{.RustName}}
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
pub async fn delete_{{.RustName}}(State(state): State<Arc<AppState>>, Json(item): Json<Delete{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("delete_{{.RustName}} params: {:?}", &item);
    let mut rb = &state.batis;

    {{.JavaName}}::delete_in_column(&mut rb, "id", &item.ids).await?;

    BaseResponse::<String>::ok_result()
}

/**
 *更新{{.Comment}}
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn update_{{.RustName}}(State(state): State<Arc<AppState>>, Json(item): Json<Update{{.JavaName}}Req>) -> impl IntoResponse {
    log::info!("update_{{.RustName}} params: {:?}", &item);
    let mut rb = &state.batis;

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
        {{.RustName}}: item.{{.RustName}}
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
pub async fn update_{{.RustName}}_status(State(state): State<Arc<AppState>>, Json(item): Json<Update{{.JavaName}}StatusReq>) -> impl IntoResponse {
    log::info!("update_{{.RustName}}_status params: {:?}", &item);
    let mut rb = &state.batis;

   let param = vec![to_value!(1), to_value!(1)];
   rb.exec("update {{.OriginalName}} set status = ? where id in ?", param).await?;

    BaseResponse::<String>::ok_result()
}

/**
 *查询{{.Comment}}详情
 *author：{{.Author}}
 *date：{{.CreateTime}}
 */
pub async fn query_{{.RustName}}_detail(State(state): State<Arc<AppState>>, Json(item): Json<Query{{.JavaName}}DetailReq>) -> impl IntoResponse {
    log::info!("query_{{.RustName}}_detail params: {:?}", &item);
    let mut rb = &state.batis;

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
pub async fn query_{{.RustName}}_list(State(state): State<Arc<AppState>>, Json(item): Json<Query{{.JavaName}}ListReq>) -> impl IntoResponse {
    log::info!("query_{{.RustName}}_list params: {:?}", &item);
    let mut rb = &state.batis;

    let page=&PageRequest::new(item.page_no, item.page_size);
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

