
{{- range .Tables}}
#include "controller/{{$.ModuleName}}/{{.GoName}}/{{.GoName}}_controller.h"
{{- end}}


});

{{- range .Tables}}
    // {{.Comment}} 路由
     {{.JavaName}}Controller {{.LowerJavaName}}Controller{};
     {{.LowerJavaName}}Controller.registerRoutes(app);
    {{- end}}


});