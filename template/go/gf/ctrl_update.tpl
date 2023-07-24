package {{.ModuleName}}

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{.ProjectName}}/internal/model"
	"{{.ProjectName}}/internal/service"

	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
)

func (c *ControllerV1) {{.JavaName}}Update(ctx context.Context, req *v1.{{.JavaName}}UpdateReq) (res *v1.{{.JavaName}}UpdateRes, err error) {
	var input = model.{{.JavaName}}UpdateInput{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{.JavaName}}().Update(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.{{.JavaName}}UpdateRes{}

	return
}
