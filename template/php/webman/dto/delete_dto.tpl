<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;
use support\exception\BusinessException;


/**
 * 删除{{.Comment}}参数
 */
class Delete{{.JavaName}}Dto extends BaseDto {
    public array $ids;

    public function validate (): void {
        if (empty($this->ids)) {
            throw new BusinessException('id不能为空');
        }
    }
}

