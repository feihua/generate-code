package {{.PackageName}}.vo.req;

import java.util.List;

import io.swagger.v3.oas.annotations.media.Schema;

import java.io.Serializable;

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
public class Delete{{.JavaName}}ReqVo implements Serializable {

	@Schema(description = "主键数组", requiredMode = Schema.RequiredMode.REQUIRED)
	@NotNull(message = "ids不能为空")
	private List<Integer> ids;
}

