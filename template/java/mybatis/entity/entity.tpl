package {{.PackageName}}.entity;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class {{.JavaName}}Bean implements Serializable {
{{range .TableColumn}}  //{{.ColumnComment}}
  private {{.JavaType}} {{.JavaName}}; 
{{end}}}
