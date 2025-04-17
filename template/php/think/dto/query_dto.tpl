<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;
use think\Exception;

/**
 * 查询{{.Comment}}详情参数
 */
class Query{{.JavaName}}DetailDto extends BaseDto {
    public int $id;

    public function validate (): void {
        if (empty($this->id)) {
            throw new Exception('id不能为空');
        }

    }
}

