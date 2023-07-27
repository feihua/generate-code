spring:
  application:
    name: {{.ArtifactId}}
  main:
    allow-bean-definition-overriding: true
  cloud:
    gateway:
      discovery:
        locator:
          lower-case-service-id: true
          enabled: true
      routes:
        - id: devops-base
          predicates:
            - Path=/api/base/**
          uri: lb://DEVOPS-BASE
          filters:
            - StripPrefix=1
eureka:
  client:
    service-url:
      defaultZone: http://localhost:8111/eureka/
  instance:
    metadata-map: # 元数据设置
      gated-launch: true                                              # 灰度调用
    lease-renewal-interval-in-seconds: 2                              # 设置心跳的时间间隔（默认是30秒）
    lease-expiration-duration-in-seconds: 5                           # 上一次收到client的心跳之后,等待下一次心跳的超时时间（默认是90秒）
    prefer-ip-address: true                                           # 灰度调用
server:
  port: 8600

jwt:
  test: true
  secret:
    key: jwt-secret-key
  allowed:
    paths: /base/sysUser/login,/ops/

