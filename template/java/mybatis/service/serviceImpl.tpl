package {{.PackageName}}.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import {{.GroupId}}.common.vo.ResultPage;
import {{.PackageName}}.vo.req.{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}ListReqVo;
import {{.PackageName}}.vo.req.Add{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}DeleteReqVo;
import {{.PackageName}}.vo.req.Update{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.resp.{{.JavaName}}RespVo;
import {{.PackageName}}.biz.{{.JavaName}}Biz;
import {{.PackageName}}.service.{{.JavaName}}Service;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Service
public class {{.JavaName}}ServiceImpl implements {{.JavaName}}Service {

   @Autowired
   private {{.JavaName}}Biz {{.LowerJavaName}}Biz;

   /**
    * 添加{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Override
   public int save{{.JavaName}}(Add{{.JavaName}}ReqVo {{.LowerJavaName}}){

        return {{.LowerJavaName}}Biz.save{{.JavaName}}({{.LowerJavaName}});
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
		return {{.LowerJavaName}}Biz.delete{{.JavaName}}({{.LowerJavaName}});
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
   public int update{{.JavaName}}(Update{{.JavaName}}ReqVo {{.LowerJavaName}}){

        return {{.LowerJavaName}}Biz.update{{.JavaName}}({{.LowerJavaName}});
   }

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

       return {{.LowerJavaName}}Biz.query{{.JavaName}}({{.LowerJavaName}});
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

        return {{.LowerJavaName}}Biz.query{{.JavaName}}List({{.LowerJavaName}});
   }

}