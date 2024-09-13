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
@ApiModel("查询{{.Comment}}列表请求Vo")
public class Query{{.JavaName}}ListReqVo implements Serializable {

    @ApiModelProperty(value = "当前页", required = true, example = "1")
    @NotNull(message = "pageNum当前页不能为空")
    @Min(value=1,message = "pageNum当前页不能小于1")
    private Integer pageNum;

    @ApiModelProperty(value = "每页的数量", required = true, example = "10")
    @NotNull(message = "pageSize每页的数量不能为空")
    private Integer pageSize;


{{range .TableColumn}}
{{if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else if eq .ColumnKey "remark"}}
{{- else if eq .ColumnKey "sort"}}
{{- else}}
    @ApiModelProperty(value = "{{.ColumnComment}}")
    private {{.JavaType}} {{.JavaName}};
{{- end}}
{{- end}}

}
