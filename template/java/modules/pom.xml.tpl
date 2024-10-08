<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>common-service</artifactId>
        <groupId>{{.GroupId}}</groupId>
        <version>0.0.1-SNAPSHOT</version>
        <relativePath>../common-service</relativePath>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>{{.ArtifactId}}</artifactId>
    <packaging>jar</packaging>

    <name>{{.ArtifactId}}</name>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>

    </properties>

    <dependencies>

        <dependency>
            <groupId>{{.GroupId}}</groupId>
            <artifactId>common-utils</artifactId>
            <version>0.0.1-SNAPSHOT</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>

    </dependencies>

</project>
