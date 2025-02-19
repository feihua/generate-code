import {Component, inject, OnInit} from '@angular/core';
import {NzTableComponent, NzTableModule, NzTableQueryParams} from "ng-zorro-antd/table";
import {NzDividerComponent} from "ng-zorro-antd/divider";
import {NzButtonComponent} from "ng-zorro-antd/button";
import {
  FormControl,
  FormGroup,
  FormsModule,
  NonNullableFormBuilder,
  ReactiveFormsModule,
  Validators
} from "@angular/forms";
import {NzFormDirective, NzFormLabelComponent, NzFormModule} from "ng-zorro-antd/form";
import {NzColDirective, NzRowDirective} from "ng-zorro-antd/grid";
import {NzInputDirective, NzInputGroupComponent, NzTextareaCountComponent} from "ng-zorro-antd/input";
import {NzIconDirective} from "ng-zorro-antd/icon";
import {NzSpaceComponent, NzSpaceItemDirective} from "ng-zorro-antd/space";
import {NzOptionComponent, NzSelectComponent} from "ng-zorro-antd/select";
import {NzModalComponent, NzModalModule, NzModalService} from "ng-zorro-antd/modal";
import {NzDescriptionsComponent, NzDescriptionsItemComponent} from "ng-zorro-antd/descriptions";
import { {{.JavaName}}Service} from "./{{.LowerJavaName}}.service";
import {AsyncPipe, NgIf} from "@angular/common";
import { {{.JavaName}}RecordRes} from "./data";
import {NzInputNumberComponent} from "ng-zorro-antd/input-number";
import {NzRadioComponent, NzRadioGroupComponent, NzRadioModule} from "ng-zorro-antd/radio";
import {NzMessageService} from "ng-zorro-antd/message";
import {NzSwitchComponent} from "ng-zorro-antd/switch";


@Component({
  selector: 'app-{{.LowerJavaName}}',
  standalone: true,
  imports: [
    NzTableComponent,
    NzDividerComponent,
    NzTableModule,
    NzButtonComponent,
    NzFormDirective,
    ReactiveFormsModule,
    NzRowDirective,
    NzColDirective,
    NzInputDirective,
    NzFormLabelComponent,
    NzIconDirective,
    NzFormModule,
    NzSpaceComponent,
    NzSpaceItemDirective,
    NzInputGroupComponent,
    NzSelectComponent,
    NzOptionComponent,
    NzModalComponent,
    NzModalModule,
    NzTextareaCountComponent,
    NzDescriptionsComponent,
    NzDescriptionsItemComponent,
    NgIf,
    AsyncPipe,
    NzInputNumberComponent,
    NzRadioGroupComponent,
    NzRadioComponent,
    NzRadioModule,
    NzSwitchComponent,
    FormsModule
  ],
  templateUrl: './{{.LowerJavaName}}.component.html',
  styleUrl: '{{.LowerJavaName}}.component.css'
})
export class {{.JavaName}}Component implements OnInit {
  private fb = inject(NonNullableFormBuilder);
  private modal = inject(NzModalService);
  private {{.LowerJavaName}}Service = inject({{.JavaName}}Service);
  private message = inject(NzMessageService);

  // 分页相关参数
  total = 1;
  pageSize = 10;
  pageIndex = 1;
  listData!: {{.JavaName}}RecordRes[];
  detailData!: {{.JavaName}}RecordRes;

  isAddVisible = false;
  isAddOkLoading = false;

  isUpdateVisible = false;
  isUpdateOkLoading = false;

  isDetailVisible = false;

