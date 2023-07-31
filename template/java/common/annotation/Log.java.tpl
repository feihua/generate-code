package {{.GroupId}}.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 描述：自定义注解
 * 作者：{{.Author}}
 * 日期: {{.CreateTime}}
 */
@Target({ ElementType.PARAMETER, ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
public @interface Log {

	/**
	 * 描述业务操作 例:Xxx管理-执行Xxx操作
	 * 支持动态入参，例：新增应用{applicationName}，其中applicationName是请求参数名
	 * @return str
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	String description() default "";
}
