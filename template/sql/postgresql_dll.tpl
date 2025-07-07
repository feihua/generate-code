-- DDL建表语句
drop table if exists {{.TableName}};
create table {{.TableName}}
(
    id             BIGSERIAL primary key not null,
{{- range .Columns}}
    {{.Name}} {{.DataType}}  {{- if eq .NotNull true }} not null{{else}} null{{- end}},
{{- end}}
    create_by   VARCHAR(50) DEFAULT '' NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_by   VARCHAR(50) DEFAULT '' NOT NULL,
    update_time TIMESTAMP DEFAULT NULL,
    is_deleted     SMALLINT      default 0                 not null
);

-- 添加表注释
COMMENT ON TABLE {{.TableName}} IS '{{.TableName}}表';

-- 添加列注释
{{- range .Columns}}
COMMENT ON COLUMN {{.TableName}}.{{.Name}} IS '{{.Comment}}';
{{- end}}
COMMENT ON COLUMN {{.TableName}}.create_by IS '创建人';
COMMENT ON COLUMN {{.TableName}}.create_time IS '创建时间';
COMMENT ON COLUMN {{.TableName}}.update_by IS '更新人';
COMMENT ON COLUMN {{.TableName}}.update_time IS '更新时间';
COMMENT ON COLUMN {{.TableName}}.is_deleted IS '是否删除';

-- 索引建议
{{- range .Indexes}}
{{.}}
{{- end}}