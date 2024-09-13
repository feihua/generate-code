package {{.PackageName}}.service;

import java.util.Map;

import {{.PackageName}}.vo.req.*;
import {{.PackageName}}.vo.resp.*;

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
   int add{{.JavaName}}(Add{{.JavaName}}ReqVo {{.LowerJavaName}});

   /**
    * 删除{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int delete{{.JavaName}}(Delete{{.JavaName}}ReqVo {{.LowerJavaName}});

   /**
    * 更新{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int update{{.JavaName}}(Update{{.JavaName}}ReqVo {{.LowerJavaName}});

   /**
    * 更新{{.Comment}}状态
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int update{{.JavaName}}Status(Update{{.JavaName}}StatusReqVo {{.LowerJavaName}});


   /**
    * 查询{{.Comment}}详情
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return Query{{.JavaName}}DetailResp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   Query{{.JavaName}}DetailRespVo query{{.JavaName}}Detail(Query{{.JavaName}}DetailReqVo {{.LowerJavaName}});

   /**
    * 查询{{.Comment}}列表
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return Query{{.JavaName}}ListResp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   Query{{.JavaName}}ListRespVo query{{.JavaName}}List(Query{{.JavaName}}ListReqVo {{.LowerJavaName}});

}