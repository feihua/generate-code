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

  add{{.JavaName}}(param: Add{{.JavaName}}Param): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{.LowerJavaName}}/add{{.JavaName}}', param);
  }

  delete{{.JavaName}}(param: Delete{{.JavaName}}Param): Observable<IResponse<number>> {
    return this.http.get<IResponse<number>>('/api/demo/{{.LowerJavaName}}/delete{{.JavaName}}?ids=[' + param.ids + ']');
  }

  update{{.JavaName}}(param: Update{{.JavaName}}Param): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}', param);
  }

  update{{.JavaName}}Status(param: Update{{.JavaName}}StatusParam): Observable<IResponse<number>> {
    return this.http.post<IResponse<number>>('/api/demo/{{.LowerJavaName}}/update{{.JavaName}}Status', param);
  }

  query{{.JavaName}}Detail(id: number): Observable<IResponse<{{.JavaName}}RecordRes>> {
    return this.http.get<IResponse<{{.JavaName}}RecordRes>>('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}Detail?id=' + id, {});
  }

  query{{.JavaName}}List(params: QueryList{{.JavaName}}Param): Observable<IResponse<{{.JavaName}}RecordRes[]>> {
    return this.http.get<IResponse<{{.JavaName}}RecordRes[]>>('/api/demo/{{.LowerJavaName}}/query{{.JavaName}}List', {params: {...params}});
  }

}
