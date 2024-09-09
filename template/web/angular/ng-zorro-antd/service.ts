import {inject, Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {
  Add{{.JavaName}}Param,
  Delete{{.JavaName}}Param,
  QueryList{{.JavaName}}Param,
  Update{{.JavaName}}Param,
  Update{{.JavaName}}StatusParam,
  {{.JavaName}}RecordRes
} from "./data";
import {Observable} from "rxjs";
import {IResponse} from "../../../app.component";

@Injectable({
  providedIn: 'root'
})
export class {{.JavaName}}Service {
  private http = inject(HttpClient);

  constructor() {
  }

  /**
   * 添加{{.Comment}}
   * @param param
   */
  add{{.JavaName}}(param: Add{{.JavaName}}Param): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{.LowerJavaName}}/add{{.JavaName}}', param);
  }

  /**
   * 删除{{.Comment}}
   * @param param
   */
  delete{{.JavaName}}(param: Delete{{.JavaName}}Param): Observable<IResponse<number>> {
    return this.http.get<IResponse<number>>('/api/demo/{{.LowerJavaName}}/delete{{.JavaName}}?ids=[' + param.ids + ']');
  }

  /**
   * 更新{{.Comment}}
   * @param param
   */
  update{{.JavaName}}(param: Update{{.JavaName}}Param): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}', param);
  }

  /**
   * 更新{{.Comment}}状态
   * @param param
   */
  update{{.JavaName}}Status(param: Update{{.JavaName}}StatusParam): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}Status', param);
  }

  /**
   * 查询{{.Comment}}详情
   * @param param
   */
  query{{.JavaName}}Detail(id: number): Observable<IResponse<{{.JavaName}}RecordRes>> {
    return this.http.get<IResponse<{{.JavaName}}RecordRes>>('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}Detail?id=' + id, {});
  }

  /**
   * 查询{{.Comment}}列表
   * @param param
   */
  query{{.JavaName}}List(param: QueryList{{.JavaName}}Param): Observable<IResponse<{{.JavaName}}RecordRes[]>> {
    return this.http.get<IResponse<{{.JavaName}}RecordRes[]>>('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}List', {params: {...params}});
  }

}
