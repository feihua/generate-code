package assetmanager_approval_record

/*
{{.Comment}}相关逻辑
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{.ProjectName}}/internal/dao"
	"{{.ProjectName}}/internal/model"
	"{{.ProjectName}}/internal/service"
)

type s{{.JavaName}} struct {
}

func init() {
	service.Register{{.JavaName}}(New())
}

func New() *s{{.JavaName}} {
	return &s{{.JavaName}}{}
}

// Add{{.JavaName}} 添加{{.Comment}}
func (s *s{{.JavaName}}) Add{{.JavaName}}(ctx context.Context, in model.Add{{.JavaName}}Input) (*model.Add{{.JavaName}}Output, error) {

	out := &model.Add{{.JavaName}}Output{}

	_, err := dao.{{.UpperOriginalName}}.Ctx(ctx).Data(in).Insert()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Delete{{.JavaName}} 删除{{.Comment}}
func (s *s{{.JavaName}}) Delete{{.JavaName}}(ctx context.Context, in model.Delete{{.JavaName}}Input) (*model.Delete{{.JavaName}}Output, error) {

	out := &model.Delete{{.JavaName}}Output{}

	_, err := dao.{{.UpperOriginalName}}.Ctx(ctx).WhereIn("id", in.Ids).Delete()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Update{{.JavaName}} 更新{{.Comment}}
func (s *s{{.JavaName}}) Update{{.JavaName}}(ctx context.Context, in model.Update{{.JavaName}}Input) (*model.Update{{.JavaName}}Output, error) {

	out := &model.Update{{.JavaName}}Output{}

	_, err := dao.{{.UpperOriginalName}}.Ctx(ctx).Data(in).Where("id", in.Id).Update()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (s *s{{.JavaName}}) Update{{.JavaName}}Status(ctx context.Context, in model.Update{{.JavaName}}StatusInput) (*model.Update{{.JavaName}}StatusOutput, error) {

	out := &model.Update{{.JavaName}}StatusOutput{}

	_, err := dao.{{.UpperOriginalName}}.Ctx(ctx).Data(in).Where("id", in.Ids).Update()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Record{{.JavaName}}Detail 查询{{.Comment}}详情
func (s *s{{.JavaName}}) Query{{.JavaName}}Detail(ctx context.Context, in model.Query{{.JavaName}}DetailInput) (*model.Query{{.JavaName}}DetailOutput, error) {

	out := &model.Query{{.JavaName}}DetailOutput{}

	record, err := dao.{{.UpperOriginalName}}.Ctx(ctx).Where("id", in.Id).One()
	if err != nil {
		return nil, err
	}

	err = gconv.Struct(record, out.Record)
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Query{{.JavaName}}List 查询{{.Comment}}
func (s *s{{.JavaName}}) Query{{.JavaName}}List(ctx context.Context, in model.Query{{.JavaName}}ListInput) (*model.Query{{.JavaName}}ListOutput, error) {

	out := &model.Query{{.JavaName}}ListOutput{
		PageNum:  in.PageNum,
		PageSize: in.PageSize,
	}
	m := dao.{{.UpperOriginalName}}.Ctx(ctx)

	if err := m.Page(in.PageNum, in.PageSize).Scan(&out.List); err != nil {
		return nil, err
	}

	out.Total, _ = m.Count()
	return out, nil
}
