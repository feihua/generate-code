package {{.PackageName}}.vo.req;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.Date;

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
@ApiModel("{{.Comment}}请求addVo")
public class {{.JavaName}}AddReqVo implements Serializable {

{{range .TableColumn}}	@ApiModelProperty(value = "{{.ColumnComment}}", required = true)
	//@NotBlank(message = "{{.JavaName}}{{.ColumnComment}}不能为空")
	private {{.JavaType}} {{.JavaName}};

{{end}}}