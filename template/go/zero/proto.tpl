syntax = "proto3";

package main;

option go_package = "./proto";

// 添加{{.Comment}}
message Add{{.JavaName}}Req {
{{range .TableColumn}}  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message Add{{.JavaName}}Resp {
  string pong = 1;
}

// 删除{{.Comment}}
message Delete{{.JavaName}}Req {
  repeated int64 ids = 1;
}

message Delete{{.JavaName}}Resp {
  string pong = 1;
}

// 更新{{.Comment}}
message Update{{.JavaName}}Req {
{{range .TableColumn}}  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message Update{{.JavaName}}Resp {
  string pong = 1;
}

// 查询单条{{.Comment}}记录
message {{.JavaName}}Req {
    int64 id = 1;
}

message {{.JavaName}}Resp {
{{range .TableColumn}}  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

// 分页查询{{.Comment}}列表
message Query{{.JavaName}}ListReq {
{{range .TableColumn}}  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}  int64 page_num = 1; //第几页
  int64 page_size = 2; //每页的数量
}

message {{.JavaName}}ListData {
{{range .TableColumn}}  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

message Query{{.JavaName}}ListResp {
  int64 total = 1;
  repeated  {{.JavaName}}ListData list = 2;
}

// {{.Comment}}
service {{.JavaName}}Service {
  // 添加{{.Comment}}
  rpc Add{{.JavaName}}(Add{{.JavaName}}Req) returns (Add{{.JavaName}}Resp){}
  // 删除{{.Comment}}
  rpc Delete{{.JavaName}}(Delete{{.JavaName}}Req) returns (Delete{{.JavaName}}Resp){}
  // 更新{{.Comment}}
  rpc Update{{.JavaName}}(Update{{.JavaName}}Req) returns (Update{{.JavaName}}Resp ){}
  // 根据条件查询单条{{.Comment}}记录
    rpc Query{{.JavaName}}({{.JavaName}}Req) returns ({{.JavaName}}Resp){}
  // 查询{{.Comment}}列表
  rpc Query{{.JavaName}}List(Query{{.JavaName}}ListReq) returns (Query{{.JavaName}}ListResp){}


}
