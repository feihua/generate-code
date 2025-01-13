package {{.PackageName}}.biz;

import java.util.Map;

import {{.GroupId}}.common.vo.ResultPage;
import {{.PackageName}}.vo.req.*;
import {{.PackageName}}.vo.resp.*;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
public interface {{.JavaName}}Biz {

   /**
    * 添加{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   Result<Integer> add{{.JavaName}}(Add{{.JavaName}}ReqVo {{.LowerJavaName}});

   /**
    * 删除{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   Result<Integer> delete{{.JavaName}}(Delete{{.JavaName}}ReqVo {{.LowerJavaName}});

   /**
    * 更新{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   Result<Integer> update{{.JavaName}}(Update{{.JavaName}}ReqVo {{.LowerJavaName}});

   /**
    * 更新{{.Comment}}状态
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   Result<Integer> update{{.JavaName}}Status(Update{{.JavaName}}StatusReqVo {{.LowerJavaName}});

   /**
    * 查询{{.Comment}}详情
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   Result<Query{{.JavaName}}DetailRespVo> query{{.JavaName}}Detail(Query{{.JavaName}}DetailReqVo {{.LowerJavaName}});

   /**
    * 查询{{.Comment}}列表
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return ResultPage<{{.JavaName}}Resp>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   Result<ResultPage<Query{{.JavaName}}ListRespVo>> query{{.JavaName}}List(Query{{.JavaName}}ListReqVo {{.LowerJavaName}});

}