package {{.PackageName}}.dao;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

import {{.PackageName}}.entity.{{.JavaName}}Bean;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Mapper
public interface {{.JavaName}}Dao {

   /**
    * 添加{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int add{{.JavaName}}({{.JavaName}}Bean {{.LowerJavaName}});

   /**
    * 删除{{.Comment}}
    *
    * @param ids 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int delete{{.JavaName}}(List<Integer> ids);

   /**
    * 更新{{.Comment}}
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return int
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   int update{{.JavaName}}({{.JavaName}}Bean {{.LowerJavaName}});

      /**
       * 更新{{.Comment}}状态
       *
       * @param {{.LowerJavaName}} 请求参数
       * @return int
       * @author {{.Author}}
       * @date: {{.CreateTime}}
       */
      int update{{.JavaName}}Status({{.JavaName}}Bean {{.LowerJavaName}});

   /**
    * 查询{{.Comment}}详情
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return {{.JavaName}}
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   {{.JavaName}}Bean query{{.JavaName}}Detail({{.JavaName}}Bean {{.LowerJavaName}});

   /**
    * 查询{{.Comment}}列表
    *
    * @param {{.LowerJavaName}} 请求参数
    * @return List<{{.JavaName}}>
    * @author {{.Author}}
    * @date: {{.CreateTime}}
    */
   List<{{.JavaName}}Bean> query{{.JavaName}}List({{.JavaName}}Bean {{.LowerJavaName}});

}
