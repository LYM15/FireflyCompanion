// 图片和状态的对应
export const ORDER_STATUS_MAP: Record<string, string> = {
  "app.media.od_10": "待支付",
  "app.media.od_20": "服务中",
  "app.media.od_30": "已完成",
  "app.media.od_40": "已取消",
};

/** 订单状态对应颜色（中文状态 -> 颜色值） */
export const ORDER_STATUS_COLOR: Record<string, string | Resource> = {
  "待支付": $r('app.color.danger_color'),
  "服务中": $r('app.color.green_6'),
  "待评价": $r('app.color.yellow_6'),
  "已完成": $r('app.color.gray_6'),
  "已取消": $r('app.color.gray_6'),
};

/** 状态值对应的状态 **/
export const ORDER_CODE_STATUS: Record<number,string> = {
  201: '待支付',
  202: '服务中',
  203: '待评价',
  204: '已完成',
  205: '已取消',
};

/**
 * 根据订单 code 获取对应颜色
 */
export function getOrderStatusColor(code: number): string | Resource {
  const statusText: string | undefined = ORDER_CODE_STATUS[code]
  if (!statusText) {
    // 如果 code 不存在，返回默认颜色
    return $r('app.color.gray_6')
  }
  return ORDER_STATUS_COLOR[statusText] ?? $r('app.color.gray_6')
}


