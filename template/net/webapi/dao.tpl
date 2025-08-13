using core_admin.Dto.Common;
using core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};
using core_admin.Models.{{.ModuleName}};

namespace core_admin.Repository.Interfaces.{{.ModuleName}};

/// <summary>
/// {{.Comment}}仓储相关接口
/// </summary>
public interface I{{.JavaName}}Repository {
    /// <summary>
    /// 添加{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}"></param>
    /// <returns></returns>
    Task<{{.UpperOriginalName}}> Add({{.UpperOriginalName}} {{.LowerJavaName}});

    /// <summary>
    /// 删除{{.Comment}}
    /// </summary>
    /// <param name="ids"></param>
    /// <returns></returns>
    Task Delete(long[] ids);

    /// <summary>
    /// 更新{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}"></param>
    /// <returns></returns>
    Task Update({{.UpperOriginalName}} {{.LowerJavaName}});

    /// <summary>
    /// 更新{{.Comment}}状态
    /// </summary>
    /// <param name="ids"></param>
    /// <param name="status"></param>
    /// <returns></returns>
    Task UpdateStatus(long[] ids, sbyte status);

    /// <summary>
    /// 根据id获取{{.Comment}}
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    Task<{{.UpperOriginalName}}?> QueryById(long id);

    /// <summary>
    /// 查询{{.Comment}}列表
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    Task<PageResponseDto<{{.UpperOriginalName}}>> QueryList(Query{{.JavaName}}ListDto dto);
}