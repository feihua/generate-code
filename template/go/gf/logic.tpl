package assetmanager_approval_record

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

// Add 添加待办任务
func (s *s{{.JavaName}}) Add(ctx context.Context, in model.{{.JavaName}}AddInput) (*model.{{.JavaName}}AddOutput, error) {

	out := &model.{{.JavaName}}AddOutput{}

	_, err := dao.{{.UpperOriginalName}}.Ctx(ctx).Data(in).Insert()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Delete 删除待办任务
func (s *s{{.JavaName}}) Delete(ctx context.Context, in model.{{.JavaName}}DeleteInput) (*model.{{.JavaName}}DeleteOutput, error) {

	out := &model.{{.JavaName}}DeleteOutput{}

	_, err := dao.{{.UpperOriginalName}}.Ctx(ctx).WhereIn("id", in.Ids).Delete()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Update 更新待办任务
func (s *s{{.JavaName}}) Update(ctx context.Context, in model.{{.JavaName}}UpdateInput) (*model.{{.JavaName}}UpdateOutput, error) {

	out := &model.{{.JavaName}}UpdateOutput{}

	_, err := dao.{{.UpperOriginalName}}.Ctx(ctx).Data(in).Where("id", in.{{.JavaName}}Id).Update()
	if err != nil {
		return nil, err
	}

	return out, nil
}

// Record 查询单条待办任务
func (s *s{{.JavaName}}) Record(ctx context.Context, in model.{{.JavaName}}Input) (*model.{{.JavaName}}Output, error) {

	out := &model.{{.JavaName}}Output{}

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

// List 查询待办任务
func (s *s{{.JavaName}}) List(ctx context.Context, in model.{{.JavaName}}ListInput) (*model.{{.JavaName}}ListOutput, error) {

	out := &model.{{.JavaName}}ListOutput{
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
