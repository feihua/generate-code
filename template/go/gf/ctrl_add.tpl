package {{.ModuleName}}

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{.ProjectName}}/internal/model"
	"{{.ProjectName}}/internal/service"

	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
)

func (c *ControllerV1) {{.JavaName}}Add(ctx context.Context, req *v1.{{.JavaName}}AddReq) (res *v1.{{.JavaName}}AddRes, err error) {
	var input = model.{{.JavaName}}AddInput{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{.JavaName}}().Add(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.{{.JavaName}}AddRes{}

	return
}
