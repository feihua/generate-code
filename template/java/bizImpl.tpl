package {{.PackageName}}.biz.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import {{.PackageName}}.entity.{{.JavaName}}Bean;
import {{.PackageName}}.vo.ResultPage;
import {{.PackageName}}.vo.req.{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}ListReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}AddReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}DeleteReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}UpdateReqVo;
import {{.PackageName}}.vo.resp.{{.JavaName}}RespVo;
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
    * 查询{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public {{.JavaName}}RespVo query{{.JavaName}}({{.JavaName}}ReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();{{range .TableColumn}}
        //bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());{{end}}

        {{.JavaName}}Bean query = {{.LowerJavaName}}Dao.query{{.JavaName}}(bean);

        return {{.JavaName}}RespVo.builder().build();
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
   public ResultPage<{{.JavaName}}RespVo> query{{.JavaName}}List({{.JavaName}}ListReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();{{range .TableColumn}}
        //bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());{{end}}

        PageHelper.startPage({{.LowerJavaName}}.getPageNum(), {{.LowerJavaName}}.getPageSize());
	    List<{{.JavaName}}Bean> query = {{.LowerJavaName}}Dao.query{{.JavaName}}List(bean);
        PageInfo<{{.JavaName}}Bean> pageInfo = new PageInfo<>(query);

	    List<{{.JavaName}}RespVo> list = pageInfo.getList().stream().map(x -> {
            {{.JavaName}}RespVo resp = new {{.JavaName}}RespVo();{{range .TableColumn}}
            resp.set{{.GoNamePublic}}(x.get{{.GoNamePublic}}());{{end}}
		   return resp;
	    }).collect(Collectors.toList());

        return new ResultPage<>(list,pageInfo.getPageNum(),pageInfo.getPageSize(),pageInfo.getTotal());

   }

   /**
    * 添加{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public int save{{.JavaName}}({{.JavaName}}AddReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();{{range .TableColumn}}
        bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());{{end}}

        return {{.LowerJavaName}}Dao.save{{.JavaName}}(bean);
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
   public int delete{{.JavaName}}({{.JavaName}}DeleteReqVo {{.LowerJavaName}}){
		return {{.LowerJavaName}}Dao.delete{{.JavaName}}({{.LowerJavaName}}.getIds());
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
   public int update{{.JavaName}}({{.JavaName}}UpdateReqVo {{.LowerJavaName}}){
        {{.JavaName}}Bean bean = new {{.JavaName}}Bean();{{range .TableColumn}}
        bean.set{{.GoNamePublic}}({{.LowerJavaName}}.get{{.GoNamePublic}}());{{end}}

        return {{.LowerJavaName}}Dao.update{{.JavaName}}(bean);
   }

}