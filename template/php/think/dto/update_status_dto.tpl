<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;
use Exception;

/**
 * 更新{{.Comment}}状态参数
 */
class Update{{.JavaName}}StatusDto extends BaseDto {
    public array $ids;
    public int $status;

    /**
     * @throws Exception
     */
    public function validate (): void {
        if (empty($this->ids)) {
            throw new Exception('id集合不能为空');
        }
        if (empty($this->status)) {
            throw new Exception('status不能为空');
        }
    }
}

