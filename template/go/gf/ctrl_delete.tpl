package {{.ModuleName}}

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{.ProjectName}}/internal/model"
	"{{.ProjectName}}/internal/service"

	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
)

func (c *ControllerV1) {{.JavaName}}Delete(ctx context.Context, req *v1.{{.JavaName}}DeleteReq) (res *v1.{{.JavaName}}DeleteRes, err error) {
	var input = model.{{.JavaName}}DeleteInput{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{.JavaName}}().Delete(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.{{.JavaName}}DeleteRes{}

	return
}
