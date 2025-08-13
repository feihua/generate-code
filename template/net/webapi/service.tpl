using core_admin.Dto.Common;
using core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};
using core_admin.Dto.Response.{{.ModuleName}}.{{.JavaName}};

namespace core_admin.Service.Interfaces.{{.ModuleName}};

/// <summary>
/// {{.Comment}}相关服务接口
/// </summary>
public interface I{{.JavaName}}Service {
    /// <summary>
    /// 添加{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}Dto"></param>
    /// <returns></returns>
    Task<{{.JavaName}}DetailVo> Add{{.JavaName}}(Add{{.JavaName}}Dto {{.LowerJavaName}}Dto);

    /// <summary>
    /// 删除{{.Comment}}
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    Task Delete{{.JavaName}}(Delete{{.JavaName}}Dto dto);

    /// <summary>
    /// 更新{{.Comment}}
    /// </summary>
    /// <param name="sys{{.JavaName}}"></param>
    /// <returns></returns>
    Task Update{{.JavaName}}(Update{{.JavaName}}Dto sys{{.JavaName}});

    /// <summary>
    /// 更新{{.Comment}}状态
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    Task Update{{.JavaName}}Status(Update{{.JavaName}}StatusDto dto);

    /// <summary>
    /// 根据id获取{{.Comment}}
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    Task<{{.JavaName}}DetailVo> Query{{.JavaName}}ById(long id);

    /// <summary>
    /// 查询{{.Comment}}列表
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    Task<PageResponseDto<{{.JavaName}}ListVo>> Query{{.JavaName}}sList(Query{{.JavaName}}ListDto dto);
}