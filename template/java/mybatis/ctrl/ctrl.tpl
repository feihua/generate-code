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

import {{.GroupId}}.common.vo.Result;
import {{.GroupId}}.common.vo.ResultPage;
import {{.PackageName}}.annotation.OperateLog;
import {{.PackageName}}.vo.req.{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}ListReqVo;
import {{.PackageName}}.vo.req.Add{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.req.{{.JavaName}}DeleteReqVo;
import {{.PackageName}}.vo.req.Update{{.JavaName}}ReqVo;
import {{.PackageName}}.vo.resp.{{.JavaName}}RespVo;
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
   @PostMapping("/save{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】添加{{.Comment}}")
   public Result<Integer> save{{.JavaName}}(@RequestBody @Valid Add{{.JavaName}}ReqVo record){
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
   @ApiOperation("删除{{.Comment}}")
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
   @ApiOperation("更新{{.Comment}}")
   @PutMapping("/update{{.JavaName}}")
   @OperateLog(description = "【{{.Comment}}】更新{{.Comment}}")
   public Result<Integer> update{{.JavaName}}(@RequestBody @Valid Update{{.JavaName}}ReqVo record){
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
   @ApiOperation("查询{{.Comment}}")
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
   @ApiOperation("查询{{.Comment}}列表")
   @PostMapping("/query{{.JavaName}}List")
   @OperateLog(description = "【{{.Comment}}】查询{{.Comment}}列表")
   public Result<ResultPage<{{.JavaName}}RespVo>> query{{.JavaName}}List(@RequestBody @Valid {{.JavaName}}ListReqVo record){
        return Result.success({{.LowerJavaName}}Service.query{{.JavaName}}List(record));
   }

}
