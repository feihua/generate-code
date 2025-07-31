<?php

namespace app\dto\{{.ModuleName}}\{{.GoName}};

use app\dto\BaseDto;
use Exception;


/**
 * 删除{{.Comment}}参数
 */
class Delete{{.JavaName}}Dto extends BaseDto {
    public array $ids;

    /**
     * @throws Exception
     */
    public function validate (): void {
        if (count($this->ids)) {
            throw new Exception('id集合不能为空');
        }
    }
}

