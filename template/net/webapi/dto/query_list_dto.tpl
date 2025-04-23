using core_admin.Dto.Common;

namespace core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};

/// <summary>
/// 查询{{.Comment}}请求dto
/// </summary>
public class Query{{.JavaName}}ListDto : PageRequestDto {
{{- range .TableColumn}}
	{{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
	{{- else if eq .GoType "time.Time"}}
    {{- else}}
    /// <summary>
    /// {{.ColumnComment}}
    /// </summary>
    public {{.NetType}}? {{.NetName}} { get; set; }
	{{- end}}
	{{- end}}
}