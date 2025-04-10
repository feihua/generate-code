package {{.GoName}}

import (
	d "{{.ProjectName}}/internal/dto/{{.ModuleName}}"

)

// {{.JavaName}}Service {{.Comment}}操作接口
type {{.JavaName}}Service interface {
	// Create{{.JavaName}} 添加{{.Comment}}
	Create{{.JavaName}}(dto d.Add{{.JavaName}}Dto) error
    // Delete{{.JavaName}}ByIds 删除{{.Comment}}
    Delete{{.JavaName}}ByIds(ids []int64) error
 	// Update{{.JavaName}} 更新{{.Comment}}
 	Update{{.JavaName}}(dto d.Update{{.JavaName}}Dto) error
 	// Update{{.JavaName}}Status 更新{{.Comment}}状态
 	Update{{.JavaName}}Status(dto d.Update{{.JavaName}}StatusDto) error
	// Query{{.JavaName}}Detail 查询{{.Comment}}详情
	Query{{.JavaName}}Detail(dto d.Query{{.JavaName}}DetailDto) (*d.Query{{.JavaName}}ListDtoResp, error)
	// Query{{.JavaName}}ById 根据id查询{{.Comment}}详情
    Query{{.JavaName}}ById(id int64) (*d.Query{{.JavaName}}ListDtoResp, error)
	// Query{{.JavaName}}List 查询{{.Comment}}列表
	Query{{.JavaName}}List(dto d.Query{{.JavaName}}ListDto) ([]*d.Query{{.JavaName}}ListDtoResp, int64, error)

}
