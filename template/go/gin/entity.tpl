package {{.ModuleName}}

import "time"

// {{.JavaName}} {{.Comment}}
type {{.JavaName}} struct {
{{- range .TableColumn}}
  {{- if isContain .GoNamePublic "CreateTime"}}
    {{.GoNamePublic}} {{.GoType}} `gorm:"column:{{.GoName}};default:CURRENT_TIMESTAMP" json:"{{.JavaName}}"` //{{.GoNamePublic}}
    {{- else if isContain .GoNamePublic "UpdateTime"}}
    {{.GoNamePublic}} *{{.GoType}} `gorm:"column:{{.GoName}}" json:"{{.JavaName}}"` //{{.GoNamePublic}}
    {{- else }}
    {{.GoNamePublic}} {{.GoType}} `gorm:"column:{{.GoName}}" json:"{{.JavaName}}"` //{{.GoNamePublic}}
  {{- end}}
{{- end}}
}

func (model {{.JavaName}}) TableName() string {
	return "{{.OriginalName}}"
}
