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
@ApiModel("{{.Comment}}请求listVo")
public class {{.JavaName}}ListReqVo implements Serializable {

    @ApiModelProperty(value = "当前页", required = true)
    @NotNull(message = "pageNum当前页不能为空")
    @Min(value=1,message = "pageNum当前页不能小于1")
    private Integer pageNum;

    @ApiModelProperty(value = "每页的数量", required = true)
    @NotNull(message = "pageSize每页的数量不能为空")
    private Integer pageSize;

{{range .TableColumn}}	@ApiModelProperty(value = "{{.ColumnComment}}")
	//@NotBlank(message = "{{.JavaName}}{{.ColumnComment}}不能为空")
	private {{.JavaType}} {{.JavaName}};

{{end}}}
