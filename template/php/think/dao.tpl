<?php

namespace app\dao\{{.ModuleName}};

use app\dto\system\{{.GoName}}\Add{{.JavaName}}Dto;
use app\dto\system\{{.GoName}}\Query{{.JavaName}}DetailDto;
use app\dto\system\{{.GoName}}\Query{{.JavaName}}ListDto;
use app\dto\system\{{.GoName}}\Update{{.JavaName}}Dto;
use app\dto\system\{{.GoName}}\Update{{.JavaName}}StatusDto;
use app\model\{{.ModuleName}}\{{.JavaName}}Model;
use think\db\exception\DbException;
use think\model\contract\Modelable;

/**
 * {{.Comment}}dao
 */
class {{.JavaName}}Dao {

    protected {{.JavaName}}Model ${{.LowerJavaName}}Model;

    public function __construct({{.JavaName}}Model ${{.LowerJavaName}}) {
        $this->{{.LowerJavaName}}Model = ${{.LowerJavaName}};
    }

    /**
     * 添加{{.Comment}}
     */
    public function add{{.JavaName}} (Add{{.JavaName}}Dto $dto): bool {
        return $this->{{.LowerJavaName}}Model->save($dto);
    }

    /**
     * 删除{{.Comment}}
     */
    public function delete{{.JavaName}} (array $ids): bool {
        return {{.JavaName}}Model::destroy($ids);
    }

    /**
     * 修改{{.Comment}}
     */
    public function update{{.JavaName}} (Update{{.JavaName}}Dto $dto): bool {
       return $this->{{.LowerJavaName}}Model->save($dto);
    }

    /**
     * 修改{{.Comment}}状态
     */
    public function update{{.JavaName}}Status (Update{{.JavaName}}StatusDto $dto): Modelable {
        return $this->{{.LowerJavaName}}Model->whereIn('id', $dto->ids)->update(['status' => $dto->status]);
    }

    /**
     * 查询{{.Comment}}详情
     * @throws DbException
     */
    public function query{{.JavaName}}Detail (Query{{.JavaName}}DetailDto $dto): ?{{.JavaName}}Model {
        return $this->{{.LowerJavaName}}Model->where('id', $dto->id)->find();
    }

    /**
     * 根据id查询{{.Comment}}详情
     * @throws DbException
     */
    public function query{{.JavaName}}ById (int $id): ?{{.JavaName}}Model {
        return $this->{{.LowerJavaName}}Model->where('id', $id)->find();
    }

    /**
     * 查询{{.Comment}}列表
     * @throws DbException
     */
    public function query{{.JavaName}}List (Query{{.JavaName}}ListDto $dto): array {
        $query = $this->{{.LowerJavaName}}Model->where('1=1');

{{- range .TableColumn}}
	{{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
	{{- else if eq .GoType "time.Time"}}
	{{- else if eq .GoType "string"}}
        if (!empty($dto->{{.JavaName}})) {
            $query = $query->where('{{.ColumnName}}', 'like', '%' . $dto->{{.JavaName}} . '%');
        }
    {{- else}}
        if ($dto->{{.JavaName}} != 2) {
            $query = $query->where('{{.ColumnName}}', $dto->{{.JavaName}});
        }
	{{- end}}
	{{- end}}


        $query = $query->order('create_time', 'desc');

        $paginator = $query->paginate(['list_rows' => $dto->pageSize, 'page' => $dto->pageNo]);
        $total = $paginator->total();
        $items = $paginator->items();

        return array('total' => $total, 'list' => $items);
    }

}