package model

/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// Add{{.JavaName}}Input 添加{{.Comment}}参数
type Add{{.JavaName}}Input struct {
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else}}
    {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
{{- end}}
{{- end}}
}


// Add{{.JavaName}}Output 添加{{.Comment}}响应
type Add{{.JavaName}}Output struct {
}

// Delete{{.JavaName}}Input 删除{{.Comment}}参数
type Delete{{.JavaName}}Input struct {
	Ids []int `json:"ids"`
}

// Delete{{.JavaName}}Output 删除{{.Comment}}响应
type Delete{{.JavaName}}Output struct {
}

// Update{{.JavaName}}Input 更新{{.Comment}}参数
type Update{{.JavaName}}Input struct {
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else}}
  {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
{{- end}}
{{- end}}
}

// Update{{.JavaName}}Output 更新{{.Comment}}响应
type Update{{.JavaName}}Output struct {
}

// Update{{.JavaName}}StatusInput 更新{{.Comment}}状态参数
type Update{{.JavaName}}StatusInput struct {
    {{- range .TableColumn}}
    {{- if eq .ColumnKey "PRI"}}
    {{.GoNamePublic}}s {{.GoType}} //{{.ColumnComment}}
    {{- else if isContain .JavaName "status"}}
    {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
    {{- else if isContain .JavaName "Status"}}
    {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
    {{- else}}
    {{- end}}
    {{- end}}
}

// Update{{.JavaName}}StatusOutput 更新{{.Comment}}状态响应
type Update{{.JavaName}}StatusOutput struct {
}


// {{.JavaName}}DetailInput 查询{{.Comment}}详情参数
type Query{{.JavaName}}DetailInput struct {
	Id int `json:"id"`
}

// {{.JavaName}}DetailOutput 查询{{.Comment}}详情响应
type Query{{.JavaName}}DetailOutput struct {
	Record Query{{.JavaName}}DetailOutputItem `json:"record"`
}

 // Query{{.JavaName}}DetailOutputItem 查询{{.Comment}}响应
type Query{{.JavaName}}DetailOutputItem struct {
{{range .TableColumn}}  {{.GoNamePublic}} {{if eq .GoType `time.Time`}}gtime.Time{{else}}{{.GoType}}{{end}} //{{.ColumnComment}}
{{end}}}


// Query{{.JavaName}}ListInput 查询{{.Comment}}列表参数
type Query{{.JavaName}}ListInput struct {
	PageNum  int `json:"pageNum"`
	PageSize int `json:"pageSize"`
	{{- range .TableColumn}}
    {{- if isContain .JavaName "create"}}
    {{- else if isContain .JavaName "update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if eq .ColumnKey "sort"}}
    {{- else if eq .ColumnKey "Sort"}}
    {{- else if eq .ColumnKey "remark"}}
    {{- else}}
    {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
    {{- end}}
    {{- end}}
}

// Query{{.JavaName}}ListOutput 查询{{.Comment}}列表响应
type Query{{.JavaName}}ListOutput struct {
	List     []Query{{.JavaName}}ListOutputItem `json:"list"`
	PageNum  int                            `json:"pageNum"`
	PageSize int                            `json:"pageSize"`
	Total    int                            `json:"total"`
}

 // Query{{.JavaName}}ListOutputItem 查询{{.Comment}}响应
type Query{{.JavaName}}ListOutputItem struct {
{{range .TableColumn}}  {{.GoNamePublic}} {{if eq .GoType `time.Time`}}gtime.Time{{else}}{{.GoType}}{{end}} //{{.ColumnComment}}
{{end}}}
