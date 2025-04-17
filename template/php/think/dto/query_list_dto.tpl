<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;

/**
 * {{.Comment}}列表查询参数
 */
class Query{{.JavaName}}ListDto extends BaseDto {
    public int $pageNo = 1;
    public int $pageSize = 10;

{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Sort"}}
{{- else if isContain .GoNamePublic "Remark"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else if eq .GoType "string"}}
    public string ${{.JavaName}}; //{{.ColumnComment}}
{{- else }}
    public int ${{.JavaName}} =2 ; //{{.ColumnComment}}
{{- end}}
{{- end}}

}

