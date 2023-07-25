use rocket::serde::json::serde_json::json;
use rocket::serde::json::{Json, Value};
use rbatis::rbdc::datetime::FastDateTime;
use rbatis::sql::{PageRequest};

use crate::model::entity::{ {{.JavaName}} };
use crate::RB;
use crate::utils::auth::Token;
use crate::vo::handle_result;
use crate::vo::{{.RustName}}_vo::{*};


#[post("/{{.RustName}}_list", data = "<item>")]
pub async fn {{.RustName}}_list(item: Json<{{.JavaName}}ListReq>, _auth: Token) -> Value {
    log::info!("{{.RustName}}_list params: {:?}", &item);
    let mut rb = RB.to_owned();

    let result = {{.JavaName}}::select_page(&mut rb, &PageRequest::new(1, 1000)).await;

    match result {
        Ok(d) => {
            let total = d.total;

            let mut {{.RustName}}_list: Vec<MenuListData> = Vec::new();

            for x in d.records {
                {{.RustName}}_list.push(MenuListData {

                })
            }

            json!(&{{.JavaName}}ListResp {
                msg: "successful".to_string(),
                code: 0,
                total,
                data: Some({{.RustName}}_list),
            })
        }
        Err(err) => {
            json!({"code":1,"msg":err.to_string()})
        }
    }
}

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


#[post("/{{.RustName}}_delete", data = "<item>")]
pub async fn {{.RustName}}_delete(item: Json<{{.JavaName}}DeleteReq>, _auth: Token) -> Value {
    log::info!("{{.RustName}}_delete params: {:?}", &item);
    let mut rb = RB.to_owned();

    let result = {{.JavaName}}::delete_in_column(&mut rb, "id", &item.ids).await;

    json!(&handle_result(result))
}