spring:
  application:
    name: {{.ArtifactId}}
  datasource:
    url: jdbc:mysql://10.168.11.61:3309/msg_db?characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false
    username: dba_msginfo
    password: UA9655pwd_msg
    driver-class-name: com.mysql.jdbc.Driver
  main:
    allow-bean-definition-overriding: true
  mvc:
    pathmatch:
      matching-strategy: ant_path_matcher # 解决swagger问题

mybatis:
  mapper-locations: classpath:{{.MapperPath}}/mapper/*.xml
  configuration:
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl

pagehelper:
  helperDialect: mysql
  reasonable: true
  supportMethodsArguments: true
  params: count=countSql

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
  port: 8101
  servlet:
    context-path: /base

jwt:
  secret:
    key: jwt-secret-key