package {{.ModuleName}}

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{.ProjectName}}/internal/model"
	"{{.ProjectName}}/internal/service"

	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
)

func (c *ControllerV1) {{.JavaName}}List(ctx context.Context, req *v1.{{.JavaName}}ListReq) (res *v1.{{.JavaName}}ListRes, err error) {
	var input = model.{{.JavaName}}ListInput{}

	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	output, err := service.{{.JavaName}}().List(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.{{.JavaName}}ListRes{}

	err = gconv.Struct(output, res)
	if err != nil {
		return nil, err
	}

	return
}
