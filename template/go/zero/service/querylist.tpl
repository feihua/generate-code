package {{.GoName}}servicelogic

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Query{{.JavaName}}ListLogic 查询{{.Comment}}列表
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Query{{.JavaName}}ListLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewQuery{{.JavaName}}ListLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Query{{.JavaName}}ListLogic {
	return &Query{{.JavaName}}ListLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Query{{.JavaName}}List 查询{{.Comment}}列表
func (l *Query{{.JavaName}}ListLogic) Query{{.JavaName}}List(in *{{.RpcClient}}.Query{{.JavaName}}ListReq) (*{{.RpcClient}}.Query{{.JavaName}}ListResp, error) {


	//if err != nil {
	//	logc.Errorf(l.ctx, "查询{{.Comment}}列表失败,参数:%+v,异常:%s", dictItem, err.Error())
	//	return nil, errors.New("查询{{.Comment}}列表失败")
	//}

	return &{{.RpcClient}}.Query{{.JavaName}}ListResp{}, nil
}
