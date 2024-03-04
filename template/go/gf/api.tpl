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
	g.Meta `path:"/{{.LowerJavaName}}/save{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"添加{{.Comment}}表"`
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"{{else}}{{.GoNamePublic}}{{end}} description:"{{.ColumnComment}}"`
{{end}}}
type Add{{.JavaName}}Res struct {
}

// Delete{{.JavaName}}Req 删除{{.Comment}}
type Delete{{.JavaName}}Req struct {
	g.Meta `path:"/{{.LowerJavaName}}/delete{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"删除{{.Comment}}表"`
	Ids    []int64 `json:"ids" v:"required#请输入ids" dc:"主键"`
}
type Delete{{.JavaName}}Res struct {
}

// Update{{.JavaName}}Req 更新{{.Comment}}
type Update{{.JavaName}}Req struct {
	g.Meta `path:"/{{.LowerJavaName}}/update{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"更新{{.Comment}}表"`
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"{{else}}{{.GoNamePublic}}{{end}} description:"{{.ColumnComment}}"`
{{end}}}
type Update{{.JavaName}}Res struct {
}

// Query{{.JavaName}}ListReq 查询{{.Comment}}
type Query{{.JavaName}}ListReq struct {
	g.Meta   `path:"/{{.LowerJavaName}}/query{{.JavaName}}List" tags:"{{.Comment}}操作" method:"post" summary:"查询{{.Comment}}信息表列表"`
	PageNum  int `json:"pageNum" d:"1"  v:"min:0#分页号码错误"     dc:"分页号码，默认1"`
	PageSize int `json:"pageSize" d:"10" v:"max:50#分页数量最大50条" dc:"分页数量，最大50"`
}
type Query{{.JavaName}}ListRes struct {
	g.Meta   `mime:"application/json" example:"string"`
	List     []{{.JavaName}} `json:"list"`
	PageNum  int              `json:"pageNum"`
	PageSize int              `json:"pageSize"`
	Total    int              `json:"total"`
}

type {{.JavaName}} struct {
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{if eq .GoType `time.Time`}}gtime.Time{{else}}{{.GoType}}{{end}} `json:"{{.JavaName}}"{{else}}{{.GoNamePublic}}{{end}} description:"{{.ColumnComment}}"`
{{end}}}

