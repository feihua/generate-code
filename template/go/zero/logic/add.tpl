package {{.GoName}}

import (
	"context"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Add{{.JavaName}}Logic 添加{{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Add{{.JavaName}}Logic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewAdd{{.JavaName}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Add{{.JavaName}}Logic {
	return &Add{{.JavaName}}Logic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Add{{.JavaName}} 添加{{.Comment}}
func (l *Add{{.JavaName}}Logic) Add{{.JavaName}}(req *types.Add{{.JavaName}}Req) (resp *types.Add{{.JavaName}}Resp, err error) {
	
	//if err != nil {
	//	logc.Errorf(l.ctx, "添加{{.Comment}}失败,参数：%+v,响应：%s", req, err.Error())
	//	s, _ := status.FromError(err)
	//	return nil, errorx.NewDefaultError(s.Message())
	//}

	return &types.Add{{.JavaName}}Resp{
		Code:    "000000",
		Message: "添加{{.Comment}}成功",
	}, nil
}
