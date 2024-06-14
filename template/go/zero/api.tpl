info(
	desc: "{{.Comment}}"
	author: "{{.Author}}"
	email: "1002219331@qq.com"
)

type (
    // 添加{{.Comment}}
	Add{{.JavaName}}Req {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}}
	Add{{.JavaName}}Resp {
		Code    string `json:"code"`
		Message string `json:"message"`
	}

    // 删除{{.Comment}}
	Delete{{.JavaName}}Req {
        Ids []int64 `form:"ids"`
    }
    Delete{{.JavaName}}Resp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 更新{{.Comment}}
    Update{{.JavaName}}Req {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}
    }
    Update{{.JavaName}}Resp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 更新{{.Comment}}状态
    Update{{.JavaName}}StatusReq {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}
    }
    Update{{.JavaName}}StatusResp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 查询{{.Comment}}详情
	Query{{.JavaName}}DetailReq {
		Id         int64  `form:"id"`
	}
	Query{{.JavaName}}DetailData {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}
	}
	Query{{.JavaName}}DetailResp {
		Code     string              `json:"code"`
		Message  string              `json:"message"`
		Data     Query{{.JavaName}}DetailData `json:"data"`
	}
    // 分页查询{{.Comment}}列表
	Query{{.JavaName}}ListReq {
		Current         int64  `form:"current,default=1"` //第几页
		PageSize        int64  `form:"pageSize,default=20"` //每页的数量
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `form:"{{.JavaName}},optional"` //{{.ColumnComment}}
    {{end}}
	}
	Query{{.JavaName}}ListData {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}
	}
	Query{{.JavaName}}ListResp {
		Code     string              `json:"code"`
		Message  string              `json:"message"`
		Current  int64               `json:"current,default=1"`
		Data     []*Query{{.JavaName}}ListData `json:"data"`
		PageSize int64               `json:"pageSize,default=20"`
		Success  bool                `json:"success"`
		Total    int64               `json:"total"`
	}
)

@server(
	group: demo/{{.GoName}}
	prefix: /api/demo/{{.LowerJavaName}}
)
service admin-api {
    // 添加{{.Comment}}
	@handler Add{{.JavaName}}
	post /add{{.JavaName}} (Add{{.JavaName}}Req) returns (Add{{.JavaName}}Resp)

	// 删除{{.Comment}}
	@handler Delete{{.JavaName}}
    get /delete{{.JavaName}} (Delete{{.JavaName}}Req) returns (Delete{{.JavaName}}Resp)

    // 更新{{.Comment}}
    @handler Update{{.JavaName}}
    post /update{{.JavaName}} (Update{{.JavaName}}Req) returns (Update{{.JavaName}}Resp)

    // 更新{{.Comment}}状态
    @handler Update{{.JavaName}}Status
    post /update{{.JavaName}}Status (Update{{.JavaName}}StatusReq) returns (Update{{.JavaName}}StatusResp)

    // 查询{{.Comment}}详情
	@handler Query{{.JavaName}}Detail
	get /query{{.JavaName}}Detail (Query{{.JavaName}}DetailReq) returns (Query{{.JavaName}}DetailResp)

    // 分页查询{{.Comment}}列表
	@handler Query{{.JavaName}}List
	get /query{{.JavaName}}List (Query{{.JavaName}}ListReq) returns (Query{{.JavaName}}ListResp)

}