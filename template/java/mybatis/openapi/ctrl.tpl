package {{.PackageName}}.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.github.xiaoymin.knife4j.annotations.ApiOperationSupport;

import jakarta.validation.Valid;

import {{.GroupId}}.common.vo.Result;
import {{.GroupId}}.common.vo.ResultPage;
import {{.PackageName}}.annotation.OperateLog;
import {{.PackageName}}.vo.req.*;
import {{.PackageName}}.vo.resp.*;
import {{.PackageName}}.service.{{.JavaName}}Service;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Tag(name = "{{.Comment}}")
@RestController
@RequestMapping("/{{.LowerJavaName}}")
public class {{.JavaName}}Controller {

   @Autowired
   private {{.JavaName}}Service {{.LowerJavaName}}Service;

   /**
    * 添加{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperationSupport(order = 1)
   @Operation(summary = "1.1 添加{{.Comment}}")
   @PostMapping("/add{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】添加{{.Comment}}")
   public Result<Integer> add{{.JavaName}}(@RequestBody @Valid Add{{.JavaName}}ReqVo {{.LowerJavaName}}){
        return {{.LowerJavaName}}Service.add{{.JavaName}}({{.LowerJavaName}});
   }

   /**
    * 删除{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperationSupport(order = 2)
   @Operation(summary = "1.2 删除{{.Comment}}")
   @DeleteMapping("/delete{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】删除{{.Comment}}")
   public Result<Integer> delete{{.JavaName}}(@RequestBody @Valid Delete{{.JavaName}}ReqVo {{.LowerJavaName}}){
        return {{.LowerJavaName}}Service.delete{{.JavaName}}({{.LowerJavaName}});
   }

   /**
    * 更新{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperationSupport(order = 3)
   @Operation(summary = "1.3 更新{{.Comment}}")
   @PutMapping("/update{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】更新{{.Comment}}")
   public Result<Integer> update{{.JavaName}}(@RequestBody @Valid Update{{.JavaName}}ReqVo {{.LowerJavaName}}){
        return {{.LowerJavaName}}Service.update{{.JavaName}}({{.LowerJavaName}});
   }

   /**
   * 更新{{.Comment}}状态
   *
   * @param {{.LowerJavaName}} 请求参数
   * @return Result<Integer>
   * @author {{.Author}}
   * @date: {{.CreateTime}}
    */
   @ApiOperationSupport(order = 4)
   @Operation(summary = "1.4 更新{{.Comment}}状态")
   @PutMapping("/update{{.JavaName}}Status")
   @OperateLog(description = "【{{.Comment}}】更新{{.Comment}}状态")
  public Result<Integer> update{{.JavaName}}Status(@RequestBody @Valid Update{{.JavaName}}StatusReqVo {{.LowerJavaName}}){
       return {{.LowerJavaName}}Service.update{{.JavaName}}Status({{.LowerJavaName}});
  }

   /**
    * 查询{{.Comment}}详情
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperationSupport(order = 5)
   @Operation(summary = "1.5 查询{{.Comment}}详情")
   @PostMapping("/query{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】查询{{.Comment}}详情")
   public Result<Query{{.JavaName}}DetailRespVo> query{{.JavaName}}Detail(@RequestBody @Valid Query{{.JavaName}}DetailReqVo {{.LowerJavaName}}){
       return {{.LowerJavaName}}Service.query{{.JavaName}}Detail({{.LowerJavaName}});
   }

   /**
    * 查询{{.Comment}}列表
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @ApiOperationSupport(order = 6)
   @Operation(summary = "1.6 查询{{.Comment}}列表")
   @PostMapping("/query{{.JavaName}}List")
   @OperateLog(description = "【{{.Comment}}】查询{{.Comment}}列表")
   public Result<ResultPage<Query{{.JavaName}}ListRespVo>> query{{.JavaName}}List(@RequestBody @Valid Query{{.JavaName}}ListReqVo {{.LowerJavaName}}){
        return {{.LowerJavaName}}Service.query{{.JavaName}}List({{.LowerJavaName}});
   }

}
