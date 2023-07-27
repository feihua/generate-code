package {{.PackageName}}.filter;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.server.ServerWebExchange;

import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

import {{.PackageName}}.config.GateWayConfig;

/**
 * 描述：jwt拦截器
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Slf4j
//@Component
//@Order(Ordered.HIGHEST_PRECEDENCE)
public class JwtFilter implements GlobalFilter {
	@Autowired
	private GateWayConfig gateWayConfig;

	/**
	 * 过滤
	 *
	 * @param exchange 转换
	 * @param chain 调用链
	 * @return Mono<Void>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@Override
	public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
		String path = exchange.getRequest().getPath().toString();
		log.info(path);
		if (gateWayConfig.allowedPaths.contains(path) || path.contains("v2/api-docs")) {
			return chain.filter(exchange);
		}

		HttpHeaders headers = exchange.getRequest().getHeaders();
		String token = headers.getFirst("Authorization");
		if (!StringUtils.hasText(token) || !token.startsWith("Bearer ")) {
			return unauthorized(exchange, "Authorization参数缺失或者格式不正确!");
		}

		try {
			token = token.substring(7);
			Claims claims = Jwts.parser().setSigningKey(gateWayConfig.jwtSecretKey).parseClaimsJws(token).getBody();
			String userName = (String) claims.get("userName");
			Integer userId = (Integer) claims.get("userId");
			List<String> permissions = (List<String>) claims.get("permissions");

			boolean count = permissions.stream().noneMatch(x -> x.equals(path));
			if (count && !gateWayConfig.isTest) {
				return unauthorized(exchange, "没有权限访问路径：" + path);
			}

			exchange.getRequest().mutate().header("userName", userName).header("userId", userId.toString()).build();
		} catch (Exception e) {
			return unauthorized(exchange, "解析token异常");
		}

		return chain.filter(exchange);
	}

	/**
	 * 认证失败时返回
	 *
	 * @param exchange 转换
	 * @param message 返回的信息
	 * @return Mono<Void>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	private Mono<Void> unauthorized(ServerWebExchange exchange, String message) {
		exchange.getResponse().setStatusCode(HttpStatus.OK);
		exchange.getResponse().getHeaders().add("Content-Type", "application/json;charset=UTF-8");
		String body = "{\"code\":401,\"message\":\\" + message + "\"}";
		return exchange.getResponse()
				.writeWith(Mono.just(exchange.getResponse().bufferFactory().wrap(body.getBytes())));
	}
}

