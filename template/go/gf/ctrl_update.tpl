package {{.ModuleName}}

/*
// 更新{{.Comment}}
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

// Update{{.JavaName}} 更新{{.Comment}}
func (c *ControllerV1) Update{{.JavaName}}(ctx context.Context, req *v1.Update{{.JavaName}}Req) (res *v1.Update{{.JavaName}}Res, err error) {
	var input = model.Update{{.JavaName}}Input{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{.JavaName}}().Update{{.JavaName}}(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Update{{.JavaName}}Res{}

	return
}
