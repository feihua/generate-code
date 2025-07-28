package {{.ModuleName}}

/*
{{.Comment}}相关逻辑
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{.ProjectName}}/internal/dao"
    "{{.ProjectName}}/internal/model/do"
)

type {{.JavaName}}Service struct {
}

func New{{.JavaName}}Service() *{{.JavaName}}Service {
	return &{{.JavaName}}Service{}
}

// Add{{.JavaName}} 添加{{.Comment}}
func (s *{{.JavaName}}Service) Add{{.JavaName}}(ctx context.Context, req *v1.Add{{.JavaName}}Req) (*v1.Add{{.JavaName}}Res, error) {

    in := &do.{{.JavaName}}{
    {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "CreateTime"}}
        {{- else if isContain .GoNamePublic "Update"}}
        {{- else if eq .ColumnKey "PRI"}}
        {{- else}}
        {{.GoNamePublic}}: req.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
    }

	insertId, err := dao.{{.JavaName}}.Ctx(ctx).Data(in).InsertAndGetId()
	if err != nil {
		return nil, err
	}

	return &v1.Add{{.JavaName}}Res{
		Id: insertId,
	}, nil
}

// Delete{{.JavaName}} 删除{{.Comment}}
func (s *{{.JavaName}}Service) Delete{{.JavaName}}(ctx context.Context, req *v1.Delete{{.JavaName}}Req) (*v1.Delete{{.JavaName}}Res, error) {

	out := &v1.Delete{{.JavaName}}Res{}

	_, err := dao.{{.JavaName}}.Ctx(ctx).WhereIn("id", req.Ids).Delete()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Update{{.JavaName}} 更新{{.Comment}}
func (s *{{.JavaName}}Service) Update{{.JavaName}}(ctx context.Context, req *v1.Update{{.JavaName}}Req) (*v1.Update{{.JavaName}}Res, error) {

	out := &v1.Update{{.JavaName}}Res{}

    in := &do.{{.JavaName}}{
    {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "UpdateTime"}}
        {{- else if isContain .GoNamePublic "Create"}}
        {{- else}}
        {{.GoNamePublic}}: req.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
    }

	_, err := dao.{{.JavaName}}.Ctx(ctx).Data(in).WherePri(req.Id).Update()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (s *{{.JavaName}}Service) Update{{.JavaName}}Status(ctx context.Context, req *v1.Update{{.JavaName}}StatusReq) (*v1.Update{{.JavaName}}StatusRes, error) {

	out := &v1.Update{{.JavaName}}StatusRes{}

    in := &do.{{.JavaName}}{
    {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "Status"}}
        {{.GoNamePublic}}: req.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
    }
	_, err := dao.{{.JavaName}}.Ctx(ctx).Data(in).Where("id", req.Ids).Update()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (s *{{.JavaName}}Service) Query{{.JavaName}}Detail(ctx context.Context, req *v1.Query{{.JavaName}}DetailReq) (*v1.Query{{.JavaName}}DetailRes, error) {

	out := &v1.Query{{.JavaName}}DetailRes{}

	record, err := dao.{{.JavaName}}.Ctx(ctx).Where("id", req.Id).One()
	if err != nil {
		return nil, err
	}

	err = gconv.Struct(record, out.Data)
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Query{{.JavaName}}List 查询{{.Comment}}
func (s *{{.JavaName}}Service) Query{{.JavaName}}List(ctx context.Context, req *v1.Query{{.JavaName}}ListReq) (*v1.Query{{.JavaName}}ListRes, error) {

	out := &v1.Query{{.JavaName}}ListRes{
		PageNum:  req.PageNum,
		PageSize: req.PageSize,
	}
	m := dao.{{.JavaName}}.Ctx(ctx)

	if err := m.Page(req.PageNum, req.PageSize).Scan(&out.List); err != nil {
		return nil, err
	}

	out.Total, _ = m.Count()
	return out, nil
}
