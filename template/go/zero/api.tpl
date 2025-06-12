info(
	desc: "{{.Comment}}"
	author: "{{.Author}}"
	email: "1002219331@qq.com"
)

type (
    // 添加{{.Comment}}请求参数
	Add{{.JavaName}}Req {
    {{- range .TableColumn}}
    {{- if isContain .JavaName "create"}}
    {{- else if isContain .JavaName "update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else}}
        {{- if eq .IsNullable `YES` }}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}},optional"` //{{.ColumnComment}}
        {{- else if eq .JavaName `remark` }}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}},optional"` //{{.ColumnComment}}
        {{- else}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
        {{- end}}
    {{- end}}
    {{- end}}

    }
	Add{{.JavaName}}Resp {
		Code    string `json:"code"`
		Message string `json:"message"`
	}

    // 删除{{.Comment}}请求参数
	Delete{{.JavaName}}Req {
        Ids []int64 `form:"ids"`
    }
    Delete{{.JavaName}}Resp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 更新{{.Comment}}请求参数
    Update{{.JavaName}}Req {
    {{- range .TableColumn}}
    {{- if isContain .JavaName "create"}}
    {{- else if isContain .JavaName "update"}}
    {{- else}}
        {{- if eq .IsNullable `YES` }}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}},optional"` //{{.ColumnComment}}
        {{- else if eq .JavaName `remark` }}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}},optional"` //{{.ColumnComment}}
        {{- else}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
        {{- end}}
    {{- end}}
    {{- end}}
    }
    Update{{.JavaName}}Resp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 更新{{.Comment}}状态请求参数
    Update{{.JavaName}}StatusReq {
    {{- range .TableColumn}}
    {{- if eq .ColumnKey "PRI"}}
        {{.GoNamePublic}}s []{{.GoType}} `json:"{{.JavaName}}s"` //{{.ColumnComment}}
    {{- else if isContain .JavaName "status"}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{- else if isContain .JavaName "Status"}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{- else}}
    {{- end}}
    {{- end}}
    }
    Update{{.JavaName}}StatusResp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 查询{{.Comment}}详情请求参数
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
    // 分页查询{{.Comment}}列表请求参数
	Query{{.JavaName}}ListReq {
		Current         int64  `form:"current,default=1"` //第几页
		PageSize        int64  `form:"pageSize,default=20"` //每页的数量
    {{- range .TableColumn}}
    {{- if isContain .JavaName "create"}}
    {{- else if isContain .JavaName "update"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else}}
        {{- if isContain .JavaName "status"}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}},default=2"` //{{.ColumnComment}}
        {{- else if isContain .JavaName "Status"}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}},default=2"` //{{.ColumnComment}}
        {{- else}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}},optional"` //{{.ColumnComment}}
        {{- end}}
    {{- end}}
    {{- end}}
	}
	Query{{.JavaName}}ListData {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}
	}
	Query{{.JavaName}}ListResp {
		Code     string              `json:"code"`
		Message  string              `json:"message"`
		Data     []*Query{{.JavaName}}ListData `json:"data"`
		Current  int64               `json:"current,default=1"`
		PageSize int64               `json:"pageSize,default=20"`
		Total    int64               `json:"total"`
		Success  bool                `json:"success"`

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