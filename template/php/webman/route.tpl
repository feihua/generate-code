<?php
use Webman\Route;

Route::group('/api', function () {

{{- range .Tables}}
    // {{.Comment}} 路由
    Route::post('/ModuleName/{{.LowerJavaName}}/add{{.JavaName}}', [\app\controller\ModuleName\{{.JavaName}}Controller::class, 'add{{.JavaName}}']);
    Route::post('/ModuleName/{{.LowerJavaName}}/delete{{.JavaName}}', [\app\controller\ModuleName\{{.JavaName}}Controller::class, 'delete{{.JavaName}}']);
    Route::post('/ModuleName/{{.LowerJavaName}}/update{{.JavaName}}', [\app\controller\ModuleName\{{.JavaName}}Controller::class, 'update{{.JavaName}}']);
    Route::post('/ModuleName/{{.LowerJavaName}}/update{{.JavaName}}Status', [\app\controller\ModuleName\{{.JavaName}}Controller::class, 'update{{.JavaName}}Status']);
    Route::post('/ModuleName/{{.LowerJavaName}}/query{{.JavaName}}Detail', [\app\controller\ModuleName\{{.JavaName}}Controller::class, 'query{{.JavaName}}Detail']);
    Route::post('/ModuleName/{{.LowerJavaName}}/query{{.JavaName}}List', [\app\controller\ModuleName\{{.JavaName}}Controller::class, 'query{{.JavaName}}List']);
    {{end}}


});