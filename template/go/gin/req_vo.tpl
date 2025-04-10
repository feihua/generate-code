package {{.ModuleName}}

import "time"

// Add{{.JavaName}}ReqVo 添加{{.Comment}}请求参数
type Add{{.JavaName}}ReqVo struct {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else }}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" binding:"required"` //{{.ColumnComment}}
{{- end}}
{{- end}}

}

// Delete{{.JavaName}}ReqVo 删除{{.Comment}}请求参数
type Delete{{.JavaName}}ReqVo struct {
    Ids []int64 `json:"ids" binding:"required"`
}

// Update{{.JavaName}}ReqVo 修改{{.Comment}}请求参数
type Update{{.JavaName}}ReqVo struct {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else }}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" binding:"required"` //{{.ColumnComment}}
{{- end}}
{{- end}}

}

// Update{{.JavaName}}StatusReqVo 修改{{.Comment}}状态请求参数
type Update{{.JavaName}}StatusReqVo struct {
    Ids    []int64 `json:"ids" binding:"required"` //id
    Status int32   `json:"status" binding:"required"` //状态（0:关闭,1:正常 ）
}

// Query{{.JavaName}}DetailReqVo 查询{{.Comment}}详情请求参数
type Query{{.JavaName}}DetailReqVo struct {
    Id   int64 `json:"id" binding:"required"` //id
}

// Query{{.JavaName}}ListReqVo 查询{{.Comment}}列表请求参数
type Query{{.JavaName}}ListReqVo struct {
	PageNo   int    `json:"pageNo" default:"1" binding:"required"`          //第几页
	PageSize int    `json:"pageSize" default:"10" binding:"required"`       //每页的数量
{{- range .TableColumn}}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
{{- end}}
}