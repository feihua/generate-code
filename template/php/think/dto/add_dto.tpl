<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;
use think\Exception;


/**
 * 添加{{.Comment}}参数
 */
class Add{{.JavaName}}Dto extends BaseDto {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else if eq .GoType "string"}}
    public string ${{.JavaName}}; //{{.ColumnComment}}
{{- else }}
    public int ${{.JavaName}} ; //{{.ColumnComment}}
{{- end}}
{{- end}}

    public function validate (): void {
    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if eq .GoType "string"}}
        if (empty($this->{{.JavaName}})) {
            throw new Exception('{{.ColumnComment}}不能为空');
        }
    {{- else }}
    {{- end}}
    {{- end}}

    }
}