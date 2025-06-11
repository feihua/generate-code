package mymongo

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

// {{.JavaName}} {{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type {{.JavaName}} struct {
    ID             primitive.ObjectID `bson:"_id,omitempty" json:"id,omitempty"`// 主键
{{- range .TableColumn}}
   {{- if eq .ColumnKey "PRI"}}
  {{- else}}
    {{.GoNamePublic}} {{.GoType}} `bson:"{{.JavaName}},omitempty" json:"{{.JavaName}},omitempty"` //{{.ColumnComment}}
{{- end}}
{{- end}}
}
