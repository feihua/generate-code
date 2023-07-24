package v1

import "time"

type {{.JavaName}} struct {
{{range .TableColumn}}  {{$typeLen :=len .GoType}}{{if gt $typeLen 0}}{{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"`{{else}}{{.GoNamePublic}}{{end}}{{$length :=len .ColumnComment}} {{ if gt $length 0}}//{{.ColumnComment}} {{else}}//{{.GoNamePublic}}{{end}}
{{end}}}