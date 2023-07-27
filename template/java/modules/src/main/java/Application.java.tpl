package {{.PackageName}};

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import lombok.extern.slf4j.Slf4j;


/**
 * 描述：服务启动
 * 作者：{{.Author}}
 * 日期：{{.CreateTime}}
 */
@Slf4j
@SpringBootApplication
public class Application implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Override
	public void run(String... args) {
		log.info("服务已启动!");
	}
}