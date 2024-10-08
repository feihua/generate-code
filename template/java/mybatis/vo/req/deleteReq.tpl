package {{.PackageName}}.vo.req;

import java.util.List;

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
@ApiModel("删除{{.Comment}}请求vo")
public class Delete{{.JavaName}}ReqVo implements Serializable {

	@ApiModelProperty(value = "主键", required = true)
	@NotNull(message = "ids主键不能为空")
	private List<Long> ids;
}

