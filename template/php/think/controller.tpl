<?php

namespace app\controller\{{.ModuleName}};

use app\dto\{{.ModuleName}}\{{.GoName}}\Add{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Delete{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Query{{.JavaName}}DetailDto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Query{{.JavaName}}ListDto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Update{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Update{{.JavaName}}StatusDto;
use app\result\Result;
use app\service\{{.ModuleName}}\{{.JavaName}}Service;
use Exception;

use app\BaseController;
use think\Request;
use think\response\Json;

/**
 * {{.Comment}}控制器
 */
class {{.JavaName}}Controller extends BaseController {
    private {{.JavaName}}Service ${{.LowerJavaName}}Service;

    public function initialize(): void {
        parent::initialize();
         $this->{{.LowerJavaName}}Service = app({{.JavaName}}Service::class);
    }

    /**添加{{.Comment}}
     * @param Request $request
     * @return Json
     */
    public function add{{.JavaName}} (Request $request): Json {
        try {
            $dto = new Add{{.JavaName}}Dto($request->post());
            $data = $this->{{.LowerJavaName}}Service->add{{.JavaName}}($dto);
            return Result::Success($data);
        } catch (Exception $e) {
            return Result::ErrorMsg($e->getMessage());
        }
    }

    /**删除{{.Comment}}
     * @param Request $request
     * @return Json
     */
    public function delete{{.JavaName}} (Request $request): Json {
        try {
            $dto = new Delete{{.JavaName}}Dto($request->post());
            $data = $this->{{.LowerJavaName}}Service->delete{{.JavaName}}($dto);
            return Result::Success($data);
        } catch (Exception $e) {
            return Result::ErrorMsg($e->getMessage());
        }
    }

    /**更新{{.Comment}}
     * @param Request $request
     * @return Json
     */
    public function update{{.JavaName}} (Request $request): Json {
        try {
            $dto = new Update{{.JavaName}}Dto($request->post());
            $data = $this->{{.LowerJavaName}}Service->update{{.JavaName}}($dto);
            return Result::Success($data);
        } catch (Exception $e) {
            return Result::ErrorMsg($e->getMessage());
        }
    }

    /**更新{{.Comment}}状态
     * @param Request $request
     * @return Json
     */
    public function update{{.JavaName}}Status (Request $request): Json {
        try {
            $dto = new Update{{.JavaName}}StatusDto($request->post());
            $data = $this->{{.LowerJavaName}}Service->update{{.JavaName}}Status($dto);
            return Result::Success($data);
        } catch (Exception $e) {
            return Result::ErrorMsg($e->getMessage());
        }
    }

    /**查询{{.Comment}}详情
     * @param Request $request
     * @return Json
     */
    public function query{{.JavaName}}Detail (Request $request): Json {
        try {
            $dto = new Query{{.JavaName}}DetailDto($request->post());

            $data = $this->{{.LowerJavaName}}Service->query{{.JavaName}}Detail($dto);
            return Result::Success($data);
        } catch (Exception $e) {
            return Result::ErrorMsg($e->getMessage());
        }
    }

    /**查询{{.Comment}}列表
     * @param Request $request
     * @return Json
     */
    public function query{{.JavaName}}List (Request $request): Json {
        try {
            $dto = new Query{{.JavaName}}ListDto($request->post());

            $data = $this->{{.LowerJavaName}}Service->query{{.JavaName}}List($dto);
            return Result::Success($data);
        } catch (Exception $e) {
            return Result::ErrorMsg($e->getMessage());
        }
    }

}