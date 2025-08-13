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
public class {{.JavaName}}Repository(ApplicationDbContext context, ILogger<{{.JavaName}}Repository> logger) : I{{.JavaName}}Repository {

    /// <summary>
    /// 添加{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}"></param>
    /// <returns></returns>
    public async Task<{{.UpperOriginalName}}> Add({{.UpperOriginalName}} {{.LowerJavaName}}) {
        context.{{.UpperOriginalName}}s.Add({{.LowerJavaName}});
        await context.SaveChangesAsync();
        return {{.LowerJavaName}};
    }

    /// <summary>
    /// 删除{{.Comment}}
    /// </summary>
    /// <param name="ids"></param>
    /// <returns></returns>
    public async Task Delete(long[] ids) {
        await context.{{.UpperOriginalName}}s
            .Where(n => ids.Contains(n.Id))
            .ExecuteDeleteAsync();
    }

    /// <summary>
    /// 更新{{.Comment}}
    /// </summary>
    /// <param name="{{.LowerJavaName}}"></param>
    /// <returns></returns>
    public async Task Update({{.UpperOriginalName}} {{.LowerJavaName}}) {
        await context.{{.UpperOriginalName}}s
            .Where(n => n.Id == {{.LowerJavaName}}.Id)
            .ExecuteUpdateAsync(setters => setters
            {{- range .TableColumn}}
            {{- if isContain .GoNamePublic "UpdateBy"}}
                .SetProperty(n => n.UpdateBy, "todo") //更新者
            {{- else if isContain .GoNamePublic "UpdateTime"}}
                .SetProperty(n => n.UpdateTime, DateTime.Now)); //更新时间
            {{- else if eq .ColumnKey "PRI"}}
            {{- else if isContain .GoNamePublic "Create"}}
            {{- else }}
                .SetProperty(n => n.{{.GoNamePublic}}, {{.LowerJavaName}}.{{.GoNamePublic}}) //{{.ColumnComment}}
            {{- end}}
            {{- end}}
    }

    /// <summary>
    /// 更新{{.Comment}}状态
    /// </summary>
    /// <param name="ids"></param>
    /// <param name="status"></param>
    /// <returns></returns>
    public async Task UpdateStatus(long[] ids, sbyte status) {
        var {{.LowerJavaName}}s = await context.{{.UpperOriginalName}}s
            .Where(n => ids.Contains(n.Id))
            .ToListAsync();

        foreach (var {{.LowerJavaName}} in {{.LowerJavaName}}s) {
            {{.LowerJavaName}}.Status = status;
            context.Entry({{.LowerJavaName}}).State = EntityState.Modified;
        }

        await context.SaveChangesAsync();
    }

    /// <summary>
    /// 根据id获取{{.Comment}}
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    public async Task<{{.UpperOriginalName}}?> QueryById(long id) {
        return await context.{{.UpperOriginalName}}s.FindAsync(id);
    }

    /// <summary>
    /// 查询{{.Comment}}列表
    /// </summary>
    /// <param name="dto"></param>
    /// <returns></returns>
    public async Task<PageResponseDto<{{.UpperOriginalName}}>> QueryList(Query{{.JavaName}}ListDto dto) {
        // 构建查询
        var query = context.{{.UpperOriginalName}}s.AsQueryable();

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