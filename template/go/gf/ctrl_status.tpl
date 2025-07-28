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

// Update{{.JavaName}} 更新{{.Comment}}状态
func (c *ControllerV1) Update{{.JavaName}}Status(ctx context.Context, req *v1.Update{{.JavaName}}StatusReq) (res *v1.Update{{.JavaName}}Res, err error) {

	res, err = system.New{{.JavaName}}Service().Update{{.JavaName}}Status(ctx, input)
	if err != nil {
		return nil, err
	}

	return res, nil
}
