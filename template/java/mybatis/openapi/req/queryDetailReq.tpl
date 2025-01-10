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
@Schema(description = "{{.Comment}}请求vo")
public class Query{{.JavaName}}DetailReqVo implements Serializable {

{{range .TableColumn}}
{{- if eq .ColumnKey "PRI"}}
	@Schema(description = "{{.ColumnComment}}", requiredMode = Schema.RequiredMode.REQUIRED)
	@NotNull(message = "{{.JavaName}}{{.ColumnComment}}不能为空")
	private {{.JavaType}} {{.JavaName}};
{{- end}}
{{- end}}


}
