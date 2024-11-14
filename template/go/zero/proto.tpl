syntax = "proto3";

package main;

option go_package = "./proto";

// 添加{{.Comment}}
message Add{{.JavaName}}Req {
{{- range .TableColumn}}
{{- if isContain .JavaName "createTime"}}
{{- else if isContain .JavaName "update"}}
{{- else}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{- end}}
{{- end}}
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
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "updateTime"}}
{{- else}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{- end}}
{{- end}}
}

message Update{{.JavaName}}Resp {
  string pong = 1;
}

// 更新{{.Comment}}状态
message Update{{.JavaName}}StatusReq {
{{- range .TableColumn}}
{{- if eq .ColumnKey "PRI"}}
  repeated {{.ProtoType}} {{.GoName}}s = {{.Sort}}; //{{.ColumnComment}}
{{- else if isContain .JavaName "status"}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{- else if isContain .JavaName "Status"}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{- else if isContain .JavaName "updateBy"}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{- else}}
{{- end}}

{{- end}}
}

message Update{{.JavaName}}StatusResp {
  string pong = 1;
}

// 查询{{.Comment}}详情
message Query{{.JavaName}}DetailReq {
    int64 id = 1;
}

message Query{{.JavaName}}DetailResp {
{{range .TableColumn}}  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{end}}
}

// 分页查询{{.Comment}}列表
message Query{{.JavaName}}ListReq {
{{- range .ListColumn}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{- end}}
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
  // 更新{{.Comment}}状态
  rpc Update{{.JavaName}}Status(Update{{.JavaName}}StatusReq) returns (Update{{.JavaName}}StatusResp ){}
  // 查询{{.Comment}}详情
   rpc Query{{.JavaName}}Detail(Query{{.JavaName}}DetailReq) returns (Query{{.JavaName}}DetailResp){}
  // 查询{{.Comment}}列表
  rpc Query{{.JavaName}}List(Query{{.JavaName}}ListReq) returns (Query{{.JavaName}}ListResp){}


}
