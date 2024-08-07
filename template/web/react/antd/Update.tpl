import React, {useEffect} from 'react';
import {Form, Input, InputNumber, Modal, Radio} from 'antd';
import { {{.JavaName}}Vo} from "../data";

interface UpdateFormProps {
    open: boolean;
    onCreate: (values: {{.JavaName}}Vo) => void;
    onCancel: () => void;
    {{.LowerJavaName}}Vo: {{.JavaName}}Vo;
}

const UpdateForm: React.FC<UpdateFormProps> = ({open, onCreate, onCancel, {{.LowerJavaName}}Vo}) => {
    const [form] = Form.useForm();
    const FormItem = Form.Item;

    useEffect(() => {
        if ({{.LowerJavaName}}Vo) {
            form.setFieldsValue({{.LowerJavaName}}Vo);
        }
    }, [open]);

    const handleOk = () => {
        form.validateFields()
            .then((values) => {
                form.resetFields();
                onCreate(values);
            })
            .catch((info) => {
                console.log('Validate Failed:', info);
            });
    }

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

    const modalFooter = {title: "更新", okText: '保存', onOk: handleOk, onCancel, cancelText: '取消', open, width: 480};
    const formLayout = {labelCol: {span: 7}, wrapperCol: {span: 13}, form};

    return (
        <Modal {...modalFooter} style={ {top: 150}}>
            <Form {...formLayout} style={ {marginTop: 30}}>
                {renderContent()}
            </Form>
        </Modal>
    );
};

export default UpdateForm;