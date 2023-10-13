package {{.PackageName}}.vo.req;

import io.swagger.v3.oas.annotations.media.Schema;

import java.io.Serializable;
import java.util.Date;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
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
@Schema(description = "{{.Comment}}请求listVo")
public class {{.JavaName}}ListReqVo implements Serializable {

    @Schema(description = "当前页", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @NotNull(message = "pageNum当前页不能为空")
    @Min(value=1,message = "pageNum当前页不能小于1")
    private Integer pageNum;

    @Schema(description = "每页的数量", requiredMode = Schema.RequiredMode.REQUIRED, example = "10")
    @NotNull(message = "pageSize每页的数量不能为空")
    private Integer pageSize;

{{range .TableColumn}}	@Schema(description = "{{.ColumnComment}}")
	//{{if eq .JavaType `int` }}@NotNull{{else}}@NotBlank{{end}}(message = "{{.JavaName}}{{.ColumnComment}}不能为空")
	private {{if eq .JavaType `int` }}Integer{{else}}{{.JavaType}}{{end}} {{.JavaName}};

{{end}}}
