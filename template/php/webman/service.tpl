<?php

namespace app\service\{{.ModuleName}};

use app\dto\{{.ModuleName}}\{{.JavaName}}Dto;
use app\model\{{.ModuleName}}\{{.UpperOriginalName}};
use support\exception\BusinessException;
use support\Log;
use Exception;
use think\model\contract\Modelable;

/**
 * {{.Comment}}服务
 */
class {{.JavaName}}Service {

    /**
     * 添加{{.Comment}}
     */
    public function add{{.JavaName}} ({{.JavaName}}Dto $dto): Modelable {
        $dto->validate();
        return {{.UpperOriginalName}}::create($dto->toArray());
    }


    /**
     * 删除{{.Comment}}
     */
    public function delete{{.JavaName}} (array $ids): int {

        return {{.UpperOriginalName}}::destroy($ids);
    }

    /**
     * 修改{{.Comment}}
     */
    public function update{{.JavaName}} ({{.JavaName}}Dto $dto): int {
        $dto->validate();

       ${{.GoName}} = {{.UpperOriginalName}}::where('id', $dto->id)->findOrEmpty();
        if (!${{.GoName}}) {
            throw new BusinessException('{{.Comment}}不存在');
        }

        return (new {{.UpperOriginalName}}())->save($dto->toArray());
    }

    /**
     * 修改{{.Comment}}状态
     */
    public function update{{.JavaName}}Status (array $ids, int $status): Modelable {

        return (new {{.UpperOriginalName}})->wherein('id', $ids)->update(['status' => $status]);
    }

    /**
     * 查询{{.Comment}}详情
     */
    public function query{{.JavaName}}Detail (int $id): array {
        ${{.GoName}} = {{.UpperOriginalName}}::where('id', $id)->findOrEmpty();

        if (!${{.GoName}}) {
            throw new BusinessException('{{.Comment}}不存在');
        }

        return ${{.GoName}}->toArray();
    }

    /**
     * 查询{{.Comment}}列表
     * @throws Exception
     */
    public function query{{.JavaName}}List (array $params): array {

        $query = {{.UpperOriginalName}}::where('1=1');

    {{- range .TableColumn}}
    {{- if isContain .GoNamePublic "Create"}}
    {{- else if isContain .GoNamePublic "Update"}}
    {{- else if eq .ColumnKey "PRI"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "Sort"}}
    {{- else if eq .GoType "time.Time"}}
    {{- else if eq .GoType "string"}}
        //{{.ColumnComment}}
        if (!empty($params['{{.JavaName}}'])) {
            $query = $query->where('{{.ColumnName}}', 'like', '%' . $params['{{.JavaName}}'] . '%');
        }
    {{- else}}
        //{{.ColumnComment}}
        if (isset($params['{{.JavaName}}'])) {
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