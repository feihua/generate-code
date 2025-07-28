package {{.ModuleName}}

/*
删除{{.Comment}}
Author: {{.Author}}
Date: {{.CreateTime}}
*/

import (
	"context"
	"{{.ProjectName}}/api/{{.ModuleName}}/v1"
	"{{.ProjectName}}/internal/service/{{.ModuleName}}"
)

// Delete{{.JavaName}} 删除{{.Comment}}
func (c *ControllerV1) Delete{{.JavaName}}(ctx context.Context, req *v1.Delete{{.JavaName}}Req) (res *v1.Delete{{.JavaName}}Res, err error) {
	res, err = system.New{{.JavaName}}Service().Delete{{.JavaName}}(ctx, req)
	if err != nil {
		return nil, err
	}

	return res, nil
}
