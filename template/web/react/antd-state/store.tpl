import { create } from 'zustand';
import { query{{.JavaName}}List1 } from '../service.ts';
import { {{.JavaName}}ListParam, {{.JavaName}}Vo } from '../data';

interface {{.JavaName}}State {
  listParam: {{.JavaName}}ListParam;
  {{.LowerJavaName}}List: {{.JavaName}}Vo[];
  total: number;
  query{{.JavaName}}List: (params: {{.JavaName}}ListParam) => void;
}

const use{{.JavaName}}Store = create<{{.JavaName}}State>()((set) => ({
  listParam: {
    current: 1,
    pageSize: 10,
  },
  total: 10,
  {{.LowerJavaName}}List: [],
  query{{.JavaName}}List: (params: {{.JavaName}}ListParam) => {
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