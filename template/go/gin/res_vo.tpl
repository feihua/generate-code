package {{.ModuleName}}

import "time"

// {{.JavaName}} {{.Comment}}
type {{.JavaName}} struct {
{{- range .TableColumn}}
    {{.GoNamePublic}} {{.GoType}} `json:"{{.JavaName}}"` //{{.ColumnComment}}
{{- end}}
}

