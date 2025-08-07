package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/dialect/entsql"
	"entgo.io/ent/schema"
	"entgo.io/ent/schema/field"
)

// {{.UpperOriginalName}} holds the schema definition for the {{.UpperOriginalName}} entity.
type {{.UpperOriginalName}} struct {
	ent.Schema
}

func ({{.UpperOriginalName}}) Annotations() []schema.Annotation {
	return []schema.Annotation{
		entsql.Annotation{
			Table: "{{.OriginalName}}",
		},
		entsql.WithComments(true),
		schema.Comment("{{.Comment}}"),
	}
}

// Fields of the {{.UpperOriginalName}}.
func ({{.UpperOriginalName}}) Fields() []ent.Field {
	fields := []ent.Field{
    {{- range .TableColumn}}
    {{- if isContain .ColumnName "create"}}
    {{- else if isContain .ColumnName "update"}}
    {{- else if isContain .ColumnName "status"}}
    {{- else if isContain .ColumnName "remark"}}
    {{- else if isContain .ColumnName "del_flag"}}
    {{- else if eq .ColumnName "id"}}
    {{- else if eq .GoType "string"}}
        field.String("{{.ColumnName}}").Comment("{{.ColumnComment}}"),
    {{- else if eq .GoType "int"}}
        field.Int8("{{.ColumnName}}").Comment("{{.ColumnComment}}"),
    {{- else if eq .GoType "tinyint"}}
        field.Int8("{{.ColumnName}}").Comment("{{.ColumnComment}}"),
    {{- else if eq .GoType "float64"}}
        field.Float("{{.ColumnName}}").Comment("{{.ColumnComment}}"),
    {{- else if eq .GoType "time.Time"}}
        field.Time("{{.ColumnName}}").Comment("{{.ColumnComment}}"),
    {{- else}}
        field.Int64("{{.ColumnName}}").Comment("{{.ColumnComment}}"),
    {{- end}}
    {{- end}}
	}
	mixin := BaseMixin{}
	return append(fields, mixin.Fields()...)
}

// Edges of the {{.UpperOriginalName}}.
func ({{.UpperOriginalName}}) Edges() []ent.Edge {
	return nil
}
