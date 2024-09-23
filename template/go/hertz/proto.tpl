// idl/hello/hello.proto
syntax = "proto3";

package {{.LowerJavaName}};

option go_package = "{{.LowerJavaName}}";

import "api.proto";

// 添加{{.Comment}}请求参数
message Add{{.JavaName}}Req {
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}[(api.body) = "{{.JavaName}}"]; //{{.ColumnComment}}
{{- end}}
{{- end}}
}
message Add{{.JavaName}}Resp {
  string msg = 1;
  api.Code code = 2;
}

// 删除{{.Comment}}请求参数
message Delete{{.JavaName}}Req {
  repeated int64 ids = 1[(api.body) = "ids"];
}

message Delete{{.JavaName}}Resp {
  string msg = 1;
  api.Code code = 2;
}

// 更新{{.Comment}}请求参数
message Update{{.JavaName}}Req {
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}[(api.body) = "{{.JavaName}}"]; //{{.ColumnComment}}
{{- end}}
{{- end}}
}

message Update{{.JavaName}}Resp {
  string msg = 1;
  api.Code code = 2;
}

// 更新{{.Comment}}状态请求参数
message Update{{.JavaName}}StatusReq {
{{- range .TableColumn}}
{{- if eq .ColumnKey "PRI"}}
  repeated {{.ProtoType}} {{.GoName}}s = {{.Sort}}[(api.body) = "{{.JavaName}}s"]; //{{.ColumnComment}}
{{- else if isContain .JavaName "status"}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}[(api.body) = "{{.JavaName}}"]; //{{.ColumnComment}}
{{- else if isContain .JavaName "Status"}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}[(api.body) = "{{.JavaName}}"]; //{{.ColumnComment}}
{{- else}}
{{- end}}

{{- end}}
}

message Update{{.JavaName}}StatusResp {
  string msg = 1;
  api.Code code = 2;
}

// 查询{{.Comment}}详情请求参数
message Query{{.JavaName}}DetailReq {
{{- range .TableColumn}}
{{- if eq .ColumnKey "PRI"}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}[(api.body) = "{{.JavaName}}"]; //{{.ColumnComment}}
{{- end}}
{{- end}}
}

message Query{{.JavaName}}DetailResp {
  string msg = 1;
  api.Code code = 2;
  int64 Total = 3;
  Query{{.JavaName}}DetailData data = 4;
}

message Query{{.JavaName}}DetailData {
{{- range .TableColumn}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{- end}}
}

// 分页查询{{.Comment}}列表请求参数
message Query{{.JavaName}}ListReq {
{{- $how_long :=(len .TableColumn)}}
{{- range .TableColumn}}
{{- if isContain .JavaName "create"}}
{{- else if isContain .JavaName "update"}}
{{- else if isContain .JavaName "remark"}}
{{- else if isContain .JavaName "sort"}}
{{- else if isContain .JavaName "Sort"}}
{{- else if eq .ColumnKey "PRI"}}
{{- else}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}[(api.body) = "{{.JavaName}}"]; //{{.ColumnComment}}
{{- end}}
{{- end}}
  int64 page_num = 1[(api.body) = "pageNo"]; //第几页
  int64 page_size = {{$how_long}}[(api.body) = "pageSize"]; //每页的数量
}


message Query{{.JavaName}}ListResp {
  string msg = 1;
  api.Code code = 2;
  int64 Total = 3;
  repeated Query{{.JavaName}}ListData data = 4;
}

message Query{{.JavaName}}ListData {
{{- range .TableColumn}}
  {{.ProtoType}} {{.GoName}} = {{.Sort}}; //{{.ColumnComment}}
{{- end}}
}

// {{.Comment}}服务
service {{.JavaName}}Handler {

  // 添加{{.Comment}}
  rpc Add{{.JavaName}}(Add{{.JavaName}}Req) returns(Add{{.JavaName}}Resp) {
    option (api.post) = "/api/demo/{{.LowerJavaName}}/add{{.JavaName}}";
  }
  // 删除{{.Comment}}
  rpc Delete{{.JavaName}}(Delete{{.JavaName}}Req) returns(Delete{{.JavaName}}Resp) {
    option (api.post) = "/api/demo/{{.LowerJavaName}}/delete{{.JavaName}}";
  }
  // 更新{{.Comment}}
  rpc Update{{.JavaName}}(Update{{.JavaName}}Req) returns(Update{{.JavaName}}Resp) {
    option (api.post) = "/api/demo/{{.LowerJavaName}}/update{{.JavaName}}";
  }
  // 更新{{.Comment}}状态
  rpc Update{{.JavaName}}Status(Update{{.JavaName}}StatusReq) returns(Update{{.JavaName}}StatusResp) {
    option (api.post) = "/api/demo/{{.LowerJavaName}}/update{{.JavaName}}Status";
  }
  // 查询{{.Comment}}详情
  rpc Query{{.JavaName}}Detail(Query{{.JavaName}}DetailReq) returns(Query{{.JavaName}}DetailResp) {
    option (api.post) = "/api/demo/{{.LowerJavaName}}/query{{.JavaName}}Detail";
  }
  // 分页查询{{.Comment}}列表
  rpc Query{{.JavaName}}List(Query{{.JavaName}}ListReq) returns(Query{{.JavaName}}ListResp) {
    option (api.post) = "/api/demo/{{.LowerJavaName}}/query{{.JavaName}}List";
  }

}


