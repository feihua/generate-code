package {{.PackageName}}.vo.resp;

import io.swagger.v3.oas.annotations.media.Schema;

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
@Schema(description = "{{.Comment}}响应vo")
public class Query{{.JavaName}}DetailRespVo implements Serializable {

{{range .TableColumn}}	{{if eq .JavaType `Date` }}@Schema(description = "{{.ColumnComment}}")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8"){{else}}@Schema(description = "{{.ColumnComment}}"){{end}}
	private {{.JavaType}} {{.JavaName}};

{{end}}}
