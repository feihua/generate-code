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

	item, err := query.{{.UpperOriginalName}}.WithContext(l.ctx).Where(query.{{.UpperOriginalName}}.ID.Eq(in.Id)).First()

	if err != nil {
		logc.Errorf(l.ctx, "查询{{.Comment}}详情失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("查询{{.Comment}}详情失败")
	}

	data := &{{.RpcClient}}.Query{{.JavaName}}DetailResp{
	{{- range .TableColumn}}
	    {{.GoNamePublic}}: item.{{- if isContain .GoNamePublic "Time"}}{{.GoNamePublic}}.Format("2006-01-02 15:04:05"), //{{.ColumnComment}}{{- else}}{{Replace .GoNamePublic "Id" "ID"}}, //{{.ColumnComment}}{{- end}}
    {{- end}}
	}

	if err != nil {
		logc.Errorf(l.ctx, "查询{{.Comment}}详情失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("查询{{.Comment}}详情失败")
	}

	return data, nil
}
