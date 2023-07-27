package {{.PackageName}}.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

/**
 * 描述：配置信息
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Configuration
public class Config {

	@Value("${jwt.secret.key}")
	public String jwtSecretKey;


}
