package {{.GoName}}servicelogic

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Query{{.JavaName}}DetailLogic 查询{{.Comment}}详情
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Query{{.JavaName}}DetailLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewQuery{{.JavaName}}DetailLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Query{{.JavaName}}DetailLogic {
	return &Query{{.JavaName}}DetailLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (l *Query{{.JavaName}}DetailLogic) Query{{.JavaName}}Detail(in *{{.RpcClient}}.Query{{.JavaName}}DetailReq) (*{{.RpcClient}}.Query{{.JavaName}}DetailResp, error) {


	//if err != nil {
	//	logc.Errorf(l.ctx, "查询{{.Comment}}详情失败,参数:%+v,异常:%s", dictItem, err.Error())
	//	return nil, errors.New("查询{{.Comment}}详情失败")
	//}

	return &{{.RpcClient}}.Query{{.JavaName}}DetailResp{}, nil
}
