package {{.PackageName}}.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import {{.PackageName}}.annotation.OperateLog;
import {{.PackageName}}.vo.req.*;
import {{.PackageName}}.vo.resp.*;
import {{.PackageName}}.service.{{.JavaName}}Service;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Api(tags = "{{.Comment}}")
@RestController
@RequestMapping("/{{.LowerJavaName}}")
public class {{.JavaName}}Controller {

   @Autowired
   private {{.JavaName}}Service {{.LowerJavaName}}Service;

   /**
    * 添加{{.Comment}}
    *
    * @param record 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperation("添加{{.Comment}}")
   @PostMapping("/add{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】添加{{.Comment}}")
   public Integer add{{.JavaName}}(@RequestBody @Valid Add{{.JavaName}}ReqVo record){
        return {{.LowerJavaName}}Service.add{{.JavaName}}(record);
   }

   /**
    * 删除{{.Comment}}
    *
    * @param record 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperation("删除{{.Comment}}")
   @PostMapping("/delete{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】删除{{.Comment}}")
   public Integer delete{{.JavaName}}(@RequestBody @Valid Delete{{.JavaName}}ReqVo record){
        return {{.LowerJavaName}}Service.delete{{.JavaName}}(record);
   }

   /**
    * 更新{{.Comment}}
    *
    * @param record 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperation("更新{{.Comment}}")
   @PostMapping("/update{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】更新{{.Comment}}")
   public Integer update{{.JavaName}}(@RequestBody @Valid Update{{.JavaName}}ReqVo record){
        return {{.LowerJavaName}}Service.update{{.JavaName}}(record);
   }

   /**
   * 更新{{.Comment}}状态
   *
   * @param record 请求参数
   * @return Result<Integer>
   * @author {{.Author}}
   * @date: {{.CreateTime}}
   */
  @ApiOperation("更新{{.Comment}}状态")
  @PostMapping("/update{{.JavaName}}Status")
  @OperateLog(description = "【{{.Comment}}】更新{{.Comment}}状态")
  public Integer update{{.JavaName}}Status(@RequestBody @Valid Update{{.JavaName}}StatusReqVo record){
       return {{.LowerJavaName}}Service.update{{.JavaName}}Status(record);
  }

   /**
    * 查询{{.Comment}}详情
    *
    * @param record 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperation("查询{{.Comment}}详情")
   @PostMapping("/query{{.JavaName}}Detail")
   @OperateLog(description = "【{{.Comment}}】查询{{.Comment}}详情")
   public Query{{.JavaName}}DetailRespVo query{{.JavaName}}Detail(@RequestBody @Valid Query{{.JavaName}}DetailReqVo record){
       return {{.LowerJavaName}}Service.query{{.JavaName}}Detail(record);
   }

   /**
    * 查询{{.Comment}}列表
    *
    * @param record 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperation("查询{{.Comment}}列表")
   @PostMapping("/query{{.JavaName}}List")
   @OperateLog(description = "【{{.Comment}}】查询{{.Comment}}列表")
   public Query{{.JavaName}}ListRespVo query{{.JavaName}}List(@RequestBody @Valid Query{{.JavaName}}ListReqVo record){
        return {{.LowerJavaName}}Service.query{{.JavaName}}List(record);
   }

}
