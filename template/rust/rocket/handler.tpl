use rocket::serde::json::serde_json::json;
use rocket::serde::json::{Json, Value};
use rbatis::rbdc::datetime::FastDateTime;
use rbatis::sql::{PageRequest};

use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::RB;
use crate::utils::auth::Token;
use crate::vo::handle_result;
use crate::vo::{{.RustName}}_vo::{*};

// 添加{{.Comment}}
#[post("/{{.RustName}}_save", data = "<item>")]
pub async fn {{.RustName}}_save(item: Json<{{.JavaName}}SaveReq>, _auth: Token) -> Value {
    log::info!("{{.RustName}}_save params: {:?}", &item);
    let mut rb = RB.to_owned();

    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {

    };

    let result = {{.JavaName}}::insert(&mut rb, &{{.RustName}}).await;

    json!(&handle_result(result))
}

// 删除{{.Comment}}
#[post("/{{.RustName}}_delete", data = "<item>")]
pub async fn {{.RustName}}_delete(item: Json<{{.JavaName}}DeleteReq>, _auth: Token) -> Value {
    log::info!("{{.RustName}}_delete params: {:?}", &item);
    let mut rb = RB.to_owned();

    let result = {{.JavaName}}::delete_in_column(&mut rb, "id", &item.ids).await;

    json!(&handle_result(result))
}

// 更新{{.Comment}}
#[post("/{{.RustName}}_update", data = "<item>")]
pub async fn {{.RustName}}_update(item: Json<{{.JavaName}}UpdateReq>, _auth: Token) -> Value {
    log::info!("{{.RustName}}_update params: {:?}", &item);
    let mut rb = RB.to_owned();
    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {

    };

    let result = {{.JavaName}}::update_by_column(&mut rb, &{{.RustName}}, "id").await;

    json!(&handle_result(result))
}

// 查询{{.Comment}}
#[post("/{{.RustName}}_list", data = "<item>")]
pub async fn {{.RustName}}_list(item: Json<{{.JavaName}}ListReq>, _auth: Token) -> Value {
    log::info!("{{.RustName}}_list params: {:?}", &item);
    let mut rb = RB.to_owned();

    let page = &PageRequest::new(item.page_no, item.page_size);
    let result = {{.JavaName}}::select_page(&mut rb, page).await;

    match result {
        Ok(d) => {
            let total = d.total;
            let page_no = d.page_no;
            let page_size = d.page_size;

            let mut {{.RustName}}_list: Vec<{{.JavaName}}ListData> = Vec::new();

            for x in d.records {
                {{.RustName}}_list.push({{.JavaName}}ListData {

                })
            }

            json!(&{{.JavaName}}ListResp {
                msg: "successful".to_string(),
                code: 0,
                page_no,
                page_size,
                success: true,
                total,
                data: Some({{.RustName}}_list),
            })
        }
        Err(err) => {
            json!({"code":1,"msg":err.to_string()})
        }
    }
}


