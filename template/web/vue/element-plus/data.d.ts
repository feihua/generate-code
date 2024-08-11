export interface ListParam {
    current?: number;
    pageSize?: number;
    mobile?: string;
    status_id?: string;
}

export interface SearchParam {
    mobile?: string;
    status_id?: string;
}

export interface AddParam {
    mobile: string;
    real_name: string;
    sort: number;
    status_id: number;
    remark: string;
}

export interface UpdateParam {
    id: number;
    mobile: string;
    real_name: string;
    remark: string;
    sort: number;
    status_id: number;
}

export interface RecordVo {
    create_time: string;
    id: number;
    mobile: string;
    real_name: string;
    remark: string;
    sort: number;
    status_id: number;
    update_time: string;
}