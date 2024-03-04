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
{{range .TableColumn}}  {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
{{end}}}

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
{{range .TableColumn}}  {{.GoNamePublic}} {{.GoType}} //{{.ColumnComment}}
{{end}}}

// Update{{.JavaName}}Output 更新{{.Comment}}响应
type Update{{.JavaName}}Output struct {
}

// {{.JavaName}}Input 查询{{.Comment}}参数
type {{.JavaName}}Input struct {
	Id int `json:"id"`
}

// {{.JavaName}}Output 查询{{.Comment}}响应
type {{.JavaName}}Output struct {
	Record Query{{.JavaName}}ListOutputItem `json:"record"`
}

// Query{{.JavaName}}ListInput 查询{{.Comment}}参数
type Query{{.JavaName}}ListInput struct {
	PageNum  int `json:"pageNum"`
	PageSize int `json:"pageSize"`
}

// Query{{.JavaName}}ListOutput 查询{{.Comment}}响应
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
