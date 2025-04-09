package {{.GoName}}


import (
	"{{.ProjectName}}/internal/dao/{{.ModuleName}}"
    a "{{.ProjectName}}/internal/dto/{{.ModuleName}}"
    b "{{.ProjectName}}/internal/model/{{.ModuleName}}"
)

// {{.JavaName}}ServiceImpl {{.Comment}}操作实现
type {{.JavaName}}ServiceImpl struct {
	Dao  *{{.ModuleName}}.{{.JavaName}}Dao
}

func New{{.JavaName}}ServiceImpl(dao *{{.ModuleName}}.{{.JavaName}}Dao) {{.JavaName}}Service {
	return &{{.JavaName}}ServiceImpl{
	    Dao: dao,
	}
}

// Create{{.JavaName}} 添加{{.Comment}}
func (s *{{.JavaName}}ServiceImpl) Create{{.JavaName}}(dto a.Add{{.JavaName}}Dto) error {
	return s.Dao.Create{{.JavaName}}(dto)
}

// Delete{{.JavaName}}ByIds 删除{{.Comment}}
func (s *{{.JavaName}}ServiceImpl) Delete{{.JavaName}}ByIds(ids []int64) error {
	return s.Dao.Delete{{.JavaName}}ByIds(ids)
}

// Update{{.JavaName}} 更新{{.Comment}}
func (s *{{.JavaName}}ServiceImpl) Update{{.JavaName}}(dto a.Update{{.JavaName}}Dto) error {
	return s.Dao.Update{{.JavaName}}(dto)
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (s *{{.JavaName}}ServiceImpl) Update{{.JavaName}}Status(dto a.Update{{.JavaName}}StatusDto) error {
	return s.Dao.Update{{.JavaName}}Status(dto)
}

// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (s *{{.JavaName}}ServiceImpl) Query{{.JavaName}}Detail(dto a.Query{{.JavaName}}DetailDto) (b.{{.JavaName}}, error) {
	return s.Dao.Query{{.JavaName}}Detail(dto)
}

// Query{{.JavaName}}List 查询{{.Comment}}列表
func (s *{{.JavaName}}ServiceImpl) Query{{.JavaName}}List(dto a.Query{{.JavaName}}ListDto) ([]b.{{.JavaName}}, int64) {
	return s.Dao.Query{{.JavaName}}List(dto)
}


