<?php

namespace app\service\{{.ModuleName}};

use app\dao\{{.ModuleName}}\{{.JavaName}}Dao;
use app\dto\{{.ModuleName}}\{{.GoName}}\Add{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Delete{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Query{{.JavaName}}DetailDto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Query{{.JavaName}}ListDto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Update{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Update{{.JavaName}}StatusDto;
use app\model\{{.ModuleName}}\{{.JavaName}}Model;
use think\db\exception\DbException;
use Exception;
use think\model\contract\Modelable;

/**
 * {{.Comment}}服务
 */
class {{.JavaName}}Service {
    private {{.JavaName}}Dao ${{.LowerJavaName}}Dao;

    public function __construct ({{.JavaName}}Dao ${{.LowerJavaName}}Dao) {
        $this->{{.LowerJavaName}}Dao = ${{.LowerJavaName}}Dao;
    }

    /**
     * 添加{{.Comment}}
     * @throws Exception
     */
    public function add{{.JavaName}} (Add{{.JavaName}}Dto $dto): bool {
        $dto->validate();
        return $this->{{.LowerJavaName}}Dao->add{{.JavaName}}($dto);
    }


    /**
     * 删除{{.Comment}}
     * @throws Exception
     */
    public function delete{{.JavaName}} (Delete{{.JavaName}}Dto $dto): bool {
        $dto->validate();

        return $this->{{.LowerJavaName}}Dao->delete{{.JavaName}}($dto->ids);
    }

    /**
     * 修改{{.Comment}}
     * @throws Exception
     */
    public function update{{.JavaName}} (Update{{.JavaName}}Dto $dto): bool {
        $dto->validate();

        ${{.GoName}} = $this->{{.LowerJavaName}}Dao->query{{.JavaName}}ById($dto->id);
        if (!${{.GoName}}) {
            throw new Exception('{{.Comment}}不存在');
        }

        return $this->{{.LowerJavaName}}Dao->update{{.JavaName}}($dto);
    }

    /**
     * 修改{{.Comment}}状态
     * @throws Exception
     */
    public function update{{.JavaName}}Status (Update{{.JavaName}}StatusDto $dto): Modelable {
        $dto->validate();

        return $this->{{.LowerJavaName}}Dao->update{{.JavaName}}Status($dto);
    }

    /**
     * 查询{{.Comment}}详情
     * @throws DbException
     * @throws Exception
     */
    public function query{{.JavaName}}Detail (Query{{.JavaName}}DetailDto $dto): array {
        $dto->validate();
        ${{.GoName}} = $this->{{.LowerJavaName}}Dao->query{{.JavaName}}Detail($dto);

        if (!${{.GoName}}) {
            throw new Exception('{{.Comment}}不存在');
        }

        return ${{.GoName}}->toArray();
    }

    /**
     * 查询{{.Comment}}列表
     * @throws DbException
     * @throws Exception
     */
    public function query{{.JavaName}}List (Query{{.JavaName}}ListDto $dto): array {
        $dto->validate();

        return $this->{{.LowerJavaName}}Dao->query{{.JavaName}}List($dto);
    }
}