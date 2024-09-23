package {{.ModuleName}}

/*
查询{{.Comment}}
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

 // Query{{.JavaName}}List 查询{{.Comment}}详情
func (c *ControllerV1) Query{{.JavaName}}Detail(ctx context.Context, req *v1.Query{{.JavaName}}DetailReq) (res *v1.Query{{.JavaName}}DetailRes, err error) {
	var input = model.Query{{.JavaName}}DetailInput{}

	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	output, err := service.{{.JavaName}}().Query{{.JavaName}}Detail(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Query{{.JavaName}}DetailRes{}

	err = gconv.Struct(output, res)
	if err != nil {
		return nil, err
	}

	return
}
