package {{.ModuleName}}

/*
// 查询{{.Comment}}
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"github.com/feihua/{{.ProjectName}}/internal/model"
	"github.com/feihua/{{.ProjectName}}/internal/service"

	"github.com/feihua/{{.ProjectName}}/api/{{.ModuleName}}/v1"
)

 // Query{{.JavaName}}List 查询{{.Comment}}
func (c *ControllerV1) Query{{.JavaName}}List(ctx context.Context, req *v1.Query{{.JavaName}}ListReq) (res *v1.Query{{.JavaName}}ListRes, err error) {
	var input = model.Query{{.JavaName}}ListInput{}

	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	output, err := service.{{.JavaName}}().Query{{.JavaName}}List(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Query{{.JavaName}}ListRes{}

	err = gconv.Struct(output, res)
	if err != nil {
		return nil, err
	}

	return
}
