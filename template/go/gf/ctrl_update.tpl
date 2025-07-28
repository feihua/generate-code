package {{.ModuleName}}

/*
更新{{.Comment}}
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"context"
	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
	"{{.ProjectName}}/internal/service/{{.ModuleName}}"
)

// Update{{.JavaName}} 更新{{.Comment}}
func (c *ControllerV1) Update{{.JavaName}}(ctx context.Context, req *v1.Update{{.JavaName}}Req) (res *v1.Update{{.JavaName}}Res, err error) {
	_, err = system.New{{.JavaName}}Service().Update{{.JavaName}}(ctx, req)
	if err != nil {
		return nil, err
	}

	return res, nil
}
