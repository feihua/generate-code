package {{.GoName}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Query{{.JavaName}}ListLogic 查询{{.Comment}}列表
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Query{{.JavaName}}ListLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewQuery{{.JavaName}}ListLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Query{{.JavaName}}ListLogic {
	return &Query{{.JavaName}}ListLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Query{{.JavaName}}List 查询{{.Comment}}列表
func (l *Query{{.JavaName}}ListLogic) Query{{.JavaName}}List(req *types.Query{{.JavaName}}ListReq) (resp *types.Query{{.JavaName}}ListResp, err error) {
    result, err := l.svcCtx.{{.JavaName}}Service.Query{{.JavaName}}List(l.ctx, &{{.RpcClient}}.Query{{.JavaName}}ListReq{
		PageNum:    req.Current,
		PageSize:   req.PageSize,
        {{- range .TableColumn}}
        {{- if eq .ColumnKey "PRI"}}
        {{- else if isContain .GoNamePublic "Update"}}
        {{- else if isContain .GoNamePublic "Create"}}
        {{- else}}
        {{.GoNamePublic}}: req.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
	})

	if err != nil {
		logc.Errorf(l.ctx, "查询字{{.Comment}}列表失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

    var list []*types.Query{{.JavaName}}ListData

	for _, detail := range result.List {
		list = append(list, &types.Query{{.JavaName}}ListData{
        {{range .TableColumn}}{{.GoNamePublic}}: detail.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{end}}
		})
	}
	return &types.Query{{.JavaName}}ListResp{
		Code:    "000000",
		Message: "查询{{.Comment}}列表成功",
		Current:  req.Current,
        Data:     list,
        PageSize: req.PageSize,
        Success:  true,
        Total:    result.Total,
	}, nil
}
