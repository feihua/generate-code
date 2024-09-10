import React from 'react';
import {Form, Input, InputNumber, message, Modal, Radio} from 'antd';
import { {{.JavaName}}Vo} from "../data";

interface AddModalProps {
    open: boolean;
    onCreate: (values: {{.JavaName}}Vo) => void;
    onCancel: () => void;
}

const AddModal: React.FC<AddModalProps> = ({open, onCreate, onCancel}) => {
    const [form] = Form.useForm();
    const FormItem = Form.Item;

    const handleOk = () => {
        form.validateFields()
            .then((values) => {
                console.log(values)
                onCreate(values);
                form.resetFields();
            })
            .catch((info) => {
                message.error(info);
            });
    }

    const renderContent = () => {
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
                  <Radio.Group>
                    <Radio value={0}>禁用</Radio>
                    <Radio value={1}>正常</Radio>
                  </Radio.Group>
            {{else if isContain .JavaName "Status"}}
                  <Radio.Group>
                    <Radio value={0}>禁用</Radio>
                    <Radio value={1}>正常</Radio>
                  </Radio.Group>
           {{else if isContain .JavaName "Type"}}
                    <Radio.Group>
                      <Radio value={0}>禁用</Radio>
                      <Radio value={1}>正常</Radio>
                    </Radio.Group>
             {{else if isContain .JavaName "remark"}}
                <Input.TextArea rows={2} placeholder={'请输入备注'}/>
             {{else}}
                <Input id="create-{{.JavaName}}" placeholder={'请输入{{.ColumnComment}}!'}/>
             {{end}}</FormItem>{{end}}
          </>
        );
    };

  return (
    <Modal title="新建" okText="保存" onOk={handleOk} onCancel={onCancel} cancelText="取消" open={open} width={480} style={ { top: 150 } }>
      <Form labelCol={ { span: 7 } } wrapperCol={ { span: 13 } } form={form} initialValues={ { sort: 1, status_id: 1 } } style={ { marginTop: 30 } }>
        {renderContent()}
      </Form>
    </Modal>
  );
};

export default AddModal;