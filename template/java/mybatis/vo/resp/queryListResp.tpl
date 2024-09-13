package {{.PackageName}}.vo.resp;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 描述：{{.Comment}}
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("查询{{.Comment}}列表响应vo")
public class Query{{.JavaName}}ListRespVo implements Serializable {

{{range .TableColumn}}
    {{- if eq .JavaType `Date` }}
    @ApiModelProperty("{{.ColumnComment}}")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private {{.JavaType}} {{.JavaName}};
    {{- else}}
    @ApiModelProperty("{{.ColumnComment}}")
    private {{.JavaType}} {{.JavaName}};
    {{- end}}
{{end}}

}
