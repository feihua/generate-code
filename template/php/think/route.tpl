<?php
use think\facade\Route;

Route::group('/api', function () {

{{- range .Tables}}
    // {{.Comment}} 路由
    Route::post('/ModuleName/{{.LowerJavaName}}/add{{.JavaName}}', 'ModuleName/{{.JavaName}}Controller/add{{.JavaName}}');
    Route::post('/ModuleName/{{.LowerJavaName}}/delete{{.JavaName}}', 'ModuleName/{{.JavaName}}Controller/delete{{.JavaName}}');
    Route::post('/ModuleName/{{.LowerJavaName}}/update{{.JavaName}}', 'ModuleName/{{.JavaName}}Controller/update{{.JavaName}}');
    Route::post('/ModuleName/{{.LowerJavaName}}/update{{.JavaName}}Status', 'ModuleName/{{.JavaName}}Controller/update{{.JavaName}}Status');
    Route::post('/ModuleName/{{.LowerJavaName}}/query{{.JavaName}}Detail', 'ModuleName/{{.JavaName}}Controller/query{{.JavaName}}Detail');
    Route::post('/ModuleName/{{.LowerJavaName}}/query{{.JavaName}}List', 'ModuleName/{{.JavaName}}Controller/query{{.JavaName}}List');
    {{end}}


});