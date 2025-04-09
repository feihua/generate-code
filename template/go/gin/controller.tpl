package {{.ModuleName}}

import (
	a "{{.ProjectName}}/internal/dto/{{.ModuleName}}"
	"{{.ProjectName}}/internal/service/{{.ModuleName}}/{{.GoName}}"
	b "{{.ProjectName}}/internal/vo/{{.ModuleName}}/req"
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
func (r {{.JavaName}}Controller) Create{{.JavaName}}(c *gin.Context) {

	req := b.Add{{.JavaName}}ReqVo{}
	err := c.ShouldBindJSON(&req)
	if err != nil {
		result.FailWithMsg(c, result.ParamsError, err.Error())
		return
	}

	item := a.Add{{.JavaName}}Dto{
    {{- range .TableColumn}}
        {{.GoNamePublic}}:req.{{.GoNamePublic}}, //{{.ColumnComment}}
    {{- end}}
	}

	err = r.Service.Create{{.JavaName}}(item)
	if err != nil {
		result.FailWithMsg(c, result.{{.JavaName}}Error, err.Error())
	} else {
		result.Ok(c)
	}
}

// Delete{{.JavaName}}ByIds 删除{{.Comment}}
func (r {{.JavaName}}Controller) Delete{{.JavaName}}ByIds(c *gin.Context) {

	req := b.Delete{{.JavaName}}ReqVo{}
	err := c.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(c, result.ParamsError, err.Error())
		return
	}

	err = r.Service.Delete{{.JavaName}}ByIds(req.Ids)
	if err != nil {
		result.FailWithMsg(c, result.{{.JavaName}}Error, err.Error())
	} else {
		result.Ok(c)
	}
}

// Update{{.JavaName}} 更新{{.Comment}}
func (r {{.JavaName}}Controller) Update{{.JavaName}}(c *gin.Context) {

	req := b.Update{{.JavaName}}ReqVo{}
	err := c.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(c, result.ParamsError, err.Error())
		return
	}

	item := a.Update{{.JavaName}}Dto{
    {{- range .TableColumn}}
        {{.GoNamePublic}}:req.{{.GoNamePublic}}, //{{.ColumnComment}}
    {{- end}}
	}
	err = r.Service.Update{{.JavaName}}(item)
	if err != nil {
		result.FailWithMsg(c, result.{{.JavaName}}Error, err.Error())
	} else {
		result.Ok(c)
	}
}

// Update{{.JavaName}}Status 更新{{.Comment}}状态
func (r {{.JavaName}}Controller) Update{{.JavaName}}Status(c *gin.Context) {

	req := b.Update{{.JavaName}}StatusReqVo{}
	err := c.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(c, result.ParamsError, err.Error())
		return
	}

	item := a.Update{{.JavaName}}StatusDto{
		Ids:       req.Ids,
		Status: req.Status,
	}
	err = r.Service.Update{{.JavaName}}Status(item)
	if err != nil {
		result.FailWithMsg(c, result.{{.JavaName}}Error, err.Error())
	} else {
		result.Ok(c)
	}
}


// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (r {{.JavaName}}Controller) Query{{.JavaName}}Detail(c *gin.Context) {
	req := b.Query{{.JavaName}}DetailReqVo{}
	err := c.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(c, result.ParamsError, err.Error())
		return
	}

	item := a.Query{{.JavaName}}DetailDto{
		Id: req.Id,
	}
	data, err := r.Service.Query{{.JavaName}}Detail(item)
	if err != nil {
		result.FailWithMsg(c, result.{{.JavaName}}Error, err.Error())
	} else {
		result.OkWithData(c, gin.H{"data": data})
	}
}

// Query{{.JavaName}}List 查询{{.Comment}}列表
func (r {{.JavaName}}Controller) Query{{.JavaName}}List(c *gin.Context) {
	req := b.Query{{.JavaName}}ListReqVo{}
	err := c.ShouldBind(&req)
	if err != nil {
		result.FailWithMsg(c, result.ParamsError, err.Error())
		return
	}

	item := a.Query{{.JavaName}}ListDto{
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
	list, total := r.Service.Query{{.JavaName}}List(item)
	result.OkWithData(c, gin.H{"list": list, "success": true, "current": req.PageNo, "total": total, "pageSize": req.PageSize})
}