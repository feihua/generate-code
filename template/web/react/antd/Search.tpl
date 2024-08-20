import React from 'react';
import {SearchOutlined} from '@ant-design/icons';
import {Button, Form, Input, Select, Space} from 'antd';
import { {{.JavaName}}Vo} from "../data";

interface CreateFormProps {
    search: (values: {{.JavaName}}Vo) => void;
    reSet: () => void;
}

const AdvancedSearchForm: React.FC<CreateFormProps> = ({search, reSet}) => {
    const FormItem = Form.Item;
    const [form] = Form.useForm();


    const onFinish: FormProps<{{.JavaName}}Vo>['onFinish'] = (values) => {
        search(values);
    };

    const onReset = () => {
        form.resetFields();
        reSet()
    };

    const searchForm = () => {
        return (
            <>
                {{range .TableColumn}}
                <FormItem
                  name="{{.JavaName}}"
                  label="{{.ColumnComment}}"
                  rules={[{required: true, message: '请输入{{.ColumnComment}}!'}]}
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