<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;
use support\exception\BusinessException;

/**
 * 更新{{.Comment}}状态参数
 */
class Update{{.JavaName}}StatusDto extends BaseDto {
    public array $ids;
    public int $status;

    public function validate (): void {
        if (empty($this->ids)) {
            throw new BusinessException('id不能为空');
        }
        if (empty($this->status)) {
            throw new BusinessException('status不能为空');
        }
    }
}

