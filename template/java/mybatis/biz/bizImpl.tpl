package {{.PackageName}}.biz.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import {{.GroupId}}.common.vo.ResultPage;
import {{.PackageName}}.entity.{{.JavaName}}Bean;
import {{.PackageName}}.vo.req.*;

import {{.PackageName}}.vo.resp.*;
import {{.PackageName}}.dao.{{.JavaName}}Dao;
import {{.PackageName}}.biz.{{.JavaName}}Biz;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Service
public class {{.JavaName}}BizImpl implements {{.JavaName}}Biz {

   @Autowired
   private {{.JavaName}}Dao {{.LowerJavaName}}Dao;

   /**
    * 添加{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public Result<Integer> add{{.JavaName}}(Add{{.JavaName}}ReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();
        {{- range .TableColumn}}
        {{- if isContain .JavaName "create"}}
        {{- else if isContain .JavaName "update"}}
        {{- else if eq .ColumnKey "PRI"}}
        {{- else}}
        bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}()); //{{.ColumnComment}}
        {{- end}}
        {{- end}}

        int i = {{.LowerJavaName}}Dao.add{{.JavaName}}(bean);
        return Result.success(i);
   }

   /**
    * 删除{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public Result<Integer> delete{{.JavaName}}(Delete{{.JavaName}}ReqVo {{.LowerJavaName}}){

		int i = {{.LowerJavaName}}Dao.delete{{.JavaName}}({{.LowerJavaName}}.getIds());
		return Result.success(i);
   }

   /**
    * 更新{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public Result<Integer> update{{.JavaName}}(Update{{.JavaName}}ReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean res = {{.LowerJavaName}}Dao.query{{.JavaName}}ById({{.LowerJavaName}}.getId());
        if (res == null) {
           return Result.error("更新{{.Comment}}失败", "{{.Comment}}不存在");
        }

        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();
        {{- range .TableColumn}}
        {{- if isContain .JavaName "create"}}
        {{- else if isContain .JavaName "update"}}
        {{- else}}
        bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());//{{.ColumnComment}}
        {{- end}}
        {{- end}}

        int i = {{.LowerJavaName}}Dao.update{{.JavaName}}(bean);
        return Result.success(i);
   }

   /**
    * 更新{{.Comment}}状态
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public Result<Integer> update{{.JavaName}}Status(Update{{.JavaName}}StatusReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();
        {{- range .TableColumn}}
        {{- if isContain .JavaName "create"}}
        {{- else if isContain .JavaName "update"}}
        {{- else if isContain .JavaName "sort"}}
        {{- else if isContain .JavaName "remark"}}
        {{- else}}
        //bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());//{{.ColumnComment}}
        {{- end}}
        {{- end}}

        int i = {{.LowerJavaName}}Dao.update{{.JavaName}}Status(bean);
        return Result.success(i);
   }

   /**
    * 查询{{.Comment}}详情
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public Result<Query{{.JavaName}}DetailRespVo> query{{.JavaName}}Detail(Query{{.JavaName}}DetailReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();
        {{- range .TableColumn}}
        {{- if isContain .JavaName "create"}}
        {{- else if isContain .JavaName "update"}}
        {{- else if isContain .JavaName "sort"}}
        {{- else if isContain .JavaName "remark"}}
        {{- else if eq .ColumnKey "PRI"}}
        bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());//{{.ColumnComment}}
        {{- else}}
        //bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());//{{.ColumnComment}}
        {{- end}}
        {{- end}}

        {{.JavaName}}Bean {{.LowerJavaName}}Bean = {{.LowerJavaName}}Dao.query{{.JavaName}}Detail(bean);

        Query{{.JavaName}}DetailRespVo resp = new Query{{.JavaName}}DetailRespVo();{{range .TableColumn}}
        resp.set{{.GoNamePublic}}({{.LowerJavaName}}Bean.get{{.GoNamePublic}}());//{{.ColumnComment}}{{end}}

        return Result.success(resp);
   }

   /**
    * 查询{{.Comment}}列表
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public Result<ResultPage<Query{{.JavaName}}ListRespVo>> query{{.JavaName}}List(Query{{.JavaName}}ListReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();
        {{- range .TableColumn}}
        {{- if isContain .JavaName "create"}}
        {{- else if isContain .JavaName "update"}}
        {{- else if isContain .JavaName "sort"}}
        {{- else if isContain .JavaName "remark"}}
        {{- else if eq .ColumnKey "PRI"}}
        {{- else}}
        //bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());//{{.ColumnComment}}
        {{- end}}
        {{- end}}

        PageHelper.startPage({{.LowerJavaName}}.getPageNum(), {{.LowerJavaName}}.getPageSize());
	    List<{{.JavaName}}Bean> query = {{.LowerJavaName}}Dao.query{{.JavaName}}List(bean);
        PageInfo<{{.JavaName}}Bean> pageInfo = new PageInfo<>(query);

	    List<Query{{.JavaName}}ListRespVo> list = pageInfo.getList().stream().map(x -> {
            Query{{.JavaName}}ListRespVo resp = new Query{{.JavaName}}ListRespVo();{{range .TableColumn}}
            resp.set{{.GoNamePublic}}(x.get{{.GoNamePublic}}());//{{.ColumnComment}}{{end}}
		   return resp;
	    }).collect(Collectors.toList());

        return Result.success(new ResultPage<>(list,pageInfo.getPageNum(),pageInfo.getPageSize(),pageInfo.getTotal()));

   }
}