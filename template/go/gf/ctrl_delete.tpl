package {{.ModuleName}}

/*
删除{{.Comment}}
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

// Delete{{.JavaName}} 删除{{.Comment}}
func (c *ControllerV1) Delete{{.JavaName}}(ctx context.Context, req *v1.Delete{{.JavaName}}Req) (res *v1.Delete{{.JavaName}}Res, err error) {
	var input = model.Delete{{.JavaName}}Input{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{.JavaName}}().Delete{{.JavaName}}(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Delete{{.JavaName}}Res{}

	return
}
