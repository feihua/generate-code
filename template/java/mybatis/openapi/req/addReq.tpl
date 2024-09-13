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
@Schema(description = "{{.Comment}}请求addVo")
public class Add{{.JavaName}}ReqVo implements Serializable {

{{range .TableColumn}}	@Schema(description = "{{.ColumnComment}}", requiredMode = Schema.RequiredMode.REQUIRED)
	{{if eq .JavaType `int` }}@NotNull{{else}}@NotBlank{{end}}(message = "{{.JavaName}}{{.ColumnComment}}不能为空")
	private {{if eq .JavaType `int` }}Integer{{else}}{{.JavaType}}{{end}} {{.JavaName}};

{{end}}}