package {{.GoName}}servicelogic

import (
	"context"
	"errors"
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
    {{- $lowerJavaName :=.LowerJavaName}}
    {{$lowerJavaName}} := query.{{.UpperOriginalName}}
    q := {{$lowerJavaName}}.WithContext(l.ctx)

	{{- range .TableColumn}}
	{{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
	{{- else if eq .GoType "string"}}
	if len(in.{{.GoNamePublic}}) > 0 {
        q = q.Where({{$lowerJavaName}}.{{.GoNamePublic}}.Like("%" + in.{{.GoNamePublic}} + "%"))
    }
    {{- else}}
	if in.{{.GoNamePublic}} != 2 {
        q = q.Where({{$lowerJavaName}}.{{.GoNamePublic}}.Eq(in.{{.GoNamePublic}}))
    }
	{{- end}}
	{{- end}}

	result, count, err := q.FindByPage(int((in.PageNum-1)*in.PageSize), int(in.PageSize))

	if err != nil {
		logc.Errorf(l.ctx, "查询{{.Comment}}列表失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("查询{{.Comment}}列表失败")
	}

	var list []*{{.RpcClient}}.{{.JavaName}}ListData

	for _, item := range result {
		list = append(list, &{{.RpcClient}}.{{.JavaName}}ListData{
			{{- range .TableColumn}}
            {{.GoNamePublic}}: item.{{- if isContain .GoNamePublic "Time"}}{{.GoNamePublic}}.Format("2006-01-02 15:04:05"), //{{.ColumnComment}}{{- else}}{{Replace .GoNamePublic "Id" "ID"}}, //{{.ColumnComment}}{{- end}}
            {{- end}}

		})
	}


	return &{{.RpcClient}}.Query{{.JavaName}}ListResp{
	    Total: count,
    	List:  list,
	}, nil
}
