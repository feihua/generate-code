package v1

/*
{{.Comment}}请求参数和响应
Author: {{.Author}}
Date: {{.CreateTime}}
*/
import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// Add{{.JavaName}}Req 添加{{.Comment}}
type Add{{.JavaName}}Req struct {
	g.Meta `path:"/{{.LowerJavaName}}/save{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"添加{{.Comment}}"`
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else}}
    {{- if eq .IsNullable `YES` }}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" description:"{{.ColumnComment}}"`
    {{- else if eq .JavaName `remark` }}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" description:"{{.ColumnComment}}"`
    {{- else}}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" v:"required#请输入{{.JavaName}}{{.ColumnComment}}" dc:"{{.ColumnComment}}"`
    {{- end}}
{{- end}}
{{- end}}

}
type Add{{.JavaName}}Res struct {
}

// Delete{{.JavaName}}Req 删除{{.Comment}}
type Delete{{.JavaName}}Req struct {
	g.Meta `path:"/{{.LowerJavaName}}/delete{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"删除{{.Comment}}"`
	Ids    []int64 `json:"ids" v:"required#请输入ids" dc:"主键"`
}
type Delete{{.JavaName}}Res struct {
}

// Update{{.JavaName}}Req 更新{{.Comment}}
type Update{{.JavaName}}Req struct {
	g.Meta `path:"/{{.LowerJavaName}}/update{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"更新{{.Comment}}"`
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else}}
    {{- if eq .IsNullable `YES` }}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" description:"{{.ColumnComment}}"`
    {{- else if eq .JavaName `remark` }}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" description:"{{.ColumnComment}}"`
    {{- else}}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" v:"required#请输入{{.JavaName}}{{.ColumnComment}}" dc:"{{.ColumnComment}}"`
    {{- end}}
{{- end}}
{{- end}}
}
type Update{{.JavaName}}Res struct {
}

// Update{{.JavaName}}StatusReq 更新{{.Comment}}状态
type Update{{.JavaName}}StatusReq struct {
	g.Meta `path:"/{{.LowerJavaName}}/update{{.JavaName}}Status" tags:"{{.Comment}}操作" method:"post" summary:"更新{{.Comment}}状态"`
    {{- range .TableColumn}}
    {{- if eq .ColumnKey "PRI"}}
    {{.GoNamePublic}}s {{.GoType}} `json:"{{.JavaName}}s" v:"required#请输入{{.JavaName}}{{.ColumnComment}}" dc:"{{.ColumnComment}}"`
    {{- else if isContain .JavaName "status"}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" v:"required#请输入{{.JavaName}}{{.ColumnComment}}" dc:"{{.ColumnComment}}"`
    {{- else if isContain .JavaName "Status"}}
        {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" v:"required#请输入{{.JavaName}}{{.ColumnComment}}" dc:"{{.ColumnComment}}"`
    {{- else}}
    {{- end}}
    {{- end}}
}
type Update{{.JavaName}}StatusRes struct {
}

// Query{{.JavaName}}DetailReq 查询{{.Comment}}详情
type Query{{.JavaName}}DetailReq struct {
	g.Meta   `path:"/{{.LowerJavaName}}/query{{.JavaName}}Detail" tags:"{{.Comment}}操作" method:"post" summary:"查询{{.Comment}}详情"`
}
type Query{{.JavaName}}DetailRes struct {
	g.Meta   `mime:"application/json" example:"string"`
	Data     {{.JavaName}}Detail    `json:"data"`
	PageNum  int              `json:"pageNum"`
	PageSize int              `json:"pageSize"`
	Total    int              `json:"total"`
}

type {{.JavaName}}Detail struct {
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{if eq .GoType `time.Time`}}gtime.Time{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"{{else}}{{.GoNamePublic}}{{end}} description:"{{.ColumnComment}}"`
{{end}}
}

// Query{{.JavaName}}ListReq 查询{{.Comment}}
type Query{{.JavaName}}ListReq struct {
	g.Meta   `path:"/{{.LowerJavaName}}/query{{.JavaName}}List" tags:"{{.Comment}}操作" method:"post" summary:"查询{{.Comment}}列表"`
	PageNum  int `json:"pageNum" d:"1"  v:"min:0#分页号码错误"     dc:"分页号码，默认1"`
	PageSize int `json:"pageSize" d:"10" v:"max:50#分页数量最大50条" dc:"分页数量，最大50"`
	{{- range .TableColumn}}
    {{- if isContain .JavaName "create"}}
    {{- else if isContain .JavaName "update"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else}}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}" description:"{{.ColumnComment}}"`
    {{- end}}
    {{- end}}
}
type Query{{.JavaName}}ListRes struct {
	g.Meta   `mime:"application/json" example:"string"`
	List     []{{.JavaName}}List `json:"list"`
	PageNum  int              `json:"pageNum"`
	PageSize int              `json:"pageSize"`
	Total    int              `json:"total"`
}

type {{.JavaName}}List struct {
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{if eq .GoType `time.Time`}}gtime.Time{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"{{else}}{{.GoNamePublic}}{{end}} description:"{{.ColumnComment}}"`
{{end}}
}

