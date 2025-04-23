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
public class {{.JavaName}}Service : I{{.JavaName}}Service {
    private readonly I{{.JavaName}}Repository _repository;
    private readonly IMapper _mapper;
    private readonly ILogger<{{.JavaName}}Service> _logger;

    public {{.JavaName}}Service(I{{.JavaName}}Repository repository, IMapper mapper, ILogger<{{.JavaName}}Service> logger) {
        _repository = repository;
        _mapper = mapper;
        _logger = logger;
    }

    /// <summary>
    /// 添加{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}Dto"></param>
    /// <returns></returns>
    public async Task<{{.JavaName}}DetailVo> Add{{.JavaName}}Async(Add{{.JavaName}}Dto {{.LowerJavaName}}Dto) {
        var {{.LowerJavaName}} = _mapper.Map<{{.UpperOriginalName}}>({{.LowerJavaName}}Dto);
        {{.LowerJavaName}}.CreateTime = DateTime.Now;

        var {{.LowerJavaName}}Res = await _repository.AddAsync({{.LowerJavaName}});
        var {{.LowerJavaName}}DetailVo = _mapper.Map<{{.JavaName}}DetailVo>({{.LowerJavaName}}Res);
        return {{.LowerJavaName}}DetailVo;
    }

    /// <summary>
    /// 删除{{.Comment}}
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    public async Task Delete{{.JavaName}}Async(Delete{{.JavaName}}Dto dto) {
        await _repository.DeleteAsync(dto.Ids);
    }

    /// <summary>
    /// 更新{{.Comment}}
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    public async Task Update{{.JavaName}}Async(Update{{.JavaName}}Dto dto) {
        var {{.LowerJavaName}} = _mapper.Map<{{.UpperOriginalName}}>(dto);
        await _repository.UpdateAsync({{.LowerJavaName}});
    }

    /// <summary>
    /// 更新{{.Comment}}状态
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    public async Task Update{{.JavaName}}StatusAsync(Update{{.JavaName}}StatusDto dto) {
        await _repository.UpdateStatusAsync(dto.Ids, dto.Status);
    }


    /// <summary>
    /// 根据id获取{{.Comment}}
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    public async Task<{{.JavaName}}DetailVo> Query{{.JavaName}}ByIdAsync(long id) {
        var queryByIdAsync = await _repository.QueryByIdAsync(id);
        if (queryByIdAsync == null) {
            throw new Exception("记录不存在");
        }

        var {{.LowerJavaName}}DetailVo = _mapper.Map<{{.JavaName}}DetailVo>(queryByIdAsync);
        return {{.LowerJavaName}}DetailVo;
    }

    /// <summary>
    /// 查询{{.Comment}}列表
    /// </summary>
    /// <returns></returns>
    public async Task<PageResponseDto<{{.JavaName}}ListVo>> Query{{.JavaName}}sListAsync(Query{{.JavaName}}ListDto dto) {
        // 获取分页数据
        var result = await _repository.QueryListAsync(dto);

        var response = new PageResponseDto<{{.JavaName}}ListVo> {
            Total = result.Total,
            List = _mapper.Map<List<{{.JavaName}}ListVo>>(result.List)
        };

        return response;
    }
}