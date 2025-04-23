namespace core_admin.Dto.Response.{{.ModuleName}}.{{.JavaName}};

/// <summary>
/// {{.Comment}}响应vo
/// </summary>
public class {{.JavaName}}Vo {
{{- range .TableColumn}}
    /// <summary>
    /// {{.ColumnComment}}
    /// </summary>
    public {{.NetType}} {{.NetName}} { get; set; }
{{- end}}
}