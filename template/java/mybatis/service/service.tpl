package {{.PackageName}}.service;

import java.util.Map;

import {{.GroupId}}.common.vo.ResultPage;
import {{.PackageName}}.vo.req.{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}ListReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}AddReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}DeleteReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}UpdateReqVo;
import {{.PackageName}}.vo.resp.{{.JavaName}}RespVo;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
public interface {{.JavaName}}Service {

   /**
    * 添加{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int save{{.JavaName}}({{.JavaName}}AddReqVo {{.LowerJavaName}});

   /**
    * 删除{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int delete{{.JavaName}}({{.JavaName}}DeleteReqVo {{.LowerJavaName}});

   /**
    * 更新{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int update{{.JavaName}}({{.JavaName}}UpdateReqVo {{.LowerJavaName}});

   /**
    * 查询{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   {{.JavaName}}RespVo query{{.JavaName}}({{.JavaName}}ReqVo {{.LowerJavaName}});

   /**
    * 查询{{.Comment}}列表
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return ResultPage<{{.JavaName}}Resp>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   ResultPage<{{.JavaName}}RespVo> query{{.JavaName}}List({{.JavaName}}ListReqVo {{.LowerJavaName}});

}