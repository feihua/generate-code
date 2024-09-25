> 基础代码生成工具

## 安装
```shell
go install github.com/feihua/generate-code@latest

generate-code golang zero --dsn "root:123456@tcp(127.0.0.1:3306)/demo" --tableNames sys_ --prefix sys_  --rpcClient sysclient --author liufeihua
```
## 参数解释：
```
dsn: 请输入数据库的地址
tableNames: 请输入表名称
prefix: 生成表时候去掉前缀
author: 请输入作者名称
rpcClient请输入生成rpc的模块名称
```
