package {{.PackageName}}.vo.req;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.List;

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
@ApiModel("更新{{.Comment}}状态请求Vo")
public class Update{{.JavaName}}StatusReqVo implements Serializable {

	@ApiModelProperty(value = "主键数组", required = true)
	@NotNull(message = "ids主键不能为空")
	private List<Integer> ids;

    @ApiModelProperty(value = "状态", required = true)
    @NotNull(message = "status状态不能为空")
    private Integer status;

}
