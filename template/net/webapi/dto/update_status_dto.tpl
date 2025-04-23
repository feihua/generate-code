namespace core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};

/// <summary>
/// 更新{{.Comment}}状态请求dto
/// </summary>
public class Update{{.JavaName}}StatusDto {
    /// <summary>
    /// ids 集合
    /// </summary>
    public required long[] Ids { get; set; }

    /// <summary>
    /// 状态（0:关闭,1:正常 ）
    /// </summary>
    public required sbyte Status { get; set; }
}