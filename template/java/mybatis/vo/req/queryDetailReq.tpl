package {{.PackageName}}.vo.req;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

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
@ApiModel("查询{{.Comment}}详情请求Vo")
public class Query{{.JavaName}}DetailReqVo implements Serializable {
{{range .TableColumn}}
{{- if eq .ColumnKey "PRI"}}
	@ApiModelProperty(value = "{{.ColumnComment}}", required = true)
	@NotNull(message = "{{.JavaName}}{{.ColumnComment}}不能为空")
	private {{.JavaType}} {{.JavaName}};
{{- end}}
{{- end}}
}
