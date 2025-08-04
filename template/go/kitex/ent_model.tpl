package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/dialect/entsql"
	"entgo.io/ent/schema"
	"entgo.io/ent/schema/field"
)

// {{.JavaName}} holds the schema definition for the {{.JavaName}} entity.
type {{.JavaName}} struct {
	ent.Schema
}

func ({{.JavaName}}) Annotations() []schema.Annotation {
	return []schema.Annotation{
		entsql.Annotation{
			Table: "TestUsers",
		},
		entsql.WithComments(true),
		schema.Comment("{{.Comment}}"),
	}
}

// Fields of the {{.JavaName}}.
func ({{.JavaName}}) Fields() []ent.Field {
	fields := []ent.Field{
    {{- range .TableColumn}}
    {{- if isContain .ColumnName "create"}}
    {{- else if isContain .ColumnName "update"}}
    {{- else if isContain .ColumnName "status"}}
    {{- else if isContain .ColumnName "remark"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if eq .GoType "string"}}
        field.String("{{.ColumnName}}").Comment("{{.ColumnComment}}"),
    {{- else}}
        field.Int8("{{.ColumnName}}").Comment("{{.ColumnComment}}"),
    {{- end}}
    {{- end}}
	}
	mixin := BaseMixin{}
	return append(fields, mixin.Fields()...)
}

// Edges of the {{.JavaName}}.
func ({{.JavaName}}) Edges() []ent.Edge {
	return nil
}
