package {{.PackageName}}.exception;

import lombok.Data;

import {{.PackageName}}.enums.ExceptionEnum;

/**
 * 描述：自定义异常
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Data
public class CustomException extends RuntimeException {
	private String code;

	/**
	 * 服务自定义异常构造方法
	 *
	 * @param exceptionEnum 异常代码
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	public CustomException(ExceptionEnum exceptionEnum) {
		super(exceptionEnum.getMsg());
		this.code = exceptionEnum.getCode();
	}

	/**
	 * 服务自定义异常构造方法
	 *
	 * @param code 异常代码
	 * @param message 异常信息
	 * @author {{.Author}}
	 * @date {{.CreateTime}}
	 */
	public CustomException(String code, String message) {
		super(message);
		this.code = code;
	}
}
