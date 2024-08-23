import React, { useEffect } from 'react';
import { Form, Input, message, Modal, Radio } from 'antd';
import { query{{.JavaName}}Detail, update{{.JavaName}} } from '../service';
import use{{.JavaName}}Store from '../store/{{.LowerJavaName}}Store.ts';

interface UpdateFormProps {
  open: boolean;
  onCancel: () => void;
  id: number;
}

const UpdateForm: React.FC<UpdateFormProps> = ({ open, onCancel, id }) => {
  const [form] = Form.useForm();
  const FormItem = Form.Item;
  const { query{{.JavaName}}List, listParam } = use{{.JavaName}}Store();

  useEffect(() => {
    if (open) {
      query{{.JavaName}}Detail(id).then((res) => {
        form.setFieldsValue(res.data);
      });
    }
  }, [open]);

  const handleOk = () => {
    form
      .validateFields()
      .then(async (values) => {
        const res = await update{{.JavaName}}(values);
        if (res.code == 0) {
          message.info(res.message);
          query{{.JavaName}}List(listParam);
          form.resetFields();
          onCancel();
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
            <FormItem
              name="id"
              label="主键"
              hidden
            >
              <Input id="update-id"/>
            </FormItem>

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
    <Modal title="更新" okText="保存" onOk={handleOk} onCancel={onCancel} cancelText="取消" open={open} width="480" style={ { top: 150 } }>
      <Form labelCol={ { span: 7 } } wrapperCol={ { span: 13 } } form={form} style={ { marginTop: 30 } }>
        {renderContent()}
      </Form>
    </Modal>
  );
};

export default UpdateForm;
