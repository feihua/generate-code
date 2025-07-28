package {{.ModuleName}}

/*
 添加{{.Comment}}
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"context"
	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
	"{{.ProjectName}}/internal/service/{{.ModuleName}}"
)

// Add{{.JavaName}} 添加{{.Comment}}
func (c *ControllerV1) Add{{.JavaName}}(ctx context.Context, req *v1.Add{{.JavaName}}Req) (res *v1.Add{{.JavaName}}Res, err error) {
	res, err = system.New{{.JavaName}}Service().Add{{.JavaName}}(ctx, req)
	if err != nil {
		return nil, err
	}

	return res, nil
}
