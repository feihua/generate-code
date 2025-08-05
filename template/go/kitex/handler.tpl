package main

import (
	"context"
	"{{.ProjectName}}/kitex_gen/rpc/base"
	{{.ModuleName}} "{{.ProjectName}}/kitex_gen/rpc/{{.ModuleName}}"
	"{{.ProjectName}}/pkg/utils"
	"{{.ProjectName}}/rpc/{{.ModuleName}}/ent"
	"{{.ProjectName}}/rpc/{{.ModuleName}}/ent/{{.OriginalName1}}"
	"time"
)

// {{.UpperOriginalName}}Impl {{.Comment}}
type {{.UpperOriginalName}}Impl struct {
	client *ent.Client
}

func New{{.UpperOriginalName}}Impl(client *ent.Client) *{{.UpperOriginalName}}Impl {
	return &{{.UpperOriginalName}}Impl{
		client: client,
	}
}

// Add{{.JavaName}} 添加{{.Comment}}
func (s *{{.UpperOriginalName}}Impl) Add{{.JavaName}}(ctx context.Context, request *{{.ModuleName}}.Add{{.JavaName}}Req) (resp *{{.ModuleName}}.{{.JavaName}}Resp, err error) {

	_, err = s.client.{{.UpperOriginalName}}.Create().
    {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "Create"}}
        {{- else if isContain .GoNamePublic "Update"}}
        {{- else if eq .ColumnKey "PRI"}}
        {{- else}}
        Set{{.GoNamePublic}}(request.{{.GoNamePublic}}). //{{.ColumnComment}}
        {{- end}}
        {{- end}}
		SetCreateBy("request.CreateBy"). //创建者
		Save(ctx)

	resp = new({{.ModuleName}}.{{.JavaName}}Resp)
	resp.BaseResp = &base.BaseResp{
		Code: "200",
		Msg:  "success",
	}
	return
}

// Delete{{.JavaName}} 删除{{.Comment}}
func (s *{{.UpperOriginalName}}Impl) Delete{{.JavaName}}(ctx context.Context, request *{{.ModuleName}}.Delete{{.JavaName}}Req) (resp *{{.ModuleName}}.{{.JavaName}}Resp, err error) {
	_, err = s.client.{{.UpperOriginalName}}.Delete().Where({{.OriginalName1}}.IDIn(request.Ids...)).Exec(ctx)
	if err != nil {
		return nil, err
	}
	return
}

