<?php

namespace app\model\{{.ModuleName}};

use think\Model;


/**
 * {{.Comment}}模型
 */
class {{.JavaName}}Model extends Model {

    protected string $table = '{{.OriginalName}}';

    // 设置字段信息
    protected array $schema = [
{{- range .TableColumn}}
        '{{.ColumnName}}'    => '{{.DataType}}', //{{.ColumnComment}}
{{- end}}

    ];

    /**
     * 转换成数组
     * @return array
     */
    public function toArray (): array {
        $data = parent::toArray();
        return [
            {{- range .TableColumn}}
            '{{.JavaName}}' => $data['{{.ColumnName}}']?? null, //{{.ColumnComment}}
            {{- end}}
        ];
    }
}