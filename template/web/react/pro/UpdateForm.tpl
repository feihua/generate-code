import React, {useEffect} from 'react';
import {Form, Input, InputNumber, Modal, Radio} from 'antd';
import type { {{.JavaName}}ListItem} from '../data.d';

export interface UpdateFormProps {
  onCancel: () => void;
  onSubmit: (values: {{.JavaName}}ListItem) => void;
  updateModalVisible: boolean;
  currentData: Partial<{{.JavaName}}ListItem>;
}

const FormItem = Form.Item;

const formLayout = {
  labelCol: {span: 7},
  wrapperCol: {span: 13},
};

const UpdateForm: React.FC<UpdateFormProps> = (props) => {
  const [form] = Form.useForm();

  const {
    onSubmit,
    onCancel,
    updateModalVisible,
    currentData,
  } = props;

  useEffect(() => {
    if (form && !updateModalVisible) {
      form.resetFields();
    }
  }, [props.updateModalVisible]);

  useEffect(() => {
    if (currentData) {
      form.setFieldsValue({
        ...currentData,
      });
    }
  }, [props.currentData]);

  const handleSubmit = () => {
    if (!form) return;
    form.submit();
  };

  const handleFinish = (values: { [key: string]: any }) => {
    if (onSubmit) {
      onSubmit(values as {{.JavaName}}ListItem);
    }
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
      title="编辑"
      open={updateModalVisible}
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

export default UpdateForm;
