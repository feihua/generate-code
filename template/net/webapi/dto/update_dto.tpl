namespace core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};

/// <summary>
/// 更新{{.Comment}}请求dto
/// </summary>
public class Update{{.JavaName}}Dto {
{{- range .TableColumn}}
{{- if isContain .GoNamePublic "Create"}}
{{- else if isContain .GoNamePublic "Update"}}
{{- else }}
    /// <summary>
    /// {{.ColumnComment}}
    /// </summary>
    public {{.NetType}} {{.NetName}} { get; set; }
{{- end}}
{{- end}}
}