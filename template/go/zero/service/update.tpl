package {{.GoName}}servicelogic

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{.JavaName}}Logic 更新{{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Update{{.JavaName}}Logic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewUpdate{{.JavaName}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{.JavaName}}Logic {
	return &Update{{.JavaName}}Logic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Update{{.JavaName}} 更新{{.Comment}}
func (l *Update{{.JavaName}}Logic) Update{{.JavaName}}(in *{{.RpcClient}}.Update{{.JavaName}}Req) (*{{.RpcClient}}.Update{{.JavaName}}Resp, error) {


	//if err != nil {
	//	logc.Errorf(l.ctx, "更新{{.Comment}}失败,参数:%+v,异常:%s", dictItem, err.Error())
	//	return nil, errors.New("更新{{.Comment}}失败")
	//}

	return &{{.RpcClient}}.Update{{.JavaName}}Resp{}, nil
}
