package {{.PackageName}};

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

/**
 * 描述：注册中心服务
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Slf4j
@EnableEurekaServer
@SpringBootApplication
public class EurekaApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(EurekaApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		log.info("Eureka注册中心服务已启动!");
	}
}