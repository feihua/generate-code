package v1

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// {{.JavaName}}AddReq 添加
type {{.JavaName}}AddReq struct {
	g.Meta `path:"/{{.LowerJavaName}}/save{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"添加{{.Comment}}表"`
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"{{else}}{{.GoNamePublic}}{{end}} description:"{{.ColumnComment}}"`
{{end}}}
type {{.JavaName}}AddRes struct {
}

// {{.JavaName}}DeleteReq 删除
type {{.JavaName}}DeleteReq struct {
	g.Meta `path:"/{{.LowerJavaName}}/delete{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"删除{{.Comment}}表"`
	Ids    []int64 `json:"ids" v:"required#请输入ids" dc:"主键"`
}
type {{.JavaName}}DeleteRes struct {
}

// {{.JavaName}}UpdateReq 更新
type {{.JavaName}}UpdateReq struct {
	g.Meta `path:"/{{.LowerJavaName}}/update{{.JavaName}}" tags:"{{.Comment}}操作" method:"post" summary:"更新{{.Comment}}表"`
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"{{else}}{{.GoNamePublic}}{{end}} description:"{{.ColumnComment}}"`
{{end}}}
type {{.JavaName}}UpdateRes struct {
}

// {{.JavaName}}ListReq 查询
type {{.JavaName}}ListReq struct {
	g.Meta   `path:"/{{.LowerJavaName}}/query{{.JavaName}}List" tags:"{{.Comment}}操作" method:"post" summary:"查询{{.Comment}}信息表列表"`
	PageNum  int `json:"pageNum" d:"1"  v:"min:0#分页号码错误"     dc:"分页号码，默认1"`
	PageSize int `json:"pageSize" d:"10" v:"max:50#分页数量最大50条" dc:"分页数量，最大50"`
}
type {{.JavaName}}ListRes struct {
	g.Meta   `mime:"application/json" example:"string"`
	List     []{{.JavaName}} `json:"list"`
	PageNum  int              `json:"pageNum"`
	PageSize int              `json:"pageSize"`
	Total    int              `json:"total"`
}

type {{.JavaName}} struct {
	{{.JavaName}}Id int         `json:"{{.LowerJavaName}}Id" description:"主键"`
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"{{else}}{{.GoNamePublic}}{{end}} description:"{{.ColumnComment}}"`
{{end}}}

