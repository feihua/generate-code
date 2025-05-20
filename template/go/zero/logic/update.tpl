package {{.GoName}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{.JavaName}}Logic 更新{{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Update{{.JavaName}}Logic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewUpdate{{.JavaName}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{.JavaName}}Logic {
	return &Update{{.JavaName}}Logic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Update{{.JavaName}} 更新{{.Comment}}
func (l *Update{{.JavaName}}Logic) Update{{.JavaName}}(req *types.Update{{.JavaName}}Req) (resp *types.Update{{.JavaName}}Resp, err error) {

    _, err = l.svcCtx.{{.JavaName}}Service.Update{{.JavaName}}(l.ctx, &{{.RpcClient}}.Update{{.JavaName}}Req{
        {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "UpdateTime"}}
        {{- else if isContain .GoNamePublic "Create"}}
        {{- else if eq .GoNamePublic "UpdateBy"}}
        UpdateBy: l.ctx.Value("userName").(string), //{{.ColumnComment}}
        {{- else}}
        {{.GoNamePublic}}: req.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
    })

	if err != nil {
	    logc.Errorf(l.ctx, "更新{{.Comment}}失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

	return &types.Update{{.JavaName}}Resp{
		Code:    "000000",
		Message: "更新{{.Comment}}成功",
	}, nil
}
