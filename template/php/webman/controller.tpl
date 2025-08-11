<?php

namespace app\controller\{{.ModuleName}};

use app\dto\{{.ModuleName}}\{{.JavaName}}Dto;
use app\result\Result;
use app\service\{{.ModuleName}}\{{.JavaName}}Service;
use Exception;
use support\Log;
use support\Request;
use support\Response;

/**
 * {{.Comment}}控制器
 */
class {{.JavaName}}Controller {
    private {{.JavaName}}Service ${{.LowerJavaName}}Service;

    public function __construct () {
        $this->{{.LowerJavaName}}Service = new {{.JavaName}}Service();
    }


    /**添加{{.Comment}}
     * @param Request $request
     * @return Response
     */
    public function add{{.JavaName}} (Request $request): Response {
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
     * @return Response
     */
    public function delete{{.JavaName}} (Request $request): Response {
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
     * @return Response
     */
    public function update{{.JavaName}} (Request $request): Response {
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
     * @return Response
     */
    public function update{{.JavaName}}Status (Request $request): Response {
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
     * @return Response
     */
    public function query{{.JavaName}}Detail (Request $request): Response {
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
     * @return Response
     */
    public function query{{.JavaName}}List (Request $request): Response {
        try {
           $dto = $request->post();

            $data = $this->{{.LowerJavaName}}Service->query{{.JavaName}}List($dto);
            return Result::Success($data);
        } catch (Exception $e) {
            return Result::ErrorMsg($e->getMessage());
        }
    }

}