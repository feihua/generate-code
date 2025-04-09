package {{.ModuleName}}

import (
	a "{{.ProjectName}}/internal/controller/{{.ModuleName}}"
	"github.com/gin-gonic/gin"
)

// {{.JavaName}}Router {{.Comment}}相关路由
func {{.JavaName}}Router(r *gin.RouterGroup, b *a.{{.JavaName}}Controller) {

	r.POST("/{{.ModuleName}}/{{.LowerJavaName}}/add{{.JavaName}}", b.Create{{.JavaName}})
	r.POST("/{{.ModuleName}}/{{.LowerJavaName}}/delete{{.JavaName}}ByIds", b.Delete{{.JavaName}}ByIds)
	r.POST("/{{.ModuleName}}/{{.LowerJavaName}}/update{{.JavaName}}", b.Update{{.JavaName}})
	r.POST("/{{.ModuleName}}/{{.LowerJavaName}}/update{{.JavaName}}Status", b.Update{{.JavaName}}Status)
	r.POST("/{{.ModuleName}}/{{.LowerJavaName}}/query{{.JavaName}}Detail", b.Query{{.JavaName}}Detail)
	r.POST("/{{.ModuleName}}/{{.LowerJavaName}}/query{{.JavaName}}List", b.Query{{.JavaName}}List)


}
