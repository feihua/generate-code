import React, {useEffect} from 'react';
import {Form, Input, InputNumber, Modal, Radio} from 'antd';
import type { {{.JavaName}}ListItem} from '../data.d';

export interface CreateFormProps {
  onCancel: () => void;
  onSubmit: (values: {{.JavaName}}ListItem) => void;
  createModalVisible: boolean;
}

const FormItem = Form.Item;

const formLayout = {
  labelCol: {span: 7},
  wrapperCol: {span: 13},
};

const CreateForm: React.FC<CreateFormProps> = (props) => {
  const [form] = Form.useForm();

  const {
    onSubmit,
    onCancel,
    createModalVisible,
  } = props;

  useEffect(() => {
    if (form && !createModalVisible) {
      form.resetFields();
    }
  }, [props.createModalVisible]);


  const handleSubmit = () => {
    if (!form) return;
    form.submit();
  };

  const handleFinish = (values: {{.JavaName}}ListItem) => {
    if (onSubmit) {
      onSubmit(values);
    }
  };

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
         {{else if isContain .JavaName "remark"}}
            <Input.TextArea rows={2} placeholder={'请输入备注'}/>
         {{else}}
            <Input id="create-{{.JavaName}}" placeholder={'请输入{{.ColumnComment}}!'}/>
         {{end}}</FormItem>{{end}}
      </>
    );
  };


  const modalFooter = {okText: '保存', onOk: handleSubmit, onCancel};

  return (
    <Modal
      forceRender
      destroyOnClose
      title="新增"
      open={createModalVisible}
      {...modalFooter}
    >
      <Form
        {...formLayout}
        form={form}
        onFinish={handleFinish}
      >
        {renderContent()}
      </Form>
    </Modal>
  );
};

export default CreateForm;
