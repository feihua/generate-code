package {{.PackageName}}.advice;

import javax.servlet.http.HttpServletRequest;
import javax.validation.UnexpectedTypeException;

import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import lombok.extern.slf4j.Slf4j;
import static {{.GroupId}}.common.enums.ResponseExceptionEnum.INTERNAL_SERVER_ERROR;

import {{.PackageName}}.exception.CustomException;
import {{.GroupId}}.common.vo.Result;

/**
 * 描述：异常统一拦截
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Slf4j
@RestControllerAdvice
public class ExceptionAdvice {

	/**
	 * 处理自定义的业务异常
	 *
	 * @param req HttpServletRequest
	 * @param e 自定义的业务异常
	 * @return Result<String>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@ExceptionHandler(value = CustomException.class)
	@ResponseBody
	public Result<String> baseManagerExceptionHandler(HttpServletRequest req, CustomException e) {
		return Result.error(e.getCode(), e.getMessage());
	}

	/**
	 * 处理其他异常
	 *
	 * @param req HttpServletRequest
	 * @param e 自定义的业务异常
	 * @return Result<String>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@ExceptionHandler(value = Exception.class)
	@ResponseBody
	public Result<String> exceptionHandler(HttpServletRequest req, Exception e) {
		log.error("系统异常:{}", e.getMessage());
		return Result.error(INTERNAL_SERVER_ERROR.getCode(), INTERNAL_SERVER_ERROR.getMsg());
	}

	/**
	 * 捕捉全局异常-统一参数校验异常
	 * @param e 统一异常类
	 * @return Result<String>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@ExceptionHandler(value = MethodArgumentNotValidException.class)
	@ResponseBody
	public Result<String> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
		BindingResult bindingResult = e.getBindingResult();
		return buildResult(bindingResult);
	}

	/**
	 * 构建参数异常返回
	 *
	 * @param bindingResult 异常
	 * @return Result<String>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	private static Result<String> buildResult(BindingResult bindingResult) {
		StringBuilder errorMessage = new StringBuilder();
		for (FieldError fieldError : bindingResult.getFieldErrors()) {
			errorMessage.append(fieldError.getDefaultMessage()).append("!, ");
		}
		log.error(errorMessage.toString());
		return Result.error(INTERNAL_SERVER_ERROR.getCode(), errorMessage.toString());
	}

	/**
	 * 统一参数校验-Hibernate
	 * @param e 异常信息
	 * @return Result<String>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@ResponseBody
	@ExceptionHandler(value = BindException.class)
	public Result<String> handleBindException(BindException e) {
		BindingResult bindingResult = e.getBindingResult();
		return buildResult(bindingResult);
	}

	/**
	 * 处理UnexpectedTypeException
	 * @param e 异常信息
	 * @return Result<String>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@ResponseBody
	@ExceptionHandler(value = UnexpectedTypeException.class)
	public Result<String> handleUnexpectedTypeException(UnexpectedTypeException e) {
		log.error(e.getMessage());
		return Result.error(INTERNAL_SERVER_ERROR.getCode(), e.getMessage());
	}
}