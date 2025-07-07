-- DDL建表语句
drop table if exists {{.TableName}};
create table {{.TableName}}
(
    id             bigint auto_increment primary key not null comment '主键ID',
{{- range .Columns}}
    {{.Name}} {{.DataType}}  {{- if eq .NotNull true }} not null{{else}} null{{- end}} comment '{{.Comment}}',
{{- end}}
    create_by      bigint                                 not null comment '创建人ID',
    create_time    datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    update_by      bigint                                 null comment '更新人ID',
    update_time    datetime                               null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted     tinyint      default 0                 not null comment '是否删除'
)
    comment '{{.TableName}}表';

-- 索引建议
{{- range .Indexes}}
{{.}}
{{- end}}