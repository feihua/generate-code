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
@ApiModel("更新{{.Comment}}请求Vo")
public class Update{{.JavaName}}ReqVo implements Serializable {

{{range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else}}
    {{- if eq .IsNullable `YES` }}
    @ApiModelProperty(value = "{{.ColumnComment}}", required = false)
    private {{.JavaType}} {{.JavaName}};
    {{- else if eq .JavaName `remark` }}
    @ApiModelProperty(value = "{{.ColumnComment}}")
    private {{.JavaType}} {{.JavaName}};
    {{- else}}
    @ApiModelProperty(value = "{{.ColumnComment}}", required = true)
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
