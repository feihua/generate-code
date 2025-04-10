package {{.ModuleName}}

import "time"

// Add{{.JavaName}}Dto 添加{{.Comment}}请求参数
type Add{{.JavaName}}Dto struct {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else }}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
{{- end}}
{{- end}}

}

// Delete{{.JavaName}}Dto 删除{{.Comment}}请求参数
type Delete{{.JavaName}}Dto struct {
    Ids []int64 `json:"ids"`
}

// Update{{.JavaName}}Dto 修改{{.Comment}}请求参数
type Update{{.JavaName}}Dto struct {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else }}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
{{- end}}
{{- end}}

}

// Update{{.JavaName}}StatusDto 修改{{.Comment}}状态请求参数
type Update{{.JavaName}}StatusDto struct {
    Ids    []int64 `json:"ids"` //id
    Status int32   `json:"status"` //状态（0:关闭,1:正常 ）
}

// Query{{.JavaName}}DetailDto 查询{{.Comment}}详情请求参数
type Query{{.JavaName}}DetailDto struct {
    Id   int64 `json:"id"` //id
}

// Query{{.JavaName}}ListDto 查询{{.Comment}}列表请求参数
type Query{{.JavaName}}ListDto struct {
	PageNo   int    `json:"pageNo" default:"1"`          //第几页
	PageSize int    `json:"pageSize" default:"10"`       //每页的数量
{{- range .TableColumn}}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
{{- end}}
}

// Query{{.JavaName}}ListDtoResp 查询{{.Comment}}列表响应参数
type Query{{.JavaName}}ListDtoResp struct {
{{- range .TableColumn}}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
{{- end}}
}