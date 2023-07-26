info(
	desc: "{{.Comment}}"
	author: "{{.Author}}"
	email: "1002219331@qq.com"
)

type (
	add{{.JavaName}}Req {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}}
	add{{.JavaName}}Resp {
		Code    string `json:"code"`
		Message string `json:"message"`
	}
	List{{.JavaName}}Req {
		Current         int64  `json:"current,default=1"`
		PageSize        int64  `json:"pageSize,default=20"`
		Title           string `json:"title,optional"`
		RecommendStatus int64  `json:"recommendStatus,default=2"`
		ShowStatus      int64  `json:"showStatus,default=2"` // 显示状态：0->不显示；1->显示
	}
	List{{.JavaName}}Data {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}
	}
	List{{.JavaName}}Resp {
		Code     string              `json:"code"`
		Message  string              `json:"message"`
		Current  int64               `json:"current,default=1"`
		Data     []*List{{.JavaName}}Data `json:"data"`
		PageSize int64               `json:"pageSize,default=20"`
		Success  bool                `json:"success"`
		Total    int64               `json:"total"`
	}
	Update{{.JavaName}}Req {
    {{range .TableColumn}}    {{.GoNamePublic}} {{if eq .GoType `time.Time`}}string{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
    {{end}}
	}
	Update{{.JavaName}}Resp {
		Code    string `json:"code"`
		Message string `json:"message"`
	}
	Delete{{.JavaName}}Req {
		Ids []int64 `json:"ids"`
	}
	Delete{{.JavaName}}Resp {
		Code    string `json:"code"`
		Message string `json:"message"`
	}
)

@server(
	group: demo/{{.GoName}}
	prefix: /api/demo/{{.LowerJavaName}}
)
service admin-api {
	@handler {{.JavaName}}Add
	post /add (add{{.JavaName}}Req) returns (add{{.JavaName}}Resp)
	
	@handler {{.JavaName}}List
	post /list (List{{.JavaName}}Req) returns (List{{.JavaName}}Resp)
	
	@handler {{.JavaName}}Update
	post /update (Update{{.JavaName}}Req) returns (Update{{.JavaName}}Resp)
	
	@handler {{.JavaName}}Delete
	post /delete (Delete{{.JavaName}}Req) returns (Delete{{.JavaName}}Resp)
}