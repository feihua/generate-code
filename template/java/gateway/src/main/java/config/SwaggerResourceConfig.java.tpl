package {{.PackageName}}.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.cloud.gateway.config.GatewayProperties;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.support.NameUtils;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import springfox.documentation.swagger.web.SwaggerResource;
import springfox.documentation.swagger.web.SwaggerResourcesProvider;

/**
 * 描述：SwaggerResourceConfig
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Slf4j
@Component
@Primary
@AllArgsConstructor
public class SwaggerResourceConfig implements SwaggerResourcesProvider {

	private final RouteLocator routeLocator;
	private final GatewayProperties gatewayProperties;

	/**
	 * 获取SwaggerResource
	 *
	 * @return List<SwaggerResource>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@Override
	public List<SwaggerResource> get() {
		List<SwaggerResource> resources = new ArrayList<>();
		List<String> routes = new ArrayList<>();
		routeLocator.getRoutes().subscribe(route -> routes.add(route.getId()));
		gatewayProperties.getRoutes().stream().filter(routeDefinition -> routes.contains(routeDefinition.getId()))
				.forEach(route -> {
					route.getPredicates().stream()
							.filter(predicateDefinition -> ("Path").equalsIgnoreCase(predicateDefinition.getName()))
							.forEach(predicateDefinition -> resources.add(swaggerResource(route.getId(),
									predicateDefinition.getArgs().get(NameUtils.GENERATED_NAME_PREFIX + "0")
											.replace("**", "v2/api-docs"))));
				});

		return resources;
	}

	/**
	 * 转换英文显示
	 *
	 * @param name 名称
	 * @param location 地址
	 * @return SwaggerResource
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	private SwaggerResource swaggerResource(String name, String location) {
		log.info("name:{},location:{}", name, location);
		SwaggerResource swaggerResource = new SwaggerResource();
		if (name.equals("devops-base")) {
			name = "基础服务";
		}
		if (name.equals("devops-assetmanager")) {
			name = "资产管理平台";
		}
		if (name.equals("devops-cicd")) {
			name = "持续集成";
		}
		if (name.equals("devops-monitor")) {
			name = "监控服务";
		}
		if (name.equals("devops-ops")) {
			name = "运维平台";
		}
		if (name.equals("devops-share")) {
			name = "jenkins分享库";
		}
		swaggerResource.setName(name);
		swaggerResource.setLocation(location);
		swaggerResource.setSwaggerVersion("2.0");
		return swaggerResource;
	}
}
