server:
  port: 8111
spring:
  application:
    name: {{.ArtifactId}}
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:8111/eureka
    # 表示是否从Eureka Server获取注册的服务信息
    fetch-registry: false
    # 表示是否将自己注册到Eureka Server
    register-with-eureka: false