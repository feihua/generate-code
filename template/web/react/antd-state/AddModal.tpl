import React, { useState } from 'react';
import { Button, Form, Input, message, Modal, Radio } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import { add{{.JavaName}} } from '../service.ts';
import use{{.JavaName}}Store from '../store/{{.LowerJavaName}}Store.ts';

const AddModal: React.FC = () => {
  const [form] = Form.useForm();
  const FormItem = Form.Item;
  const [open, setOpen] = useState<boolean>(false);
  const { query{{.JavaName}}List } = use{{.JavaName}}Store();

  const handleOk = () => {
    form
      .validateFields()
      .then(async (values) => {
        const res = await add{{.JavaName}}(values);
        if (res.code == 0) {
          message.info(res.message);
          query{{.JavaName}}List({ current: 1, pageSize: 10 });
          form.resetFields();
          setOpen(false);
        } else {
          message.error(res.message);
        }
      })
      .catch((info) => {
        message.error(info);
      });
  };

    const renderContent = () => {
        return (
          <>
            {{- range .TableColumn}}
            {{- if isContain .JavaName "create"}}
            {{- else if isContain .JavaName "update"}}
            {{- else if isContain .JavaName "id"}}
            {{- else if isContain .JavaName "Sort"}}
            <FormItem
              name="{{.JavaName}}"
              label="{{.ColumnComment}}"
              rules={[{required: true, message: '请输入{{.ColumnComment}}!'}]}
            >
                <InputNumber style={ {width: 255} }/>
             </FormItem>
            {{- else if isContain .JavaName "sort"}}
            <FormItem
              name="{{.JavaName}}"
              label="{{.ColumnComment}}"
              rules={[{required: true, message: '请输入{{.ColumnComment}}!'}]}
            >
                <InputNumber style={ {width: 255} }/>
             </FormItem>
            {{- else if isContain .JavaName "status"}}
            <FormItem
              name="{{.JavaName}}"
              label="{{.ColumnComment}}"
              rules={[{required: true, message: '请输入{{.ColumnComment}}!'}]}
            >
                  <Radio.Group>
                    <Radio value={0}>禁用</Radio>
                    <Radio value={1}>正常</Radio>
                  </Radio.Group>
             </FormItem>
            {{- else if isContain .JavaName "Status"}}
            <FormItem
              name="{{.JavaName}}"
              label="{{.ColumnComment}}"
              rules={[{required: true, message: '请输入{{.ColumnComment}}!'}]}
            >
                  <Radio.Group>
                    <Radio value={0}>禁用</Radio>
                    <Radio value={1}>正常</Radio>
                  </Radio.Group>
             </FormItem>
           {{- else if isContain .JavaName "Type"}}
            <FormItem
              name="{{.JavaName}}"
              label="{{.ColumnComment}}"
              rules={[{required: true, message: '请输入{{.ColumnComment}}!'}]}
            >
                    <Radio.Group>
                      <Radio value={0}>禁用</Radio>
                      <Radio value={1}>正常</Radio>
                    </Radio.Group>
             </FormItem>
             {{- else if isContain .JavaName "remark"}}
            <FormItem
              name="{{.JavaName}}"
              label="{{.ColumnComment}}"
              rules={[{required: true, message: '请输入{{.ColumnComment}}!'}]}
            >
                <Input.TextArea rows={2} placeholder={'请输入备注'}/>
             </FormItem>
             {{- else}}
            <FormItem
              name="{{.JavaName}}"
              label="{{.ColumnComment}}"
              rules={[{required: true, message: '请输入{{.ColumnComment}}!'}]}
            >
                <Input id="create-{{.JavaName}}" placeholder={'请输入{{.ColumnComment}}!'}/>
             </FormItem>{{- end}}{{- end}}
          </>
        );
    };

  return (
    <>
      <Button type="primary" icon={<PlusOutlined />} onClick={() => setOpen(true)}>
        新建
      </Button>
      <Modal title="新建" okText="保存" onOk={handleOk} onCancel={() => setOpen(false)} cancelText="取消" open={open} width={480} style={ { top: 150 } }>
        <Form labelCol={ { span: 7 } } wrapperCol={ { span: 13 } } form={form} initialValues={ { sort: 1, status_id: 1 } } style={ { marginTop: 30 } }>
          {renderContent()}
        </Form>
      </Modal>
    </>
  );
};

export default AddModal;
