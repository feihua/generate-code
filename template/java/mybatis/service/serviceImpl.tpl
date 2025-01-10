package {{.PackageName}}.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import {{.GroupId}}.common.vo.ResultPage;
import {{.PackageName}}.vo.req.*;
import {{.PackageName}}.vo.resp.*;
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
   public int add{{.JavaName}}(Add{{.JavaName}}ReqVo {{.LowerJavaName}}){

        return {{.LowerJavaName}}Biz.add{{.JavaName}}({{.LowerJavaName}});
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
   public int delete{{.JavaName}}(Delete{{.JavaName}}ReqVo {{.LowerJavaName}}){
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
   * 更新{{.Comment}}状态
   *
   * @param {{.LowerJavaName}} 请求参数
   * @return int
   * @author {{.Author}}
   * @date: {{.CreateTime}}
   */
  @Override
  public int update{{.JavaName}}Status(Update{{.JavaName}}StatusReqVo {{.LowerJavaName}}){

       return {{.LowerJavaName}}Biz.update{{.JavaName}}Status({{.LowerJavaName}});
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
   public Query{{.JavaName}}DetailRespVo query{{.JavaName}}Detail(Query{{.JavaName}}DetailReqVo {{.LowerJavaName}}){

       return {{.LowerJavaName}}Biz.query{{.JavaName}}Detail({{.LowerJavaName}});
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
   public ResultPage<Query{{.JavaName}}ListRespVo> query{{.JavaName}}List(Query{{.JavaName}}ListReqVo {{.LowerJavaName}}){

        return {{.LowerJavaName}}Biz.query{{.JavaName}}List({{.LowerJavaName}});
   }

}