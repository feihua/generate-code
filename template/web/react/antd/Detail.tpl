import React, {useEffect, useRef, useState} from 'react';
import {Card, Descriptions, Modal, Select, Tag} from 'antd';
import { {{.JavaName}}Vo} from "../data";
import {query{{.JavaName}}Detail} from "../service";

export interface DetailModalProps {
  onCancel: () => void;
  open: boolean;
  id: number;

}

const DetailModal: React.FC<DetailModalProps> = (props) => {
   const {open, id, onCancel} = props;

   const [{{.LowerJavaName}}Vo, set{{.JavaName}}Vo] = useState<{{.JavaName}}Vo>({

  });


  useEffect(() => {
    if (open) {
      query{{.JavaName}}Detail(id).then((res) => {
        set{{.JavaName}}Vo(res.data)
      });
    }
  }, [open]);

  return (
    <Modal
      forceRender
      destroyOnClose
      title="{{.Comment}}详情"
      open={open}
      footer={false}
      width={1200}
      onCancel={onCancel}
    >

      <Card type="inner" title="{{.Comment}}详情">
        <Descriptions column={2}>

        {{range .TableColumn}}    <Descriptions.Item label="{{.ColumnComment}}">
              { {{.LowerJavaName}}Vo.name}
            </Descriptions.Item>
        {{end}}

        </Descriptions>
      </Card>

    </Modal>
  );
};

export default DetailModal;
