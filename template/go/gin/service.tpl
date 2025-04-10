package {{.GoName}}

import (
	b "{{.ProjectName}}/internal/dto/{{.ModuleName}}"
	a "{{.ProjectName}}/internal/model/{{.ModuleName}}"
)

// {{.JavaName}}Service {{.Comment}}操作接口
type {{.JavaName}}Service interface {
	// Create{{.JavaName}} 添加{{.Comment}}
	Create{{.JavaName}}(dto b.Add{{.JavaName}}Dto) error
    // Delete{{.JavaName}}ByIds 删除{{.Comment}}
    Delete{{.JavaName}}ByIds(ids []int64) error
 	// Update{{.JavaName}} 更新{{.Comment}}
 	Update{{.JavaName}}(dto b.Update{{.JavaName}}Dto) error
 	// Update{{.JavaName}}Status 更新{{.Comment}}状态
 	Update{{.JavaName}}Status(dto b.Update{{.JavaName}}StatusDto) error
	// Query{{.JavaName}}Detail 查询{{.Comment}}详情
	Query{{.JavaName}}Detail(dto b.Query{{.JavaName}}DetailDto) (a.{{.JavaName}}, error)
	// Query{{.JavaName}}ById 根据id查询{{.Comment}}详情
    Query{{.JavaName}}ById(id int64) (a.{{.JavaName}}, error)
	// Query{{.JavaName}}List 查询{{.Comment}}列表
	Query{{.JavaName}}List(dto b.Query{{.JavaName}}ListDto) ([]a.{{.JavaName}}, int64)

}
