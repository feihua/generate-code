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

import jakarta.validation.Valid;

import {{.GroupId}}.common.vo.Result;
import {{.GroupId}}.common.vo.ResultPage;
import {{.PackageName}}.annotation.OperateLog;
import {{.PackageName}}.vo.req.{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}ListReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}AddReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}DeleteReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}UpdateReqVo;
import {{.PackageName}}.vo.resp.{{.JavaName}}RespVo;
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
    * @param record 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Operation(summary = "添加{{.Comment}}")
   @PostMapping("/save{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】添加{{.Comment}}")
   public Result<Integer> save{{.JavaName}}(@RequestBody @Valid {{.JavaName}}AddReqVo record){
        return Result.success({{.LowerJavaName}}Service.save{{.JavaName}}(record));
   }

   /**
    * 删除{{.Comment}}
    *
    * @param record 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Operation(summary = "删除{{.Comment}}")
   @DeleteMapping("/delete{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】删除{{.Comment}}")
   public Result<Integer> delete{{.JavaName}}(@RequestBody @Valid {{.JavaName}}DeleteReqVo record){
        return Result.success({{.LowerJavaName}}Service.delete{{.JavaName}}(record));
   }

   /**
    * 更新{{.Comment}}
    *
    * @param record 请求参数
    * @return Result<Integer>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Operation(summary = "更新{{.Comment}}")
   @PutMapping("/update{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】更新{{.Comment}}")
   public Result<Integer> update{{.JavaName}}(@RequestBody @Valid {{.JavaName}}UpdateReqVo record){
        return Result.success({{.LowerJavaName}}Service.update{{.JavaName}}(record));
   }

   /**
    * 查询{{.Comment}}
    *
    * @param record 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Operation(summary = "查询{{.Comment}}")
   @PostMapping("/query{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】查询{{.Comment}}")
   public {{.JavaName}}RespVo query(@RequestBody @Valid {{.JavaName}}ReqVo record){
       return {{.LowerJavaName}}Service.query{{.JavaName}}(record);
   }

   /**
    * 查询{{.Comment}}列表
    *
    * @param record 请求参数
    * @return {{.JavaName}}Resp
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   @Operation(summary = "查询{{.Comment}}列表")
   @PostMapping("/query{{.JavaName}}List")
   @OperateLog(description = "【{{.Comment}}】查询{{.Comment}}列表")
   public Result<ResultPage<{{.JavaName}}RespVo>> query{{.JavaName}}List(@RequestBody @Valid {{.JavaName}}ListReqVo record){
        return Result.success({{.LowerJavaName}}Service.query{{.JavaName}}List(record));
   }

}
