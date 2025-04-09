package {{.ModuleName}}

import "time"

// {{.JavaName}} {{.Comment}}
type {{.JavaName}} struct {
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{.GoType}} `gorm:"column:{{.GoName}}" json:"{{.JavaName}}"`{{else}}{{.GoNamePublic}}{{end}}{{$length :=len .ColumnComment}} {{ if gt $length 0}}//{{.ColumnComment}} {{else}}//{{.GoNamePublic}}{{end}}
{{end}}}

func (model {{.JavaName}}) TableName() string {
	return "{{.OriginalName}}"
}
