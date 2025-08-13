using AutoMapper;
using core_admin.Dto.Common;
using core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};
using core_admin.Dto.Response.{{.ModuleName}}.{{.JavaName}};
using core_admin.Models.{{.ModuleName}};
using core_admin.Repository.Interfaces.{{.ModuleName}};
using core_admin.Service.Interfaces.{{.ModuleName}};

namespace core_admin.Service.{{.ModuleName}};

/// <summary>
/// {{.Comment}}相关服务实现
/// </summary>
public class {{.JavaName}}Service(I{{.JavaName}}Repository repository, IMapper mapper, ILogger<{{.JavaName}}Service> logger) : I{{.JavaName}}Service {

    /// <summary>
    /// 添加{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}Dto"></param>
    /// <returns></returns>
    public async Task<{{.JavaName}}DetailVo> Add{{.JavaName}}(Add{{.JavaName}}Dto {{.LowerJavaName}}Dto) {
        var {{.LowerJavaName}} = mapper.Map<{{.UpperOriginalName}}>({{.LowerJavaName}}Dto);
        {{.LowerJavaName}}.CreateTime = DateTime.Now;

        var {{.LowerJavaName}}Res = await repository.Add({{.LowerJavaName}});
        var {{.LowerJavaName}}DetailVo = mapper.Map<{{.JavaName}}DetailVo>({{.LowerJavaName}}Res);
        return {{.LowerJavaName}}DetailVo;
    }

    /// <summary>
    /// 删除{{.Comment}}
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    public async Task Delete{{.JavaName}}(Delete{{.JavaName}}Dto dto) {
        await repository.Delete(dto.Ids);
    }

    /// <summary>
    /// 更新{{.Comment}}
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    public async Task Update{{.JavaName}}(Update{{.JavaName}}Dto dto) {
        var detail = await repository.QueryById(id);
        if (detail == null) {
            throw new Exception("{{.Comment}}不存在");
        }
        var {{.LowerJavaName}} = mapper.Map<{{.UpperOriginalName}}>(dto);
        await repository.Update({{.LowerJavaName}});
    }

    /// <summary>
    /// 更新{{.Comment}}状态
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    public async Task Update{{.JavaName}}Status(Update{{.JavaName}}StatusDto dto) {
        await repository.UpdateStatus(dto.Ids, dto.Status);
    }


    /// <summary>
    /// 根据id获取{{.Comment}}
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    public async Task<{{.JavaName}}DetailVo> Query{{.JavaName}}ById(long id) {
        var detail = await repository.QueryById(id);
        if (detail == null) {
            throw new Exception("{{.Comment}}不存在");
        }

        var {{.LowerJavaName}}DetailVo = mapper.Map<{{.JavaName}}DetailVo>(detail);
        return {{.LowerJavaName}}DetailVo;
    }

    /// <summary>
    /// 查询{{.Comment}}列表
    /// </summary>
    /// <returns></returns>
    public async Task<PageResponseDto<{{.JavaName}}ListVo>> Query{{.JavaName}}sList(Query{{.JavaName}}ListDto dto) {
        // 获取分页数据
        var result = await repository.QueryList(dto);

        return new PageResponseDto<{{.JavaName}}ListVo> {
            Total = result.Total,
            List = mapper.Map<List<{{.JavaName}}ListVo>>(result.List)
        };
    }
}