  searchForm: FormGroup<{
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else if isContain .JavaName "id"}}
  {{- else if isContain .JavaName "sort"}}
  {{- else if isContain .JavaName "Sort"}}
  {{- else if isContain .JavaName "remark"}}
  {{- else}}
    {{.JavaName}}: FormControl<{{.TsType}}>,//{{.ColumnComment}}
  {{- end}}
  {{- end}}
  }> = this.fb.group({
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else if isContain .JavaName "id"}}
  {{- else if isContain .JavaName "sort"}}
  {{- else if isContain .JavaName "Sort"}}
  {{- else if isContain .JavaName "remark"}}
  {{- else}}
    {{.JavaName}}: [{{if eq .TsType `string`}}''{{else}}0{{end}}],
  {{- end}}
  {{- end}}
  });

  submitSearchForm(): void {
    console.log('submit', this.searchForm.value);
    this.pageIndex = 1;
    this.pageSize = 10;
    this.query{{.JavaName}}List();

  }

  resetSearchForm(): void {
    this.searchForm.reset();
  }

  // 新增相关参数
  addForm: FormGroup<{
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else if isContain .JavaName "id"}}
  {{- else}}
    {{.JavaName}}: FormControl<{{.TsType}}>,//{{.ColumnComment}}
  {{- end}}
  {{- end}}
  }> = this.fb.group({
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else if isContain .JavaName "id"}}
  {{- else}}
    [{{if eq .TsType `string`}}
        {{.JavaName}}: ['', [Validators.required]],//{{.ColumnComment}}
      {{else}}
        {{.JavaName}}: [0, [Validators.required]],//{{.ColumnComment}}
    {{end}}
  {{- end}}
  {{- end}}
  });

  showAddModal(): void {
    this.isAddVisible = true;
  }

  handleAddOk(): void {
    this.isAddOkLoading = true;
    console.log('handleAddOk submit', this.addForm.value);
    const addRecord = this.addForm.value
    this.{{.LowerJavaName}}Service.add{{.JavaName}}({
      {{- range .TableColumn}}
      {{- if isContain .JavaName "create"}}
      {{- else if isContain .JavaName "update"}}
      {{- else if isContain .JavaName "id"}}
      {{- else}}
      {{.JavaName}}: addRecord.{{.JavaName}} as {{if eq .TsType `string`}}string{{else}}number{{end}},
      {{- end}}
      {{- end}}
    }).subscribe(res => {
      this.message.create(res.code == 0 ? 'success' : 'error', res.message);
      this.isAddOkLoading = false;
      if (res.code == 0) {
        this.isAddVisible = false;
        this.query{{.JavaName}}List();

      }
    })
  }

  handleAddCancel(): void {
    this.addForm.reset();
    this.isAddVisible = false;
  }

  updateForm: FormGroup<{
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else}}
    {{.JavaName}}: FormControl<{{.TsType}}>,//{{.ColumnComment}}
  {{- end}}
  {{- end}}
  }> = this.fb.group({
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else}}
    [{{if eq .TsType `string`}}
    {{.JavaName}}: ['', [Validators.required]],//{{.ColumnComment}}
        {{else}}
    {{.JavaName}}: [0, [Validators.required]],//{{.ColumnComment}}
      {{end}}
  {{- end}}
  {{- end}}
  });


  showUpdateModal(record: {{.JavaName}}RecordRes): void {
    this.isUpdateVisible = true;
    this.{{.LowerJavaName}}Service.query{{.JavaName}}Detail(record.id).subscribe(res => {
      this.detailData = res.data
      const updateRecord = res.data
      this.updateForm = this.fb.group({
        {{range .TableColumn}}    {{.JavaName}}: [updateRecord.{{.JavaName}}, [Validators.required]],
        {{end}}
      })
    })
  }

  handleUpdateOk(): void {
    this.isUpdateOkLoading = true;
    console.log('handleUpdateOk submit', this.updateForm.value);
    const updateRecord = this.updateForm.value
    this.{{.LowerJavaName}}Service.update{{.JavaName}}({
      {{- range .TableColumn}}
      {{- if isContain .JavaName "create"}}
      {{- else if isContain .JavaName "update"}}
      {{- else}}
      {{.JavaName}}: updateRecord.{{.JavaName}} as {{if eq .TsType `string`}}string{{else}}number{{end}},
      {{- end}}
      {{- end}}
    }).subscribe(res => {
      this.message.create(res.code == 0 ? 'success' : 'error', res.message);
      this.isUpdateOkLoading = false;
      if (res.code == 0) {
        this.isUpdateVisible = false;
        this.query{{.JavaName}}List();
      }
    })
  }

  handleUpdateCancel(): void {
    this.updateForm.reset();
    this.isUpdateVisible = false;
  }

  showDetailModal(record: {{.JavaName}}RecordRes): void {
    this.isDetailVisible = true;
    this.{{.LowerJavaName}}Service.query{{.JavaName}}Detail(record.id).subscribe(res => {
      this.detailData = res.data
    })
  }

  handleDetailCancel(): void {
    this.isDetailVisible = false;
  }

  showDeleteConfirm(recordIds: number[]): void {
    this.modal.confirm({
      nzTitle: '你确定要删除吗?',
      // nzContent: '<b style="color: red;">删除后数据不能恢复!</b>',
      nzOkText: '是',
      nzOkType: 'primary',
      nzOkDanger: true,
      nzOnOk: () => {
        this.{{.LowerJavaName}}Service.delete{{.JavaName}}({
          ids: recordIds
        }).subscribe(res => {
          this.message.create(res.code == 0 ? 'success' : 'error', res.message);
          if (res.code == 0) {
            this.query{{.JavaName}}List();
          }
        })
      },
      nzCancelText: '否',
      nzOnCancel: () => console.log('Cancel')
    });
  }

  // 批量选择
  checked = false;
  indeterminate = false;
  listOfCurrentPageData: readonly {{.JavaName}}RecordRes[] = [];
  setOfCheckedId = new Set<number>();

  updateCheckedSet(id: number, checked: boolean): void {
    if (checked) {
      this.setOfCheckedId.add(id);
    } else {
      this.setOfCheckedId.delete(id);
    }
  }

  onCurrentPageDataChange(listOfCurrentPageData: readonly {{.JavaName}}RecordRes[]): void {
    this.listOfCurrentPageData = listOfCurrentPageData;
    this.refreshCheckedStatus();
  }

  refreshCheckedStatus(): void {
    const listOfEnabledData = this.listOfCurrentPageData;
    this.checked = listOfEnabledData.every(({id}) => this.setOfCheckedId.has(id));
    this.indeterminate = listOfEnabledData.some(({id}) => this.setOfCheckedId.has(id)) && !this.checked;
  }

  onItemChecked(id: number, checked: boolean): void {
    this.updateCheckedSet(id, checked);
    this.refreshCheckedStatus();
  }

  onAllChecked(checked: boolean): void {
    this.listOfCurrentPageData.forEach(({id}) => this.updateCheckedSet(id, checked));
    this.refreshCheckedStatus();
  }

  batchDelete(): void {
    this.showDeleteConfirm(Array.from(this.setOfCheckedId))
  }

  // 分页查询
  onQueryParamsChange(params: NzTableQueryParams): void {
    const {pageSize, pageIndex} = params;
    this.pageIndex = pageIndex
    this.pageSize = pageSize
    this.query{{.JavaName}}List();
  }

  clickSwitch(res: {{.JavaName}}RecordRes): void {
    console.log('clickSwitch', res);
    this.{{.LowerJavaName}}Service.update{{.JavaName}}Status({
      ids: [res.id],
      status: 0,
    }).subscribe(res => {
      this.message.create(res.code == 0 ? 'success' : 'error', res.message);
      if (res.code == 0) {
        this.query{{.JavaName}}List();
      }
    })

  }


  private query{{.JavaName}}List() {
    const { {{- range .TableColumn}}
    {{- if isContain .JavaName "create"}}
    {{- else if isContain .JavaName "update"}}
    {{- else if isContain .JavaName "Sort"}}
    {{- else if isContain .JavaName "sort"}}
    {{- else if isContain .JavaName "remark"}}
    {{- else if isContain .JavaName "id"}}
    {{- else}}
    {{.JavaName}},{{- end}}{{- end}} } = this.searchForm.value;
    this.{{.LowerJavaName}}Service.query{{.JavaName}}List({
      current: this.pageIndex,
      pageSize: this.pageSize,
      {{- range .TableColumn}}
      {{- if isContain .JavaName "create"}}
      {{- else if isContain .JavaName "update"}}
      {{- else if isContain .JavaName "Sort"}}
      {{- else if isContain .JavaName "sort"}}
      {{- else if isContain .JavaName "remark"}}
      {{- else if isContain .JavaName "id"}}
      {{- else}}
      {{.JavaName}},
      {{- end}}
      {{- end}}
    }).subscribe(res => {
      this.listData = res.data
      this.total = res.total
    })
  }

  ngOnInit(): void {
  }


}
