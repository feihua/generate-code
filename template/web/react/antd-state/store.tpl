import { create } from 'zustand';
import { query{{.JavaName}}List1 } from '../service.ts';
import { List{{.JavaName}}Param, {{.JavaName}}Vo } from '../data';

interface {{.JavaName}}State {
  listParam: List{{.JavaName}}Param;
  {{.LowerJavaName}}List: {{.JavaName}}Vo[];
  total: number;
  query{{.JavaName}}List: (params: List{{.JavaName}}Param) => void;
}

const use{{.JavaName}}Store = create<{{.JavaName}}State>()((set) => ({
  listParam: {
    current: 1,
    pageSize: 10,
  },
  total: 10,
  {{.LowerJavaName}}List: [],
  query{{.JavaName}}List: (params: List{{.JavaName}}Param) => {
    set({ listParam: params });
    query{{.JavaName}}List1(params).then((res) => {
      set({
        {{.LowerJavaName}}List: res.data,
        total: res.total,
      });
    });
  },
}));

export default use{{.JavaName}}Store;
