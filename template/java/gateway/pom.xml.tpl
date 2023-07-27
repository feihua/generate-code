<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>{{.ParentArtifactId}}</artifactId>
        <groupId>{{.GroupId}}</groupId>
        <version>0.0.1-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>{{.ArtifactId}}</artifactId>
    <packaging>jar</packaging>

    <name>{{.ArtifactId}}</name>


    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <knife4j.version>2.0.8</knife4j.version>
        <swagger.version>1.5.21</swagger.version>
        <sbu.version>1.9.3</sbu.version>
        <springfox.version>2.9.2</springfox.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-gateway</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt</artifactId>
        </dependency>
        <!--        <dependency>-->
        <!--            <groupId>io.springfox</groupId>-->
        <!--            <artifactId>springfox-swagger-ui</artifactId>-->
        <!--            <version>${springfox.version}</version>-->
        <!--        </dependency>-->
        <!--        <dependency>-->
        <!--            <groupId>com.github.xiaoymin</groupId>-->
        <!--            <artifactId>swagger-bootstrap-ui</artifactId>-->
        <!--            <version>${sbu.version}</version>-->
        <!--        </dependency>-->
        <!--        <dependency>-->
        <!--            <groupId>io.springfox</groupId>-->
        <!--            <artifactId>springfox-swagger2</artifactId>-->
        <!--            <version>${springfox.version}</version>-->
        <!--        </dependency>-->
        <!--        <dependency>-->
        <!--            <groupId>io.springfox</groupId>-->
        <!--            <artifactId>springfox-bean-validators</artifactId>-->
        <!--            <version>${springfox.version}</version>-->
        <!--        </dependency>-->
        <dependency>
            <groupId>com.github.xiaoymin</groupId>
            <artifactId>knife4j-spring-boot-starter</artifactId>
            <version>${knife4j.version}</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
