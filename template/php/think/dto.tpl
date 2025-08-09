<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;
use Exception;


/**
 * {{.Comment}}请求参数
 */
class {{.JavaName}}Dto extends BaseDto {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else if eq .GoType "string"}}
    public string ${{.JavaName}}; //{{.ColumnComment}}
{{- else }}
    public int ${{.JavaName}} ; //{{.ColumnComment}}
{{- end}}
{{- end}}


    /**
     * @throws Exception
     */
    public function addValidate (): void {
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

    /**
     * @throws Exception
     */
    public function updateValidate (): void {
    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .GoType "string"}}
        if (empty($this->{{.JavaName}})) {
            throw new Exception('{{.ColumnComment}}不能为空');
        }
    {{- else }}
    {{- end}}
    {{- end}}

    }

    /**
     * 转换成数组
     * @return array
     */
    public function toArray (): array {
        return [
                {{- range .TableColumn}}
                {{- if isContain .GoNamePublic "Create"}}
                {{- else if isContain .GoNamePublic "Update"}}
                {{- else }}
                            '{{.ColumnName}}' => $this->{{.JavaName}}, //{{.ColumnComment}}
                {{- end}}
                {{- end}}
             ];
        }
}