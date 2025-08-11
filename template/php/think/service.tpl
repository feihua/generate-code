<?php

namespace app\service\{{.ModuleName}};

use app\dto\{{.ModuleName}}\{{.JavaName}}Dto;
use app\model\{{.ModuleName}}\{{.JavaName}}Model;
use think\db\exception\DbException;
use Exception;
use think\model\contract\Modelable;

/**
 * {{.Comment}}服务
 */
class {{.JavaName}}Service {
    protected {{.JavaName}}Model ${{.LowerJavaName}}Model;

    public function __construct({{.JavaName}}Model ${{.LowerJavaName}}) {
        $this->{{.LowerJavaName}}Model = ${{.LowerJavaName}};
    }

    /**
     * 添加{{.Comment}}
     * @throws Exception
     */
    public function add{{.JavaName}} ({{.JavaName}}Dto $dto): bool {
        $dto->addValidate();
        return $this->{{.LowerJavaName}}Model->save($dto->toArray());
    }


    /**
     * 删除{{.Comment}}
     * @throws Exception
     */
    public function delete{{.JavaName}} (array $ids): bool {

        return {{.JavaName}}Model::destroy($ids);
    }

    /**
     * 修改{{.Comment}}
     * @throws Exception
     */
    public function update{{.JavaName}} ({{.JavaName}}Dto $dto): bool {
        $dto->updateValidate();

        ${{.GoName}} = $this->{{.LowerJavaName}}Model->where('id', $dto->id)->find();
        if (!${{.GoName}}) {
            throw new Exception('{{.Comment}}不存在');
        }

        return $this->{{.LowerJavaName}}Model->save($dto->toArray());
    }

    /**
     * 修改{{.Comment}}状态
     * @throws Exception
     */
    public function update{{.JavaName}}Status (array $ids, int $status): Modelable {

    return $this->{{.LowerJavaName}}Model->whereIn('id', $ids)->update(['status' => $status]);
    }

    /**
     * 查询{{.Comment}}详情
     * @throws DbException
     * @throws Exception
     */
    public function query{{.JavaName}}Detail (int $id): array {

        ${{.GoName}} = $this->{{.LowerJavaName}}Model->where('id', $id)->find();

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
    public function query{{.JavaName}}List (array $params): array {

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
        if (!empty($params['{{.JavaName}}'])) {
            $query = $query->where('{{.ColumnName}}', 'like', '%' . $params['{{.JavaName}}'] . '%');
        }
    {{- else}}
        if ($params['{{.JavaName}}'] != 2) {
            $query = $query->where('{{.ColumnName}}', $params['{{.JavaName}}']);
        }
	{{- end}}
	{{- end}}


        $query = $query->order('create_time', 'desc');

        $paginator = $query->paginate(['list_rows' => $params['pageSize'], 'page' => $params['pageNo']]);
        $total = $paginator->total();
        $items = $paginator->items();

        return array('total' => $total, 'list' => $items);
    }

}