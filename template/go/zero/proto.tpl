syntax = "proto3";

package main;

option go_package = "./proto";

// 添加{{.Comment}}
message {{.JavaName}}AddReq {
{{range .TableColumn}}  {{.ProtoType}} {{.GoNamePublic}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message {{.JavaName}}AddResp {
  string pong = 1;
}

// 删除{{.Comment}}
message {{.JavaName}}DeleteReq {
  repeated int64 ids = 1;
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

// 查询单条{{.Comment}}记录
message {{.JavaName}}Req {
{{range .TableColumn}}  {{.ProtoType}} {{.JavaName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message {{.JavaName}}Resp {
{{range .TableColumn}}  {{.ProtoType}} {{.JavaName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

// 分页查询{{.Comment}}列表
message {{.JavaName}}ListReq {
{{range .TableColumn}}  {{.ProtoType}} {{.JavaName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}  int64 current = 1; //第几页
  int64 pageSize = 2; //每页的数量
}

message {{.JavaName}}ListData {
{{range .TableColumn}}  {{.ProtoType}} {{.JavaName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message {{.JavaName}}ListResp {
  int64 total = 1;
  repeated  {{.JavaName}}ListData list = 2;
}

// {{.Comment}}
service {{.JavaName}}Service {
  // 添加{{.Comment}}
  rpc Add{{.JavaName}}({{.JavaName}}AddReq) returns ({{.JavaName}}AddResp){}
  // 删除{{.Comment}}
  rpc Delete{{.JavaName}}({{.JavaName}}DeleteReq) returns ({{.JavaName}}DeleteResp){}
  // 更新{{.Comment}}
  rpc Update{{.JavaName}}({{.JavaName}}UpdateReq) returns ({{.JavaName}}UpdateResp ){}
  // 根据条件查询单条{{.Comment}}记录
    rpc Query{{.JavaName}}({{.JavaName}}Req) returns ({{.JavaName}}Resp){}
  // 查询{{.Comment}}列表
  rpc Query{{.JavaName}}List({{.JavaName}}ListReq) returns ({{.JavaName}}ListResp){}


}
