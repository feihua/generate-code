package {{.PackageName}};

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import lombok.extern.slf4j.Slf4j;



/**
 * 描述：网关服务
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Slf4j
@SpringBootApplication
public class GatewayApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(GatewayApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		log.info("Gateway网关服务已启动!");
	}
}