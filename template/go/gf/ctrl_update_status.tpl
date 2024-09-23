package {{.ModuleName}}

/*
更新{{.Comment}}
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{.ProjectName}}/internal/model"
	"{{.ProjectName}}/internal/service"

	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
)

// Update{{.JavaName}} 更新{{.Comment}}状态
func (c *ControllerV1) Update{{.JavaName}}Status(ctx context.Context, req *v1.Update{{.JavaName}}StatusReq) (res *v1.Update{{.JavaName}}Res, err error) {
	var input = model.Update{{.JavaName}}StatusInput{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{.JavaName}}().Update{{.JavaName}}Status(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Update{{.JavaName}}StatusRes{}

	return
}
