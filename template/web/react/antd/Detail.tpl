import React, {useEffect, useRef, useState} from 'react';
import {Form, Input, InputNumber, message, Modal, Radio, Col, Row} from 'antd';
import { {{.JavaName}}Vo} from "../data";
import {query{{.JavaName}}Detail} from "../service";

export interface DetailModalProps {
  onCancel: () => void;
  open: boolean;
  id: number;

}

const DetailModal: React.FC<DetailModalProps> = (props) => {
   const {open, id, onCancel} = props;
   const [form] = Form.useForm();
   const FormItem = Form.Item;

  useEffect(() => {
    if (open) {
      query{{.JavaName}}Detail(id).then((res) => {
        form.setFieldsValue(res.data);
      });
    }
  }, [open]);

    const renderContent = () => {
        return (
          <>
          <Row>
            {{range .TableColumn}}
            <Col span={12}>
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
             {{end}}</FormItem></Col>{{end}}
             </Row>
          </>
        );
    };

  return (
    <Modal forceRender destroyOnClose title="订单详情" open={open} footer={false} width={1200} onCancel={onCancel}>
      <Form labelCol={ { span: 7 } } wrapperCol={ { span: 13 } } form={form} style={ { marginTop: 30 } }>
        {renderContent()}
      </Form>
    </Modal>
  );
};

export default DetailModal;
