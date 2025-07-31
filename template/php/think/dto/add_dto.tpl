<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;
use Exception;


/**
 * 添加{{.Comment}}参数
 */
class Add{{.JavaName}}Dto extends BaseDto {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else if eq .GoType "string"}}
    public string ${{.GoName}}; //{{.ColumnComment}}
{{- else }}
    public int ${{.GoName}} ; //{{.ColumnComment}}
{{- end}}
{{- end}}

    /**
     * @throws Exception
     */
    public function validate (): void {
    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if eq .GoType "string"}}
        if (empty($this->{{.GoName}})) {
            throw new Exception('{{.ColumnComment}}不能为空');
        }
    {{- else }}
    {{- end}}
    {{- end}}

    }
}