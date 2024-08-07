package {{.GoName}}servicelogic

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Add{{.JavaName}}Logic 添加{{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Add{{.JavaName}}Logic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewAdd{{.JavaName}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Add{{.JavaName}}Logic {
	return &Add{{.JavaName}}Logic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Add{{.JavaName}} 添加{{.Comment}}
func (l *Add{{.JavaName}}Logic) Add{{.JavaName}}(in *{{.RpcClient}}.Add{{.JavaName}}Req) (*{{.RpcClient}}.Add{{.JavaName}}Resp, error) {


	//if err != nil {
	//	logc.Errorf(l.ctx, "添加{{.Comment}}失败,参数:%+v,异常:%s", dictItem, err.Error())
	//	return nil, errors.New("添加{{.Comment}}失败")
	//}

	return &{{.RpcClient}}.Add{{.JavaName}}Resp{}, nil
}