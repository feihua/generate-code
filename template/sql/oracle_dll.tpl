-- DDL建表语句
drop table {{.TableName}};
create table {{.TableName}}
(
    ID             NUMBER NOT NULL,
{{- range .Columns}}
    {{.Name}} {{.DataType}}  {{- if eq .NotNull true }} NOT NULL{{else}} NULL{{- end}},
{{- end}}
    CREATE_BY      VARCHAR2(32)                                 NOT NULL,
    CREATE_TIME    DATE                               NOT NULL,
    UPDATE_BY      VARCHAR2(32)                                 NULL,
    UPDATE_TIME    DATE                               NULL,
    IS_DELETED     NUMBER      default 0                 NOT NULL
);

-- 添加主键约束
ALTER TABLE {{.TableName}}
    ADD CONSTRAINT PK_{{.TableName}} PRIMARY KEY (ID);

-- 添加序列
CREATE SEQUENCE {{.TableName}}_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- 添加表注释
COMMENT ON TABLE {{.TableName}} IS '{{.TableName}}表';

-- 添加列注释
{{- range .Columns}}
COMMENT ON COLUMN {{.TableName}}.{{.Name}} IS '{{.Comment}}';
{{- end}}
COMMENT ON COLUMN {{.TableName}}.CREATE_BY IS '创建人';
COMMENT ON COLUMN {{.TableName}}.CREATE_TIME IS '创建时间';
COMMENT ON COLUMN {{.TableName}}.UPDATE_BY IS '更新人';
COMMENT ON COLUMN {{.TableName}}.UPDATE_TIME IS '更新时间';
COMMENT ON COLUMN {{.TableName}}.IS_DELETED IS '是否删除';

-- 索引建议
{{- range .Indexes}}
{{.}}
{{- end}}