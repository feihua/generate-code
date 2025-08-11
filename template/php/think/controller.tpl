<?php

namespace app\controller\{{.ModuleName}};

use app\dto\{{.ModuleName}}\{{.JavaName}}Dto;
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
            $dto = new {{.JavaName}}Dto($request->post());
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
            $ids = $request->post('ids');
            $data = $this->{{.LowerJavaName}}Service->delete{{.JavaName}}($ids);
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
            $dto = new {{.JavaName}}Dto($request->post());
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
            $ids = $request->post('ids');
            $status = $request->post('status');
            $data = $this->{{.LowerJavaName}}Service->update{{.JavaName}}Status($ids, $status);
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
            $id = $request->post('id');

            $data = $this->{{.LowerJavaName}}Service->query{{.JavaName}}Detail($id);
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
            $dto = $request->post();

            $data = $this->{{.LowerJavaName}}Service->query{{.JavaName}}List($dto);
            return Result::Success($data);
        } catch (Exception $e) {
            return Result::ErrorMsg($e->getMessage());
        }
    }

}