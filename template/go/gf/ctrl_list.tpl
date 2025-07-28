package {{.ModuleName}}

/*
查询{{.Comment}}
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"context"
	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
	"{{.ProjectName}}/internal/service/{{.ModuleName}}"

)

 // Query{{.JavaName}}List 查询{{.Comment}}列表
func (c *ControllerV1) Query{{.JavaName}}List(ctx context.Context, req *v1.Query{{.JavaName}}ListReq) (res *v1.Query{{.JavaName}}ListRes, err error) {
	output, err := system.New{{.JavaName}}Service().Query{{.JavaName}}List(ctx, input)
	if err != nil {
		return nil, err
	}

	return res, nil
}
