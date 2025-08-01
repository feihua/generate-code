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

 // Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (c *ControllerV1) Query{{.JavaName}}Detail(ctx context.Context, req *v1.Query{{.JavaName}}DetailReq) (res *v1.Query{{.JavaName}}DetailRes, err error) {
	res, err = system.New{{.JavaName}}Service().Query{{.JavaName}}Detail(ctx, req)
	if err != nil {
		return nil, err
	}

	return res, nil
}
