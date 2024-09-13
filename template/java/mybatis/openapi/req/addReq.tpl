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
{{range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else}}
    {{- if eq .IsNullable `YES` }}
    @Schema(description = "{{.ColumnComment}}")
    private {{.JavaType}} {{.JavaName}};
    {{- else if eq .JavaName `remark` }}
    @Schema(description = "{{.ColumnComment}}")
    private {{.JavaType}} {{.JavaName}};
    {{- else}}
    @Schema(description = "{{.ColumnComment}}", requiredMode = Schema.RequiredMode.REQUIRED)
    {{- if eq .JavaType `Integer` }}
    @NotNull(message = "{{.JavaName}}{{.ColumnComment}}不能为空")
    {{- else}}
    @NotBlank(message = "{{.JavaName}}{{.ColumnComment}}不能为空")
    {{- end}}
    private {{.JavaType}} {{.JavaName}};
    {{end}}
{{- end}}
{{- end}}

}
