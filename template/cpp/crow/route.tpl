
{{- range .Tables}}
#include "controllers/{{$.ModuleName}}/{{.GoName}}_controller.cpp"
{{- end}}


});

{{- range .Tables}}
    // {{.Comment}} 路由
     {{.JavaName}}Controller {{.LowerJavaName}}Controller;
     {{.LowerJavaName}}Controller.registerRoutes(app);
    {{- end}}


});