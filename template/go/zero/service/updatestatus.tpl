package {{.GoName}}servicelogic

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{.JavaName}}StatusLogic 更新{{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Update{{.JavaName}}StatusLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewUpdate{{.JavaName}}StatusLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{.JavaName}}StatusLogic {
	return &Update{{.JavaName}}StatusLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (l *Update{{.JavaName}}StatusLogic) Update{{.JavaName}}Status(in *{{.RpcClient}}.Update{{.JavaName}}StatusReq) (*{{.RpcClient}}.Update{{.JavaName}}StatusResp, error) {

    q := query.{{.UpperOriginalName}}

	_, err := q.WithContext(l.ctx).Where(q.ID.In(in.Ids...)).Update(q.Status, in.Status)

	if err != nil {
		logc.Errorf(l.ctx, "更新{{.Comment}}状态失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("更新{{.Comment}}状态失败")
	}

	return &{{.RpcClient}}.Update{{.JavaName}}StatusResp{}, nil
}
