import { ORDER_CODE_STATUS } from '../api/orderStatusConfig'

export class TabItem {
  index:number;
  id: number;
  name: string | Resource;

  constructor(index: number, id: number, name: string | Resource) {
    this.index = index;
    this.id = id;
    this.name = name;
  }
}

/**
 * 默认 Tab：全部
 */
const TabItemData: TabItem[] = [
  new TabItem(0, 0, '全部'),
];

/**
 * 初始化 Tab 数据
 * 先添加“全部”，再根据 ORDER_CODE_STATUS 追加
 */
export function initTabData(): TabItem[] {
  let tabDataArray: TabItem[] = [];

  // 添加固定项
  TabItemData.forEach((item: TabItem,index:number) => {
    tabDataArray.push(new TabItem(index,item.id, item.name));
  });

  // 根据 ORDER_CODE_STATUS 动态生成
  const entries = Object.entries(ORDER_CODE_STATUS);
  for (let i = 0; i < entries.length; i++) {
    const pair = entries[i];
    const key = Number(pair[0]);
    const value = pair[1];
    tabDataArray.push(new TabItem(i+1, key, value));
  }

  return tabDataArray;
}
