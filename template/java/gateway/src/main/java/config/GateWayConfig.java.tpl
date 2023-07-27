package {{.PackageName}}.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

/**
 * 描述：网关配置信息
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Configuration
public class GateWayConfig {

	/** 是否是测试 */
	@Value("${jwt.test}")
	public boolean isTest;

	/** token拦截时校验的key */
	@Value("${jwt.secret.key}")
	public String jwtSecretKey;

	/** 不需要拦截的路径 */
	@Value("${jwt.allowed.paths}")
	public String allowedPaths;
}
