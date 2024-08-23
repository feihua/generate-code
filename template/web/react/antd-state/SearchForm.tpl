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
              <FormItem
                name="{{.JavaName}}"
                label="{{.ColumnComment}}"
              >{{if isContain .JavaName "Sort"}}
                  <InputNumber style={ {width: 255} }/>
              {{else if isContain .JavaName "sort"}}
                  <InputNumber style={ {width: 255} }/>
              {{else if isContain .JavaName "status"}}
                  <Select style={ {width: 200}}>
                      <Select.Option value="1">正常</Select.Option>
                      <Select.Option value="0">禁用</Select.Option>
                  </Select>
              {{else if isContain .JavaName "Status"}}
                 <Select style={ {width: 200}}>
                    <Select.Option value="1">正常</Select.Option>
                    <Select.Option value="0">禁用</Select.Option>
                 </Select>
             {{else if isContain .JavaName "Type"}}
                  <Select style={ {width: 200}}>
                      <Select.Option value="1">正常</Select.Option>
                      <Select.Option value="0">禁用</Select.Option>
                  </Select>
               {{else if isContain .JavaName "remark"}}
                  <Input.TextArea rows={2} placeholder={'请输入备注'}/>
               {{else}}
                  <Input id="search-{{.JavaName}}" placeholder={'请输入{{.ColumnComment}}!'}/>
               {{end}}</FormItem>{{end}}
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
