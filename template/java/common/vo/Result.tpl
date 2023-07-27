package {{.GroupId}}.common.vo;

import java.util.Objects;

import lombok.Data;

import {{.GroupId}}.common.enums.ResponseExceptionEnum;

/**
 * 描述：统一返回
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Data
public class Result<T> {
	private String code;
	private String msg;
	private T data;

	public static Result<String> success() {
		Result<String> result = new Result<>();
		result.setCode(ResponseExceptionEnum.SUCCESS.getCode());
		result.setMsg(ResponseExceptionEnum.SUCCESS.getMsg());
		return result;
	}

	public static <T> Result<T> success(T data) {
		Result<T> result = new Result<>();
		result.setCode(ResponseExceptionEnum.SUCCESS.getCode());
		result.setMsg(ResponseExceptionEnum.SUCCESS.getMsg());
		result.setData(data);
		return result;
	}

	public static <T> Result<T> error(String code, String msg) {
		Result<T> result = new Result<>();
		result.setCode(code);
		result.setMsg(msg);
		return result;
	}

	public static <T> Result<T> error(String msg) {
		Result<T> result = new Result<>();
		result.setCode(ResponseExceptionEnum.INTERNAL_SERVER_ERROR.getCode());
		result.setMsg(msg);
		return result;
	}

	public static <T> Result<T> error() {
		Result<T> result = new Result<>();
		result.setCode(ResponseExceptionEnum.INTERNAL_SERVER_ERROR.getCode());
		result.setMsg(ResponseExceptionEnum.INTERNAL_SERVER_ERROR.getMsg());
		return result;
	}

	public boolean successful() {
		return Objects.equals(this.code, ResponseExceptionEnum.SUCCESS.getCode());
	}

	public boolean fail() {
		return !Objects.equals(this.code, ResponseExceptionEnum.SUCCESS.getCode());
	}
}