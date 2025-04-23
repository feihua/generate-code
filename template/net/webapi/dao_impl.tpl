using core_admin.Data;
using core_admin.Dto.Common;
using core_admin.Dto.Request.{{.ModuleName}}.{{.JavaName}};
using core_admin.Models.{{.ModuleName}};
using core_admin.Repository.Interfaces.{{.ModuleName}};
using Microsoft.EntityFrameworkCore;

namespace core_admin.Repository.{{.ModuleName}};

/// <summary>
/// {{.Comment}}仓储相关实现
/// </summary>
public class {{.JavaName}}Repository : I{{.JavaName}}Repository {
    private readonly ApplicationDbContext _context;
    private readonly ILogger<{{.JavaName}}Repository> _logger;

    public {{.JavaName}}Repository(ApplicationDbContext context, ILogger<{{.JavaName}}Repository> logger) {
        _context = context;
         _logger = logger;
    }

    /// <summary>
    /// 添加{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}"></param>
    /// <returns></returns>
    public async Task<{{.UpperOriginalName}}> AddAsync({{.UpperOriginalName}} {{.LowerJavaName}}) {
        _context.{{.UpperOriginalName}}s.Add({{.LowerJavaName}});
        await _context.SaveChangesAsync();
        return {{.LowerJavaName}};
    }

    /// <summary>
    /// 删除{{.Comment}}
    /// </summary>
    /// <param name="ids"></param>
    /// <returns></returns>
    public async Task DeleteAsync(long[] ids) {
        foreach (var id in ids) {
            var {{.LowerJavaName}} = await _context.{{.UpperOriginalName}}s.FindAsync(id);
            if ({{.LowerJavaName}} == null) continue;
            _context.{{.UpperOriginalName}}s.Remove({{.LowerJavaName}});
        }

        await _context.SaveChangesAsync();
    }

    /// <summary>
    /// 更新{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}"></param>
    /// <returns></returns>
    public async Task UpdateAsync({{.UpperOriginalName}} {{.LowerJavaName}}) {
        // _context.Entry({{.LowerJavaName}}).State = EntityState.Modified;
        var entity = await _context.{{.UpperOriginalName}}s.FindAsync({{.LowerJavaName}}.Id);
        if (entity == null) {
            return;
        }

        // 保留原有的创建信息
        {{.LowerJavaName}}.CreateTime = entity.CreateTime;
        {{.LowerJavaName}}.CreateBy = entity.CreateBy;
        {{.LowerJavaName}}.UpdateBy = "todo";

        _context.Entry(entity).CurrentValues.SetValues({{.LowerJavaName}});
        await _context.SaveChangesAsync();
    }

    /// <summary>
    /// 更新{{.Comment}}状态
    /// </summary>
    /// <param name="ids"></param>
    /// <param name="status"></param>
    /// <returns></returns>
    public async Task UpdateStatusAsync(long[] ids, sbyte status) {
        var {{.LowerJavaName}}s = await _context.{{.UpperOriginalName}}s
            .Where(n => ids.Contains(n.Id))
            .ToListAsync();

        foreach (var {{.LowerJavaName}} in {{.LowerJavaName}}s) {
            {{.LowerJavaName}}.Status = status;
            _context.Entry({{.LowerJavaName}}).State = EntityState.Modified;
        }

        await _context.SaveChangesAsync();
    }

    /// <summary>
    /// 根据id获取{{.Comment}}
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    public async Task<{{.UpperOriginalName}}?> QueryByIdAsync(long id) {
        return await _context.{{.UpperOriginalName}}s.FindAsync(id);
    }

    /// <summary>
    /// 查询{{.Comment}}列表
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    public async Task<PageResponseDto<{{.UpperOriginalName}}>> QueryListAsync(Query{{.JavaName}}ListDto dto) {
        // 构建查询
        var query = _context.{{.UpperOriginalName}}s.AsQueryable();

{{- range .TableColumn}}
	{{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
	{{- else if eq .GoType "time.Time"}}
	{{- else if eq .NetType "string"}}
        // {{.ColumnComment}}
        if (!string.IsNullOrEmpty(dto.{{.NetName}})) {
            query = query.Where(x => x.{{.NetName}}.Contains(dto.{{.NetName}}));
        }
    {{- else}}
        if (dto.{{.NetName}}.HasValue) {
            query = query.Where(x => x.{{.NetName}} == dto.{{.NetName}});
        }
	{{- end}}
	{{- end}}


        // 获取总记录数
        var total = await query.CountAsync();

        // 添加排序和分页
        var items = await query
            .OrderByDescending(x => x.CreateTime)
            .Skip((dto.PageNo - 1) * dto.PageSize)
            .Take(dto.PageSize)
            .ToListAsync();

        return new PageResponseDto<{{.UpperOriginalName}}> {
            Total = total,
            List = items
        };
    }
}