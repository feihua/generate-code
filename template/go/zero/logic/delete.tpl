package {{.GoName}}

import (
	"context"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Delete{{.JavaName}}Logic 删除{{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Delete{{.JavaName}}Logic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewDelete{{.JavaName}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Delete{{.JavaName}}Logic {
	return &Delete{{.JavaName}}Logic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Delete{{.JavaName}} 删除{{.Comment}}
func (l *Delete{{.JavaName}}Logic) Delete{{.JavaName}}(req *types.Delete{{.JavaName}}Req) (resp *types.Delete{{.JavaName}}Resp, err error) {
	
	//if err != nil {
	//	logc.Errorf(l.ctx, "删除{{.Comment}}失败,参数：%+v,响应：%s", req, err.Error())
	//	s, _ := status.FromError(err)
	//	return nil, errorx.NewDefaultError(s.Message())
	//}

	return &types.Delete{{.JavaName}}Resp{
		Code:    "000000",
		Message: "删除{{.Comment}}成功",
	}, nil
}
