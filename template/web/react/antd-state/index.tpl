import React, {useEffect, useState} from 'react';
import type {MenuProps} from 'antd';
import {Button, Divider, message, Modal, Space, Table, Switch, Dropdown} from 'antd';
import type {ColumnsType} from 'antd/es/table';
import {DeleteOutlined, EditOutlined, PlusOutlined, SettingOutlined, ExclamationCircleOutlined, DownOutlined} from '@ant-design/icons';
import { {{.JavaName}}Vo} from './data';
import CreateForm from "./components/CreateForm";
import UpdateForm from "./components/UpdateForm";
import AdvancedSearchForm from "./components/SearchForm";
import DetailModal from "./components/DetailModal";
import {add{{.JavaName}}, handleResp, remove{{.JavaName}}, update{{.JavaName}}, query{{.JavaName}}List, update{{.JavaName}}Status} from "./service";


const {{.JavaName}}: React.FC = () => {
    const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
    const [isShowAddModal, setShowAddModal] = useState<boolean>(false);
    const [isShowEditModal, setShowEditModal] = useState<boolean>(false);
    const [isShowDetailModal, setShowDetailModal] = useState<boolean>(false);
    const [{{.LowerJavaName}}ListData, set{{.JavaName}}ListData] = useState<{{.JavaName}}Vo[]>([]);
    const [current{{.JavaName}}, setCurrent{{.JavaName}}] = useState<{{.JavaName}}Vo>({
        
    });
    const [currentPage, setCurrentPage] = useState<number>(1);
    const [pageSize, setPageSize] = useState<number>(10);
    const [total, setTotal] = useState<number>(10);

    const columns: ColumnsType<{{.JavaName}}Vo> = [
        {{range .TableColumn}}{{if isContain .JavaName "Name"}}
        {
          title: '{{.ColumnComment}}',
          dataIndex: '{{.JavaName}}',
          render: (text: string) => <a>{text}</a>,
        },
        {{else if isContain .JavaName "name"}}
        {
          title: '{{.ColumnComment}}',
          dataIndex: '{{.JavaName}}',
          render: (text: string) => <a>{text}</a>,
        },
        {{else if isContain .JavaName "Type"}}
        {
          title: '{{.ColumnComment}}',
          dataIndex: '{{.JavaName}}',
          render: (_, { {{.JavaName}} }) => (
              <>
                  { {{.JavaName}} === 0 ? '禁用' : '启用'}
              </>
          ),
        },
        {{else if isContain .JavaName "status"}}
        {
          title: '{{.ColumnComment}}',
          dataIndex: '{{.JavaName}}',
          render: (dom, entity) => {
            return (
              <Switch checked={entity.{{.JavaName}} == 1} onChange={(flag) => {
                showStatusConfirm( [entity.id], flag ? 1 : 0)
              }}/>
            );
        },
        },
        {{else if isContain .JavaName "Status"}}
        {
          title: '{{.ColumnComment}}',
          dataIndex: '{{.JavaName}}',

         render: (dom, entity) => {
          return (
            <Switch checked={entity.{{.JavaName}} == 1} onChange={(flag) => {
              showStatusConfirm( [entity.id], flag ? 1 : 0)
            }}/>
          );
        },
        },{{else}}
        {
          title: '{{.ColumnComment}}',
          dataIndex: '{{.JavaName}}',
        },{{end}}{{end}}

        {
            title: '操作',
            key: 'action',
            width:280,
            render: (_, record) => (
                <div>
                    <Button type="link" size={'small'} icon={<EditOutlined/>} onClick={() => showDetailModal(record)}>详情</Button>
                    <Button type="link" size={'small'} icon={<EditOutlined/>} onClick={() => showEditModal(record)}>编辑</Button>
                    <Button type="link" size={'small'} danger icon={<DeleteOutlined/>}
                            onClick={() => showDeleteConfirm(record)}>删除</Button>
                    <Dropdown menu={ {items} }>
                                <a onMouseEnter={(e) => {
                                  setCurrent{{.JavaName}}(record)
                                  return e.preventDefault()
                                } }>
                                  <Space>
                                    更多
                                    <DownOutlined/>
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
        <a key="1" onClick={() => {
            //handleMoreModalVisible(true);
          }}
        >
          分配角色
        </a>
      ),
      icon: <PlusOutlined/>,
    },
   ];

   const showStatusConfirm = (ids: number[], status: number) => {
    Modal.confirm({
      title: `确定${status == 1 ? "启用" : "禁用"}吗？`,
      icon: <ExclamationCircleOutlined/>,
      async onOk() {
        await handleStatus(ids, status)
        //actionRef.current?.clearSelected?.();
        //actionRef.current?.reload?.();
      },
      onCancel() {
      },
    });
   };
    const handleStatus = async (ids: number[], status: number) => {
      const hide = message.loading('正在更新状态');
      if (ids.length == 0) {
        hide();
        return true;
      }
      try {
        await update{{.JavaName}}Status({ ids, {{.LowerJavaName}}Status: status});
        hide();
        message.success('更新状态成功');
        return true;
      } catch (error) {
        hide();
        return false;
      }
    };

    const showModal = () => {
        setShowAddModal(true);
    };

    const handleAddOk = async (param: {{.JavaName}}Vo) => {
        if (handleResp(await add{{.JavaName}}(param))) {
            setShowAddModal(false);
            let res = await query{{.JavaName}}List({current: currentPage, pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{.JavaName}}ListData(res.data) : message.error(res.msg);
        }
    }

    const handleAddCancel = () => {
        setShowAddModal(false);
    };


    const showEditModal = (param: {{.JavaName}}Vo) => {
        setCurrent{{.JavaName}}(param)
        setShowEditModal(true);
    };

    const handleEditOk = async (param: {{.JavaName}}Vo) => {
        if (handleResp(await update{{.JavaName}}(param))) {
            setShowEditModal(false);
            let res = await query{{.JavaName}}List({
                current: currentPage, pageSize,
            })
            setTotal(res.total)
            res.code === 0 ? set{{.JavaName}}ListData(res.data) : message.error(res.msg);
        }
    };

    const handleEditCancel = () => {
        setShowEditModal(false);
    };

    const showDetailModal = (param: {{.JavaName}}Vo) => {
        setCurrent{{.JavaName}}(param)
        setShowDetailModal(true);
    };


    const handleDetailCancel = () => {
        setShowDetailModal(false);
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
            }
        })
    };

    //批量删除
    const handleRemove = async (ids: number[]) => {
        if (handleResp(await remove{{.JavaName}}(ids))) {
            let res = await query{{.JavaName}}List({current: currentPage, pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{.JavaName}}ListData(res.data) : message.error(res.msg);
        }

    };

    const handleSearchOk = async (param: {{.JavaName}}Vo) => {
        let res = await query{{.JavaName}}List({current: currentPage, ...param, pageSize})
        setTotal(res.total)
        res.code === 0 ? set{{.JavaName}}ListData(res.data) : message.error(res.msg);
    };

    const handleResetOk = async () => {
        let res = await query{{.JavaName}}List({current: currentPage, pageSize})
        setTotal(res.total)
        res.code === 0 ? set{{.JavaName}}ListData(res.data) : message.error(res.msg);
    };

    useEffect(() => {
        query{{.JavaName}}List({
            current: currentPage, pageSize
        }).then(res => {
            setTotal(res.total)
            res.code === 0 ? set{{.JavaName}}ListData(res.data) : message.error(res.msg);
        });
    }, []);


    const paginationProps = {
        defaultCurrent: 1,
        defaultPageSize: 10,
        current: currentPage, //当前页码
        pageSize, // 每页数据条数
        pageSizeOptions: [10, 20, 30, 40, 50],
        showQuickJumper: true,
        showTotal: (total: number) => (
            <span>总共{total}条</span>
        ),
        total,
        onChange: async (page: number, pageSize: number) => {
            console.log('onChange', page, pageSize)
            setCurrentPage(page)
            setPageSize(pageSize)
            let res = await query{{.JavaName}}List({current: page, pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{.JavaName}}ListData(res.data) : message.error(res.msg);

        }, //改变页码的函数
        onShowSizeChange: (current: number, size: number) => {
            console.log('onShowSizeChange', current, size)
        }
    }

    return (
        <div style={ {padding: 24}}>
            <div>
                <Space size={100}>
                    <Button type="primary" icon={<PlusOutlined/>} onClick={showModal}>新建</Button>
                    <AdvancedSearchForm search={handleSearchOk} reSet={handleResetOk}></AdvancedSearchForm>
                </Space>
            </div>

            <Divider/>

            <Table
                rowSelection={ {
                    onChange: (selectedRowKeys: React.Key[]) => {
                        setSelectedRowKeys(selectedRowKeys)
                    },
                }}
                size={"middle"}
                columns={columns}
                dataSource={ {{.LowerJavaName}}ListData}
                rowKey={'id'}
                pagination={paginationProps}
                // tableLayout={"fixed"}
            />

            <CreateForm onCancel={handleAddCancel} onCreate={handleAddOk} open={isShowAddModal}></CreateForm>
            <UpdateForm onCancel={handleEditCancel} onCreate={handleEditOk} open={isShowEditModal} {{.LowerJavaName}}Vo={current{{.JavaName}} }></UpdateForm>
            <DetailModal onCancel={handleDetailCancel}  open={isShowDetailModal} id={current{{.JavaName}}.id}></DetailModal>

            {selectedRowKeys.length > 0 &&
                <div>
                    已选择 {selectedRowKeys.length} 项
                    <Button style={ {float: "right"}} danger icon={<DeleteOutlined/>} type={'primary'}
                            onClick={async () => {
                                await handleRemove(selectedRowKeys as number[]);
                                setSelectedRowKeys([]);
                            }}
                    >
                        批量删除
                    </Button>
                </div>
            }

        </div>
    );
};

export default {{.JavaName}};
