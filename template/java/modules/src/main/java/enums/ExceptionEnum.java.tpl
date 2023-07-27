package {{.PackageName}}.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 描述：异常枚举
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Getter
@AllArgsConstructor
public enum ExceptionEnum {

	//用户相关
	//USER_INFO_EXIST_ERROR("100000", "test!"),


	;

	private final String code;
	private final String msg;
}