// Update{{.JavaName}} 更新{{.Comment}}
func (s *{{.UpperOriginalName}}Impl) Update{{.JavaName}}(ctx context.Context, request *{{.ModuleName}}.Update{{.JavaName}}Req) (resp *{{.ModuleName}}.{{.JavaName}}Resp, err error) {
	_, err = s.client.{{.UpperOriginalName}}.UpdateOneID(request.Id).
        {{- range .TableColumn}}
            {{- if isContain .GoNamePublic "Create"}}
            {{- else if isContain .GoNamePublic "Update"}}
            {{- else if eq .ColumnKey "PRI"}}
            {{- else}}
            Set{{.GoNamePublic}}(request.{{.GoNamePublic}}). //{{.ColumnComment}}
            {{- end}}
            {{- end}}
		SetUpdateBy("request.SetUpdateBy"). //更新者
		SetUpdateTime(time.Now()).
		Save(ctx)

	if err != nil {
		if ent.IsNotFound(err) {
			return nil, errors.New("{{.Comment}}不存在")
		}
		return nil, err
	}

	resp = new({{.ModuleName}}.{{.JavaName}}Resp)
	resp.BaseResp = &base.BaseResp{
		Code: "200",
		Msg:  "success",
	}
	return
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (s *{{.UpperOriginalName}}Impl) Update{{.JavaName}}Status(ctx context.Context, request *{{.ModuleName}}.Update{{.JavaName}}StatusReq) (resp *{{.ModuleName}}.{{.JavaName}}Resp, err error) {

	for _, id := range request.Ids {
		_, err = s.client.{{.UpperOriginalName}}.UpdateOneID(id).
			SetStatus(request.Status).
			SetUpdateBy("request.SetUpdateBy").
			SetUpdateTime(time.Now()).
			Save(ctx)
	}
	resp = new({{.ModuleName}}.{{.JavaName}}Resp)
	resp.BaseResp = &base.BaseResp{
		Code: "200",
		Msg:  "success",
	}
	return
}

// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (s *{{.UpperOriginalName}}Impl) Query{{.JavaName}}Detail(ctx context.Context, request *{{.ModuleName}}.Query{{.JavaName}}DetailReq) (resp *{{.ModuleName}}.Query{{.JavaName}}DetailResp, err error) {
	item, err := s.client.{{.UpperOriginalName}}.Query().Where({{.OriginalName1}}.ID(request.Id)).Only(ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			return nil, errors.New("{{.Comment}}不存在")
		}
		return nil, err
	}

	resp = new({{.ModuleName}}.Query{{.JavaName}}DetailResp)

	resp.Data = &{{.ModuleName}}.{{.JavaName}}Item{
              {{- range .TableColumn}}
              {{.GoNamePublic}}: {{- if isContain .GoNamePublic "CreateTime"}}utils.TimeToStr(item.CreateTime), //{{.ColumnComment}}
              {{- else if isContain .GoNamePublic "UpdateTime"}}utils.TimeToString(item.UpdateTime), //{{.ColumnComment}}
              {{- else}}item.{{Replace .GoNamePublic "Id" "ID"}}, //{{.ColumnComment}}
              {{- end}}
              {{- end}}
	}
	resp.BaseResp = &base.BaseResp{
		Code: "200",
		Msg:  "success",
	}
	return
}

// Query{{.JavaName}}List 查询{{.Comment}}列表
func (s *{{.UpperOriginalName}}Impl) Query{{.JavaName}}List(ctx context.Context, request *{{.ModuleName}}.Query{{.JavaName}}ListReq) (resp *{{.ModuleName}}.Query{{.JavaName}}ListResp, err error) {
	resp = new({{.ModuleName}}.Query{{.JavaName}}ListResp)

	query := s.client.{{.UpperOriginalName}}.Query()

    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
    {{- else if eq .GoType "string"}}
    if len(request.{{.GoNamePublic}}) > 0 {
        query = query.Where({{$.OriginalName1}}.{{.GoNamePublic}}Contains(request.{{.GoNamePublic}})) //{{.ColumnComment}}
    }
    {{- else}}
    if request.{{.GoNamePublic}} != 2 {
        query = query.Where({{$.OriginalName1}}.{{.GoNamePublic}}(request.{{.GoNamePublic}})) //{{.ColumnComment}}
    }
    {{- end}}
    {{- end}}

	if request.PageNum > 0 && request.PageSize > 0 {
		offset := (request.PageNum - 1) * request.PageSize
		query = query.Offset(int(offset)).Limit(int(request.PageSize))
	}

	list, err := query.Order(ent.Desc({{.OriginalName1}}.FieldCreateTime)).All(ctx)
	if err != nil {
		return nil, err
	}
	for _, item := range list {
		data:= &{{.ModuleName}}.{{.JavaName}}Item{
              {{- range .TableColumn}}
              {{.GoNamePublic}}: {{- if isContain .GoNamePublic "CreateTime"}}utils.TimeToStr(item.CreateTime), //{{.ColumnComment}}
              {{- else if isContain .GoNamePublic "UpdateTime"}}utils.TimeToString(item.UpdateTime), //{{.ColumnComment}}
              {{- else}}item.{{Replace .GoNamePublic "Id" "ID"}}, //{{.ColumnComment}}
              {{- end}}
              {{- end}}
        }

        resp.List = append(resp.List, data)
	}

	resp.Total = 10
	resp.BaseResp = &base.BaseResp{
		Code: "200",
		Msg:  "success",
	}
	return
}
