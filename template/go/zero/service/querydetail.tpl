package {{.GoName}}service

import (
	"context"
	"errors"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
	"gorm.io/gorm"
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

    switch {
    case errors.Is(err, gorm.ErrRecordNotFound):
        logc.Errorf(l.ctx, "{{.Comment}}不存在, 请求参数：%+v, 异常信息: %s", in, err.Error())
        return nil, errors.New("{{.Comment}}不存在")
    case err != nil:
        logc.Errorf(l.ctx, "查询{{.Comment}}异常, 请求参数：%+v, 异常信息: %s", in, err.Error())
        return nil, errors.New("查询{{.Comment}}异常")
    }

	data := &{{.RpcClient}}.Query{{.JavaName}}DetailResp{
	{{- range .TableColumn}}
	    {{.GoNamePublic}}: item.{{- if isContain .GoNamePublic "Time"}}{{.GoNamePublic}}.Format("2006-01-02 15:04:05"), //{{.ColumnComment}}{{- else}}{{Replace .GoNamePublic "Id" "ID"}}, //{{.ColumnComment}}{{- end}}
    {{- end}}
	}

	return data, nil
}
