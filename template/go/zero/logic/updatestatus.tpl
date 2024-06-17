package {{.GoName}}

import (
	"context"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/feihua/zero-admin/api/admin/internal/svc"
	"github.com/feihua/zero-admin/api/admin/internal/types"

	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{.JavaName}}StatusLogic 更新{{.Comment}}状态状态
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Update{{.JavaName}}StatusLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewUpdate{{.JavaName}}StatusLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{.JavaName}}StatusLogic {
	return &Update{{.JavaName}}StatusLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (l *Update{{.JavaName}}StatusLogic) Update{{.JavaName}}Status(req *types.Update{{.JavaName}}StatusReq) (resp *types.Update{{.JavaName}}StatusResp, err error) {

	//if err != nil {
	//	logc.Errorf(l.ctx, "更新{{.Comment}}状态失败,参数：%+v,响应：%s", req, err.Error())
	//	s, _ := status.FromError(err)
	//	return nil, errorx.NewDefaultError(s.Message())
	//}

	return &types.Update{{.JavaName}}StatusResp{
		Code:    "000000",
		Message: "更新{{.Comment}}状态成功",
	}, nil
}
