namespace core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};

/// <summary>
/// 删除{{.Comment}}请求dto
/// </summary>
public class Delete{{.JavaName}}Dto {
    /// <summary>
    /// ids 集合
    /// </summary>
    public required long[] Ids { get; set; }
}