package {{.PackageName}}.handler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import reactor.core.publisher.Mono;
import springfox.documentation.swagger.web.*;

import java.util.Optional;

/**
 * 描述：SwaggerHandler
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@RestController
public class SwaggerHandler {

	@Autowired(required = false)
	private SecurityConfiguration securityConfiguration;

	@Autowired(required = false)
	private UiConfiguration uiConfiguration;

	private final SwaggerResourcesProvider swaggerResources;

	/**
	 * SwaggerHandler
	 *
	 * @param swaggerResources 资源
	 * @return SwaggerHandler
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@Autowired
	public SwaggerHandler(SwaggerResourcesProvider swaggerResources) {
		this.swaggerResources = swaggerResources;
	}

	/**
	 * SwaggerHandler
	 *
	 * @return Mono<ResponseEntity < SecurityConfiguration>>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@GetMapping("/swagger-resources/configuration/security")
	public Mono<ResponseEntity<SecurityConfiguration>> securityConfiguration() {
		return Mono.just(new ResponseEntity<>(
				Optional.ofNullable(securityConfiguration).orElse(SecurityConfigurationBuilder.builder().build()),
				HttpStatus.OK));
	}

	/**
	 * uiConfiguration
	 *
	 * @return Mono<ResponseEntity < UiConfiguration>>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@GetMapping("/swagger-resources/configuration/ui")
	public Mono<ResponseEntity<UiConfiguration>> uiConfiguration() {
		return Mono.just(new ResponseEntity<>(
				Optional.ofNullable(uiConfiguration).orElse(UiConfigurationBuilder.builder().build()), HttpStatus.OK));
	}

	/**
	 * swaggerResources
	 *
	 * @return Mono<ResponseEntity>
	 * @author {{.Author}}
	 * @date: {{.CreateTime}}
	 */
	@GetMapping("/swagger-resources")
	public Mono<ResponseEntity> swaggerResources() {
		return Mono.just((new ResponseEntity<>(swaggerResources.get(), HttpStatus.OK)));
	}
}
