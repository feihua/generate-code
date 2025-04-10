package {{.GoName}}


import (
	"errors"
	"{{.ProjectName}}/internal/dao/{{.ModuleName}}"
	"{{.ProjectName}}/pkg/utils"
    d "{{.ProjectName}}/internal/dto/{{.ModuleName}}"
    "time"
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
func (s *{{.JavaName}}ServiceImpl) Create{{.JavaName}}(dto d.Add{{.JavaName}}Dto) error {
	return s.Dao.Create{{.JavaName}}(dto)
}

// Delete{{.JavaName}}ByIds 删除{{.Comment}}
func (s *{{.JavaName}}ServiceImpl) Delete{{.JavaName}}ByIds(ids []int64) error {
	return s.Dao.Delete{{.JavaName}}ByIds(ids)
}

// Update{{.JavaName}} 更新{{.Comment}}
func (s *{{.JavaName}}ServiceImpl) Update{{.JavaName}}(dto d.Update{{.JavaName}}Dto) error {
    item, err := s.Dao.Query{{.JavaName}}ById(dto.Id)
    
	if err != nil {
		return err
	}

	if item == nil {
		return errors.New("{{.Comment}}不存在")
	}

	dto.CreateBy = item.CreateBy
	dto.CreateTime = item.CreateTime
	dto.UpdateTime = time.Now()
	return s.Dao.Update{{.JavaName}}(dto)
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (s *{{.JavaName}}ServiceImpl) Update{{.JavaName}}Status(dto d.Update{{.JavaName}}StatusDto) error {
	return s.Dao.Update{{.JavaName}}Status(dto)
}

// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (s *{{.JavaName}}ServiceImpl) Query{{.JavaName}}Detail(dto d.Query{{.JavaName}}DetailDto) (*d.Query{{.JavaName}}ListDtoResp, error) {
	item, err := s.Dao.Query{{.JavaName}}Detail(dto)

	if err != nil {
		return nil, err
	}

	if item == nil {
		return nil, errors.New("{{.Comment}}不存在")
	}

	return &d.Query{{.JavaName}}ListDtoResp{
        {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "CreateTime"}}
        CreateTime:    utils.TimeToStr(item.CreateTime), //{{.ColumnComment}}
        {{- else if isContain .GoNamePublic "UpdateTime"}}
        UpdateTime:    utils.TimeToString(item.UpdateTime), //{{.ColumnComment}}
        {{- else }}
        {{.GoNamePublic}}:item.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
	}, nil

}

// Query{{.JavaName}}ById 根据id查询{{.Comment}}详情
func (s *{{.JavaName}}ServiceImpl) Query{{.JavaName}}ById(id int64) (*d.Query{{.JavaName}}ListDtoResp, error) {
	item, err := s.Dao.Query{{.JavaName}}ById(id)

	if err != nil {
		return nil, err
	}

	if item == nil {
		return nil, errors.New("{{.Comment}}不存在")
	}

	return &d.Query{{.JavaName}}ListDtoResp{
        {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "CreateTime"}}
        CreateTime:    utils.TimeToStr(item.CreateTime), //{{.ColumnComment}}
        {{- else if isContain .GoNamePublic "UpdateTime"}}
        UpdateTime:    utils.TimeToString(item.UpdateTime), //{{.ColumnComment}}
        {{- else }}
        {{.GoNamePublic}}:item.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
	}, nil

}
// Query{{.JavaName}}List 查询{{.Comment}}列表
func (s *{{.JavaName}}ServiceImpl) Query{{.JavaName}}List(dto d.Query{{.JavaName}}ListDto) ([]*d.Query{{.JavaName}}ListDtoResp, int64, error) {
	result, i, err := s.Dao.Query{{.JavaName}}List(dto)

	if err != nil {
		return nil, 0, err
	}

	var list []*d.Query{{.JavaName}}ListDtoResp

	for _, item := range result {
		resp := &d.Query{{.JavaName}}ListDtoResp{
        {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "CreateTime"}}
        CreateTime:    utils.TimeToStr(item.CreateTime), //{{.ColumnComment}}
        {{- else if isContain .GoNamePublic "UpdateTime"}}
        UpdateTime:    utils.TimeToString(item.UpdateTime), //{{.ColumnComment}}
        {{- else }}
        {{.GoNamePublic}}:item.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
    }

		list = append(list, resp)
	}

	return list, i, nil
}


