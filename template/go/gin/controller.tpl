package {{.ModuleName}}

import (
	d "{{.ProjectName}}/internal/dto/{{.ModuleName}}"
	"{{.ProjectName}}/internal/service/{{.ModuleName}}/{{.GoName}}"
	rq "{{.ProjectName}}/internal/vo/{{.ModuleName}}/req"
	"{{.ProjectName}}/pkg/result"
	"github.com/gin-gonic/gin"
)

// {{.JavaName}}Controller {{.Comment}}相关
type {{.JavaName}}Controller struct {
	Service {{.GoName}}.{{.JavaName}}Service
}

func New{{.JavaName}}Controller(Service {{.GoName}}.{{.JavaName}}Service) *{{.JavaName}}Controller {
	return &{{.JavaName}}Controller{Service: Service}
}

// Create{{.JavaName}} 添加{{.Comment}}
func (c {{.JavaName}}Controller) Create{{.JavaName}}(ctx *gin.Context) {

	req := rq.Add{{.JavaName}}ReqVo{}
	err := ctx.ShouldBindJSON(&req)
	if err != nil {
		result.FailWithMsg(ctx, result.ParamsError, err.Error())
		return
	}

	item := d.Add{{.JavaName}}Dto{
    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "CreateBy"}}
        {{.GoNamePublic}}:ctx.MustGet("userName").(string), //{{.ColumnComment}}
    {{- else if isContain .GoNamePublic "CreateTime"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else }}
        {{.GoNamePublic}}:req.{{.GoNamePublic}}, //{{.ColumnComment}}
    {{- end}}
    {{- end}}

	}

	err = c.Service.Create{{.JavaName}}(item)
	if err != nil {
		result.FailWithMsg(ctx, result.{{.JavaName}}Error, err.Error())
	} else {
		result.Ok(ctx)
	}
}

// Delete{{.JavaName}}ByIds 删除{{.Comment}}
func (c {{.JavaName}}Controller) Delete{{.JavaName}}ByIds(ctx *gin.Context) {

	req := rq.Delete{{.JavaName}}ReqVo{}
	err := ctx.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(ctx, result.ParamsError, err.Error())
		return
	}

	err = c.Service.Delete{{.JavaName}}ByIds(req.Ids)
	if err != nil {
		result.FailWithMsg(ctx, result.{{.JavaName}}Error, err.Error())
	} else {
		result.Ok(ctx)
	}
}

// Update{{.JavaName}} 更新{{.Comment}}
func (c {{.JavaName}}Controller) Update{{.JavaName}}(ctx *gin.Context) {

	req := rq.Update{{.JavaName}}ReqVo{}
	err := ctx.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(ctx, result.ParamsError, err.Error())
		return
	}

	item := d.Update{{.JavaName}}Dto{
    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "UpdateBy"}}
        {{.GoNamePublic}}:ctx.MustGet("userName").(string), //{{.ColumnComment}}
    {{- else if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "UpdateTime"}}
    {{- else }}
        {{.GoNamePublic}}:req.{{.GoNamePublic}}, //{{.ColumnComment}}
    {{- end}}
    {{- end}}
	}
	err = c.Service.Update{{.JavaName}}(item)
	if err != nil {
		result.FailWithMsg(ctx, result.{{.JavaName}}Error, err.Error())
	} else {
		result.Ok(ctx)
	}
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (c {{.JavaName}}Controller) Update{{.JavaName}}Status(ctx *gin.Context) {

	req := rq.Update{{.JavaName}}StatusReqVo{}
	err := ctx.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(ctx, result.ParamsError, err.Error())
		return
	}

	item := d.Update{{.JavaName}}StatusDto{
		Ids:       req.Ids,
		Status: req.Status,
		UpdateBy:  ctx.MustGet("userName").(string),
	}
	err = c.Service.Update{{.JavaName}}Status(item)
	if err != nil {
		result.FailWithMsg(ctx, result.{{.JavaName}}Error, err.Error())
	} else {
		result.Ok(ctx)
	}
}


// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (c {{.JavaName}}Controller) Query{{.JavaName}}Detail(ctx *gin.Context) {
	req := rq.Query{{.JavaName}}DetailReqVo{}
	err := ctx.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(ctx, result.ParamsError, err.Error())
		return
	}

	item := d.Query{{.JavaName}}DetailDto{
		Id: req.Id,
	}
	data, err := c.Service.Query{{.JavaName}}Detail(item)
	if err != nil {
		result.FailWithMsg(ctx, result.{{.JavaName}}Error, err.Error())
	} else {
		result.OkWithData(ctx, data)
	}
}

// Query{{.JavaName}}List 查询{{.Comment}}列表
func (c {{.JavaName}}Controller) Query{{.JavaName}}List(ctx *gin.Context) {
	req := rq.Query{{.JavaName}}ListReqVo{}
	err := ctx.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(ctx, result.ParamsError, err.Error())
		return
	}

	item := d.Query{{.JavaName}}ListDto{
		PageNo:   req.PageNo,
		PageSize: req.PageSize,
        {{- range .TableColumn}}
        {{- if isContain .GoNamePublic "Create"}}
        {{- else if isContain .GoNamePublic "Update"}}
        {{- else if eq .ColumnKey "PRI"}}
        {{- else if isContain .JavaName "remark"}}
        {{- else if isContain .JavaName "sort"}}
        {{- else if isContain .JavaName "Sort"}}
        {{- else if eq .GoType "time.Time"}}
        {{- else }}
        {{.GoNamePublic}}:req.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
	}
	list, total, err := c.Service.Query{{.JavaName}}List(item)
    if err != nil {
        result.FailWithMsg(c, result.{{.JavaName}}Error, err.Error())
    } else {
        result.OkWithData(c, gin.H{"list": list, "success": true, "current": req.PageNo, "total": total, "pageSize": req.PageSize})
    }
}