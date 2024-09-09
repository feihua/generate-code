import React from 'react';
import { SearchOutlined } from '@ant-design/icons';
import { Button, Form, FormProps, Input, Select, Space } from 'antd';
import { {{.JavaName}}ListParam } from '../data';
import use{{.JavaName}}Store from '../store/{{.LowerJavaName}}Store.ts';

const AdvancedSearchForm: React.FC = () => {
  const FormItem = Form.Item;
  const [form] = Form.useForm();
  const { query{{.JavaName}}List } = use{{.JavaName}}Store();
  const onFinish: FormProps<{{.JavaName}}ListParam>['onFinish'] = (values) => {
    query{{.JavaName}}List({ ...values, current: 1, pageSize: 10 });
  };

  const onReset = () => {
    form.resetFields();
    query{{.JavaName}}List({ current: 1, pageSize: 10 });
  };

  const searchForm = () => {
      return (
          <>
              {{range .TableColumn}}
              {{- if isContain .JavaName "create"}}
              {{- else if isContain .JavaName "update"}}
              {{- else if isContain .JavaName "id"}}
              {{- else if isContain .JavaName "remark"}}
              {{- else if isContain .JavaName "Sort"}}
              {{- else if isContain .JavaName "sort"}}
              {{- else if isContain .JavaName "status"}}
              <FormItem
                name="{{.JavaName}}"
                label="{{.ColumnComment}}"
              >
                  <Select style={ {width: 200}}>
                      <Select.Option value="1">正常</Select.Option>
                      <Select.Option value="0">禁用</Select.Option>
                  </Select>
               </FormItem>
              {{- else if isContain .JavaName "Status"}}
              <FormItem
                name="{{.JavaName}}"
                label="{{.ColumnComment}}"
              >
                 <Select style={ {width: 200}}>
                    <Select.Option value="1">正常</Select.Option>
                    <Select.Option value="0">禁用</Select.Option>
                 </Select>
               </FormItem>
             {{- else if isContain .JavaName "Type"}}
              <FormItem
                name="{{.JavaName}}"
                label="{{.ColumnComment}}"
              >
                  <Select style={ {width: 200}}>
                      <Select.Option value="1">正常</Select.Option>
                      <Select.Option value="0">禁用</Select.Option>
                  </Select>
               </FormItem>
               {{- else if isContain .JavaName "remark"}}
              <FormItem
                name="{{.JavaName}}"
                label="{{.ColumnComment}}"
              >
                  <Input.TextArea rows={2} placeholder={'请输入备注'}/>
               </FormItem>
               {{- else}}
              <FormItem
                name="{{.JavaName}}"
                label="{{.ColumnComment}}"
              >
                  <Input id="search-{{.JavaName}}" placeholder={'请输入{{.ColumnComment}}!'}/>
               </FormItem>{{- end}}{{- end}}
              <FormItem>
                  <Space>
                      <Button type="primary" htmlType="submit" icon={<SearchOutlined/>} style={ {width: 120}}>
                          查询
                      </Button>
                      <Button htmlType="button" onClick={onReset} style={ {width: 100}}>
                          重置
                      </Button>
                  </Space>
              </FormItem>
          </>
      )
  }
  return (
    <Form form={form} name="horizontal_login" layout="inline" onFinish={onFinish}>
      {searchForm()}
    </Form>
  );
};

export default AdvancedSearchForm;
