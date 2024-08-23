import React, { useEffect, useState } from 'react';
import type { MenuProps } from 'antd';
import { Button, Divider, Dropdown, message, Modal, Space, Switch, Table } from 'antd';
import type { ColumnsType } from 'antd/es/table';
import { DeleteOutlined, DownOutlined, EditOutlined, ExclamationCircleOutlined, PlusOutlined } from '@ant-design/icons';
import { {{.JavaName}}Vo } from './data';
import AddModal from './components/AddModal';
import UpdateModal from './components/UpdateModal';
import AdvancedSearchForm from './components/SearchForm';
import DetailModal from './components/DetailModal';
import { remove{{.JavaName}}, update{{.JavaName}}Status } from './service';
import use{{.JavaName}}Store from './store/{{.LowerJavaName}}Store.ts';

const {{.JavaName}}: React.FC = () => {
  const { query{{.JavaName}}List, {{.LowerJavaName}}List, listParam, total } = use{{.JavaName}}Store();
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);

  const [isShowEditModal, setShowEditModal] = useState<boolean>(false);
  const [isShowDetailModal, setShowDetailModal] = useState<boolean>(false);
  const [current{{.JavaName}}, setCurrent{{.JavaName}}] = useState<{{.JavaName}}Vo>({
    channelValue: '',
    createTime: '',
    description: '',
    id: 0,
    methodValue: '',
    outTradeNo: '',
    payDate: '',
    payStatus: 0,
    payTime: '',
    status: 0,
    totalFee: 0,
    tradeName: '',
    updateTime: '',
  });

  const columns: ColumnsType<{{.JavaName}}Vo> = [
    {
      title: '渠道编码',
      dataIndex: 'channelValue',
    },
    {
      title: '创建时间',
      dataIndex: 'createTime',
    },
    {
      title: '订单描述',
      dataIndex: 'description',
    },
    {
      title: '编号',
      dataIndex: 'id',
    },
    {
      title: '支付方式编码',
      dataIndex: 'methodValue',
    },
    {
      title: '(商户)订单流水号',
      dataIndex: 'outTradeNo',
    },
    {
      title: '支付日期',
      dataIndex: 'payDate',
    },
    {
      title: '0:待支付，1：支付成功，2：支付失败，3：退款成功，4：正在退款中，5：未知',
      dataIndex: 'payStatus',

      render: (_, entity) => {
        return (
          <Switch
            checked={entity.payStatus == 1}
            onChange={(flag) => {
              showStatusConfirm([entity.id], flag ? 1 : 0);
            } }
          />
        );
      },
    },
    {
      title: '支付时间',
      dataIndex: 'payTime',
    },
    {
      title: '0：未删除，1：已删除',
      dataIndex: 'status',
      render: (_, entity) => {
        return (
          <Switch
            checked={entity.status == 1}
            onChange={(flag) => {
              showStatusConfirm([entity.id], flag ? 1 : 0);
            } }
          />
        );
      },
    },

    {
      title: '订单金额(单位：分)',
      dataIndex: 'totalFee',
    },
    {
      title: '商品名称',
      dataIndex: 'tradeName',
      render: (text: string) => <a>{text}</a>,
    },

    {
      title: '修改时间',
      dataIndex: 'updateTime',
    },

    {
      title: '操作',
      key: 'action',
      width: 280,
      render: (_, record) => (
        <div>
          <Button type="link" size={'small'} icon={<EditOutlined />} onClick={() => showDetailModal(record)}>
            详情
          </Button>
          <Button type="link" size={'small'} icon={<EditOutlined />} onClick={() => showEditModal(record)}>
            编辑
          </Button>
          <Button type="link" size={'small'} danger icon={<DeleteOutlined />} onClick={() => showDeleteConfirm(record)}>
            删除
          </Button>
          <Dropdown menu={ { items } }>
            <a
              onMouseEnter={(e) => {
                setCurrent{{.JavaName}}(record);
                return e.preventDefault();
              } }>
              <Space>
                更多
                <DownOutlined />
              </Space>
            </a>
          </Dropdown>
        </div>
      ),
    },
  ];

  const items: MenuProps['items'] = [
    {
      key: '1',
      label: (
        <a
          key="1"
          onClick={() => {
            //handleMoreModalVisible(true);
          } }>
          分配角色
        </a>
      ),
      icon: <PlusOutlined />,
    },
  ];

  const showStatusConfirm = (ids: number[], status: number) => {
    Modal.confirm({
      title: `确定${status == 1 ? '启用' : '禁用'}吗？`,
      icon: <ExclamationCircleOutlined />,
      async onOk() {
        await handleStatus(ids, status);
      },
      onCancel() {},
    });
  };
  const handleStatus = async (ids: number[], status: number) => {
    const hide = message.loading('正在更新状态');
    if (ids.length == 0) {
      hide();
      return true;
    }
    try {
      await update{{.JavaName}}Status({ ids, {{.LowerJavaName}}Status: status });
      hide();
      message.success('更新状态成功');
      query{{.JavaName}}List(listParam);
      return true;
    } catch (error) {
      hide();
      return false;
    }
  };

  const showEditModal = (param: {{.JavaName}}Vo) => {
    setCurrent{{.JavaName}}(param);
    setShowEditModal(true);
  };

  const showDetailModal = (param: {{.JavaName}}Vo) => {
    setCurrent{{.JavaName}}(param);
    setShowDetailModal(true);
  };

  //删除单条数据
  const showDeleteConfirm = (param: {{.JavaName}}Vo) => {
    Modal.confirm({
      content: `确定删除${param.id}吗?`,
      async onOk() {
        await handleRemove([param.id]);
      },
      onCancel() {
        console.log('Cancel');
      },
    });
  };

  //批量删除
  const handleRemove = async (ids: number[]) => {
    const res = await remove{{.JavaName}}(ids);
    if (res.code == 0) {
      message.info(res.message);
      query{{.JavaName}}List(listParam);
    } else {
      message.error(res.message);
    }
  };

  useEffect(() => {
    query{{.JavaName}}List({
      current: 1,
      pageSize: 10,
    });
  }, []);

  const paginationProps = {
    defaultCurrent: 1,
    defaultPageSize: 10,
    current: listParam.current, //当前页码
    pageSize: listParam.pageSize, // 每页数据条数
    pageSizeOptions: [10, 20, 30, 40, 50],
    showQuickJumper: true,
    showTotal: (total: number) => <span>总共{total}条</span>,
    total: total,
    onChange: (current: number, pageSize: number) => {
      query{{.JavaName}}List({ current, pageSize });
    }, //改变页码的函数
    onShowSizeChange: (current: number, size: number) => {
      console.log('onShowSizeChange', current, size);
    },
  };

  return (
    <div style={ { padding: 24 } }>
      <div>
        <Space size={10}>
          <AddModal />
          <Button
            style={ { float: 'right' } }
            danger
            disabled={selectedRowKeys.length == 0}
            icon={<DeleteOutlined />}
            type={'primary'}
            onClick={async () => {
              await handleRemove(selectedRowKeys as number[]);
              setSelectedRowKeys([]);
            } }>
            批量删除
          </Button>
          <AdvancedSearchForm />
        </Space>
      </div>

      <Divider />

      <Table
        rowSelection={ {
          onChange: (selectedRowKeys: React.Key[]) => {
            setSelectedRowKeys(selectedRowKeys);
          },
        } }
        size={'middle'}
        columns={columns}
        dataSource={ {{.LowerJavaName}}List}
        rowKey={'id'}
        pagination={paginationProps}
        // tableLayout={"fixed"}
      />

      <UpdateModal onCancel={() => setShowEditModal(false)} open={isShowEditModal} id={current{{.JavaName}}.id}></UpdateModal>
      <DetailModal onCancel={() => setShowDetailModal(false)} open={isShowDetailModal} id={current{{.JavaName}}.id}></DetailModal>
    </div>
  );
};

export default {{.JavaName}};
