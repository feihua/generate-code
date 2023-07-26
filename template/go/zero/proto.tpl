syntax = "proto3";

package main;

option go_package = "./proto";

// 添加用户管理
message {{.JavaName}}AddReq {
{{range .TableColumn}}  {{.ProtoType}} {{.GoNamePublic}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message {{.JavaName}}AddResp {
  string pong = 1;
}

// 删除{{.Comment}}
message {{.JavaName}}DeleteReq {
  int64 id = 1;
}

message {{.JavaName}}DeleteResp {
  string pong = 1;
}

// 更新{{.Comment}}
message {{.JavaName}}UpdateReq {
{{range .TableColumn}}  {{.ProtoType}} {{.JavaName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message {{.JavaName}}UpdateResp {
  string pong = 1;
}

// 查询{{.Comment}}
message {{.JavaName}}ListReq {
{{range .TableColumn}}  {{.ProtoType}} {{.JavaName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message {{.JavaName}}ListData {
{{range .TableColumn}}  {{.ProtoType}} {{.JavaName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message {{.JavaName}}ListResp {
  int64 total = 1;
  repeated  {{.JavaName}}ListData list = 2;
}

// 根据条件查询单条{{.Comment}}记录
message {{.JavaName}}FindOneReq {
  int64 id = 1;
}

message {{.JavaName}}FindOneResp {
{{range .TableColumn}}  {{.ProtoType}} {{.JavaName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

service {{.JavaName}}Service {
  // 添加{{.Comment}}
  rpc {{.JavaName}}Add({{.JavaName}}AddReq) returns ({{.JavaName}}AddResp){}
  // 删除{{.Comment}}
  rpc {{.JavaName}}Delete({{.JavaName}}DeleteReq) returns ({{.JavaName}}DeleteResp){}
  // 更新{{.Comment}}
  rpc {{.JavaName}}Update({{.JavaName}}UpdateReq) returns ({{.JavaName}}UpdateResp ){}
  // 查询{{.Comment}}
  rpc {{.JavaName}}List({{.JavaName}}ListReq) returns ({{.JavaName}}ListResp){}
  // 根据条件查询单条{{.Comment}}记录
  rpc {{.JavaName}}FindOne({{.JavaName}}FindOneReq) returns ({{.JavaName}}FindOneResp){}
}
