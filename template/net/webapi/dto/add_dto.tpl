namespace core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};

/// <summary>
/// 添加{{.Comment}}请求dto
/// </summary>
public class Add{{.JavaName}}Dto {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else }}
    /// <summary>
    /// {{.ColumnComment}}
    /// </summary>
    public {{.NetType}} {{.NetName}} { get; set; }
{{- end}}
{{- end}}
}