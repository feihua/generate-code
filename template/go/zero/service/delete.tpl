package {{.GoName}}servicelogic

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Delete{{.JavaName}}Logic 删除{{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Delete{{.JavaName}}Logic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewDelete{{.JavaName}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Delete{{.JavaName}}Logic {
	return &Delete{{.JavaName}}Logic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Delete{{.JavaName}} 删除{{.Comment}}
func (l *Delete{{.JavaName}}Logic) Delete{{.JavaName}}(in *{{.RpcClient}}.Delete{{.JavaName}}Req) (*{{.RpcClient}}.Delete{{.JavaName}}Resp, error) {
    q := query.{{.UpperOriginalName}}

	_, err := q.WithContext(l.ctx).Where(q.ID.In(in.Ids...)).Delete()

	if err != nil {
		logc.Errorf(l.ctx, "删除{{.Comment}}失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("删除{{.Comment}}失败")
	}

    logc.Infof(l.ctx, "删除{{.Comment}}成功,参数：%+v", in)
	return &{{.RpcClient}}.Delete{{.JavaName}}Resp{}, nil
}
