<?php

namespace app\model\{{.ModuleName}};

use think\Model;


/**
 * {{.Comment}}模型
 */
class {{.JavaName}}Model extends Model {

    Customize Toolbar… = '{{.OriginalName}}';

    // 设置字段信息
    protected array $schema = [
{{- range .TableColumn}}
        '{{.ColumnName}}'    => '{{.DataType}}', //{{.ColumnComment}}
{{- end}}

    ];
}