<?php

namespace app\service\{{.ModuleName}};

use app\dao\{{.ModuleName}}\{{.JavaName}}Dao;
use app\dto\{{.ModuleName}}\{{.GoName}}\Add{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Delete{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Query{{.JavaName}}DetailDto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Query{{.JavaName}}ListDto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Update{{.JavaName}}Dto;
use app\dto\{{.ModuleName}}\{{.GoName}}\Update{{.JavaName}}StatusDto;
use app\model\{{.JavaName}};
use support\exception\BusinessException;
use support\Log;
use think\model\contract\Modelable;

/**
 * {{.Comment}}服务
 */
class {{.JavaName}}Service {
    private {{.JavaName}}Dao ${{.LowerJavaName}}Dao;

    public function __construct () {
        $this->{{.LowerJavaName}}Dao = new {{.JavaName}}Dao();
    }

    /**
     * 添加{{.Comment}}
     */
    public function add{{.JavaName}} (Add{{.JavaName}}Dto $dto): Modelable {
        $dto->validate();
        return $this->{{.LowerJavaName}}Dao->add{{.JavaName}}($dto);
    }


    /**
     * 删除{{.Comment}}
     */
    public function delete{{.JavaName}} (Delete{{.JavaName}}Dto $dto): int {
        $dto->validate();

        return $this->{{.LowerJavaName}}Dao->delete{{.JavaName}}($dto->ids);
    }

    /**
     * 修改{{.Comment}}
     */
    public function update{{.JavaName}} (Update{{.JavaName}}Dto $dto): int {
        $dto->validate();

        ${{.GoName}} = $this->{{.LowerJavaName}}Dao->query{{.JavaName}}ById($dto->id);
        if (!${{.GoName}}) {
            throw new BusinessException('{{.Comment}}不存在');
        }

        return $this->{{.LowerJavaName}}Dao->update{{.JavaName}}($dto);
    }

    /**
     * 修改{{.Comment}}状态
     */
    public function update{{.JavaName}}Status (Update{{.JavaName}}StatusDto $dto): Modelable {
        $dto->validate();

        return $this->{{.LowerJavaName}}Dao->update{{.JavaName}}Status($dto);
    }

    /**
     * 查询{{.Comment}}详情
     */
    public function query{{.JavaName}}Detail (Query{{.JavaName}}DetailDto $dto): array {
        $dto->validate();
        Log::info('log test');
        ${{.GoName}} = $this->{{.LowerJavaName}}Dao->query{{.JavaName}}Detail($dto);

        if (!${{.GoName}}) {
            throw new BusinessException('{{.Comment}}不存在');
        }

        return ${{.GoName}}->toArray();
    }

    /**
     * 查询{{.Comment}}列表
     */
    public function query{{.JavaName}}List (Query{{.JavaName}}ListDto $dto): array {
        $dto->validate();

        return $this->{{.LowerJavaName}}Dao->query{{.JavaName}}List($dto);
    }
}