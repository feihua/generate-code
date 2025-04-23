using core_admin.Dto.Common;
using core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};
using core_admin.Dto.Response.{{.ModuleName}}.{{.JavaName}};
using core_admin.Service.Interfaces.{{.ModuleName}};
using Microsoft.AspNetCore.Mvc;

namespace core_admin.Controller.{{.ModuleName}};

/// <summary>
/// {{.Comment}}Api
/// </summary>
[ApiController]
[Route("api/system/{{.LowerJavaName}}")]
public class {{.JavaName}}Controller : ControllerBase {
    private readonly I{{.JavaName}}Service _service;
    private readonly ILogger<{{.JavaName}}Controller> _logger;

    public {{.JavaName}}Controller(I{{.JavaName}}Service service, ILogger<{{.JavaName}}Controller> logger) {
        _service = service;
        _logger = logger;
    }

    /// <summary>
    /// 添加{{.Comment}}
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    [HttpPost("add")]
    public async Task<ApiResponse<bool>> Add{{.JavaName}}(Add{{.JavaName}}Dto dto) {
        _logger.LogInformation("添加{{.Comment}}，请求参数：{@Add{{.JavaName}}Dto}", dto);
        try {
            await _service.Add{{.JavaName}}Async(dto);
            return ApiResponse<bool>.Ok(true);
        } catch (Exception ex) {
            return ApiResponse<bool>.Error(ex.Message);
        }
    }

    /// <summary>
    /// 删除{{.Comment}}
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    [HttpPost("delete")]
    public async Task<ApiResponse<bool>> Delete{{.JavaName}}(Delete{{.JavaName}}Dto dto) {
        _logger.LogInformation("删除{{.Comment}}，请求参数：{@Delete{{.JavaName}}Dto}", dto);
        try {
            await _service.Delete{{.JavaName}}Async(dto);
            return ApiResponse<bool>.Ok(true);
        } catch (Exception ex) {
            return ApiResponse<bool>.Error(ex.Message);
        }
    }

    /// <summary>
    /// 更新{{.Comment}}
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    [HttpPost("update")]
    public async Task<ApiResponse<bool>> Update{{.JavaName}}(Update{{.JavaName}}Dto dto) {
        _logger.LogInformation("更新{{.Comment}}，请求参数：{@Update{{.JavaName}}Dto}", dto);
        try {
            await _service.Update{{.JavaName}}Async(dto);
            return ApiResponse<bool>.Ok(true);
        } catch (Exception ex) {
            return ApiResponse<bool>.Error(ex.Message);
        }
    }

    /// <summary>
    /// 更新{{.Comment}}状态
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    [HttpPost("updateStatus")]
    public async Task<ApiResponse<bool>> Update{{.JavaName}}Status(Update{{.JavaName}}StatusDto dto) {
        _logger.LogInformation("更新{{.Comment}}状态，请求参数：{@Update{{.JavaName}}StatusDto}", dto);
        try {
            await _service.Update{{.JavaName}}StatusAsync(dto);
            return ApiResponse<bool>.Ok(true);
        } catch (Exception ex) {
            return ApiResponse<bool>.Error(ex.Message);
        }
    }

    /// <summary>
    /// 根据id获取{{.Comment}}
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    [HttpGet("query/{id}")]
    public async Task<ApiResponse<{{.JavaName}}DetailVo>> Get{{.JavaName}}(long id) {
        _logger.LogInformation("根据id获取{{.Comment}}，请求参数：{@id}", id);
        try {
            var result = await _service.Query{{.JavaName}}ByIdAsync(id);
            return ApiResponse<{{.JavaName}}DetailVo>.Ok(result);
        } catch (Exception ex) {
            return ApiResponse<{{.JavaName}}DetailVo>.Error(ex.Message);
        }
    }

    /// <summary>
    /// 查询{{.Comment}}列表
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    [HttpGet("queryList")]
    public async Task<ApiResponse<PageResponseDto<{{.JavaName}}ListVo>>> Get{{.JavaName}}s([FromQuery] Query{{.JavaName}}ListDto dto) {
        _logger.LogInformation("查询{{.Comment}}列表，请求参数：{@Query{{.JavaName}}ListDtoto}", dto);
        try {
            var result = await _service.Query{{.JavaName}}sListAsync(dto);
            return ApiResponse<PageResponseDto<{{.JavaName}}ListVo>>.Ok(result);
        } catch (Exception ex) {
            return ApiResponse<PageResponseDto<{{.JavaName}}ListVo>>.Error(ex.Message);
        }
    }
}