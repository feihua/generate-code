package {{.ModuleName}}

/*
// 添加{{.Comment}}
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

// Add{{.JavaName}} 添加{{.Comment}}
func (c *ControllerV1) Add{{.JavaName}}(ctx context.Context, req *v1.Add{{.JavaName}}Req) (res *v1.Add{{.JavaName}}Res, err error) {
	var input = model.Add{{.JavaName}}Input{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{.JavaName}}().Add{{.JavaName}}(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Add{{.JavaName}}Res{}

	return
}
