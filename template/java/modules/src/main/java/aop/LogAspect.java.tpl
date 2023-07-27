package {{.PackageName}}.aop;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

import {{.GroupId}}.common.annotation.Log;

import {{.GroupId}}.common.utils.JsonUtils;

/**
 * 描述：log切面
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Aspect
@Component
@Slf4j
public class LogAspect {

	private static final ThreadLocal<Date> beginTimeThreadLocal = new NamedThreadLocal<>("ThreadLocal beginTime");
	//private static final ThreadLocal<AuditLogAddReqVo> logThreadLocal = new NamedThreadLocal<>("ThreadLocal log");
	private static final ThreadLocal<String> resultThreadLocal = new NamedThreadLocal<>("ThreadLocal result");

	@Autowired(required = false)
	private HttpServletRequest request;

	/**
	 * Controller层切点 注解拦截
	 */
	@Pointcut("@annotation({{.GroupId}}.common.annotation.Log)")
	public void controllerAspect() {
	}

	/**
	 * 方法规则拦截
	 */
	@Pointcut("execution(* {{.PackageName}}.controller.*.*(..))")
	public void controllerPointerCut() {
	}

	/**
	 * 前置通知 用于拦截Controller层记录用户的操作的开始时间
	 *
	 * @param joinPoint 切点
	 *
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@Before("controllerAspect()")
	public void doBefore(JoinPoint joinPoint) {
		Date beginTime = new Date();
		beginTimeThreadLocal.set(beginTime);
		log.debug("开始计时: {}, URI: {}", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(beginTime),
				request.getRequestURI());
	}

	@Around("controllerAspect()")
	public Object aroundLog(ProceedingJoinPoint point) throws Throwable {
		Object result = point.proceed();
		resultThreadLocal.set(JsonUtils.toJson(result));
		return result;
	}

	/**
	 * 后置通知 用于拦截Controller层记录用户的操作
	 *
	 * @param joinPoint 切点
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@After("controllerAspect()")
	public void doAfter(JoinPoint joinPoint) {
		String userId = request.getHeader("userId");
		if (StringUtils.isEmpty(userId)) {
			return;
		}

		Object[] args = joinPoint.getArgs();

		String desc = "";
		String type = "info";                       //日志类型(info:入库,error:错误)
		String remoteAddr = request.getRemoteAddr();//请求的IP
		String requestUri = request.getRequestURI();//请求的Uri
		String method = request.getMethod();        //请求的方法类型(post/get)
		Map<String, String[]> paramsMap = request.getParameterMap(); //请求提交的参数
		try {
			desc = getControllerMethodDescription(request, joinPoint);
		} catch (Exception e) {
			e.printStackTrace();
		}

		long beginTime = beginTimeThreadLocal.get().getTime();
		long endTime = System.currentTimeMillis();

		log.debug(
				"计时结束：{}  URI: {}  耗时： {}   最大内存: {}m  已分配内存: {}m  已分配内存中的剩余空间: {}m  最大可用内存: {}m",
				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(endTime), request.getRequestURI(),
				endTime - beginTime, Runtime.getRuntime().maxMemory() / 1024 / 1024,
				Runtime.getRuntime().totalMemory() / 1024 / 1024, Runtime.getRuntime().freeMemory() / 1024 / 1024,
				(Runtime.getRuntime().maxMemory() - Runtime.getRuntime().totalMemory() + Runtime.getRuntime()
						.freeMemory()) / 1024 / 1024);

		//AuditLogAddReqVo logAddReqVo = new AuditLogAddReqVo();
		//logAddReqVo.setUserId(user.getUserId());
		//logAddReqVo.setUserName(user.getUserName());
		//logAddReqVo.setIpAddress(remoteAddr);
		//logAddReqVo.setOperationUrl(requestUri);
		//logAddReqVo.setOperationMethod(method);
		//logAddReqVo.setOperationType(desc);
		//logAddReqVo.setObjectType(type);
		//logAddReqVo.setObjectId(0);
		//logAddReqVo.setRequestParams(JsonUtils.toJson(args));
		//String s = resultThreadLocal.get();
		//if (s == null) {
		//	s = "error";
		//}
		//logAddReqVo.setResponseParams(s);
		//logAddReqVo.setOperationDate(new Date());

		//log.info("请求参数:{}", JsonUtils.toJson(logAddReqVo));
		//logAddReqVo.setAuditLogId(logBiz.saveAuditLog(logAddReqVo));

		//logThreadLocal.set(logAddReqVo);
	}

	/**
	 * 异常通知
	 *
	 * @param joinPoint
	 * @param e
	 */
	@AfterThrowing(pointcut = "controllerAspect()", throwing = "e")
	public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
		//AuditLogAddReqVo logAddReqVo = logThreadLocal.get();
		//if (logAddReqVo != null) {
		//	logAddReqVo.setObjectType("error");
		//	logAddReqVo.setResponseParams(JsonUtils.toJson(e));
		//	AuditLogUpdateReqVo reqVo = new AuditLogUpdateReqVo();
		//	BeanUtils.copyProperties(logAddReqVo, reqVo);
		//	log.info("异常信息:{}", JsonUtils.toJson(logAddReqVo));
		//	logBiz.updateAuditLog(reqVo);
		//}
	}

	/**
	 * 获取注解中对方法的描述信息 用于Controller层注解
	 *
	 * @param joinPoint 切点
	 * @return 方法描述
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	public static String getControllerMethodDescription(HttpServletRequest request, JoinPoint joinPoint) {
		MethodSignature signature = (MethodSignature) joinPoint.getSignature();
		Method method = signature.getMethod();
		Log controllerLog = method.getAnnotation(Log.class);
		String desc = controllerLog.description();
		if (desc.contains("{")) {
			List<String> list = descFormat(desc);
			for (String s : list) {
				//根据request的参数名获取到参数值，并对注解中的{}参数进行替换
				String value = request.getParameter(s);
				desc = desc.replace("{" + s + "}", value);
			}
		}
		return desc;
	}

	/**
	 * 获取日志信息中的动态参数
	 * @param desc 描述
	 * @return list
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	private static List<String> descFormat(String desc) {
		List<String> list = new ArrayList<String>();
		Pattern pattern = Pattern.compile("\\{([^\\}]+)\\}");
		Matcher matcher = pattern.matcher(desc);
		while (matcher.find()) {
			String t = matcher.group(1);
			list.add(t);
		}
		return list;
	}

}
