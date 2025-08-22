//
// Created by {{.Author}} on {{.CreateTime}}
//

#pragma once

#include <crow.h>
#include "service/{{.ModuleName}}/{{.GoName}}/{{.GoName}}_service.h"
#include "config/log_config.h"
#include "utils/response_util.hpp"

/**
* {{.Comment}}控制器
*/
class {{.JavaName}}Controller {
private:
    {{.JavaName}}Service {{.LowerJavaName}}Service;

public:

    void registerRoutes(crow::SimpleApp &app);
};
