// // entry/src/main/ets/utils/SimpleOrderManager.ts
// import { orderListData } from '../mock/OrderListData'
// import type { OrderItemType } from '../mock/OrderListData'
// import { form_list_type } from '../api/apiConstants'
//
// export class SimpleOrderManager {
//   // 使用静态变量存储订单（内存存储）
//   private static orders: OrderItemType[] = [...orderListData] // 初始包含模拟数据
//   private static orderCounter: number = 1000
//
//   /**
//    * 生成订单ID
//    */
//   private static generateOrderId(): string {
//     SimpleOrderManager.orderCounter++
//     const date = new Date()
//     const year = date.getFullYear().toString().substring(2)
//     const month = (date.getMonth() + 1).toString().padStart(2, '0')
//     const day = date.getDate().toString().padStart(2, '0')
//     const random = Math.floor(Math.random() * 1000).toString().padStart(3, '0')
//     return `PZ${year}${month}${day}${random}${SimpleOrderManager.orderCounter}`
//   }
//
//   /**
//    * 创建新订单数据
//    */
//   static createNewOrder(
//     orderType: string,
//     formData: form_list_type
//   ): OrderItemType {
//     // 使用第一个模拟订单作为模板
//     const template = SimpleOrderManager.orders[0] || orderListData[0]
//
//     const orderId = SimpleOrderManager.generateOrderId()
//     const currentTime = new Date()
//
//     // 创建新订单（基于模板）
//     const newOrder: OrderItemType = {
//       ...template, // 复制模板的所有属性
//       orderID: orderId,
//       service_name: orderType,
//       starttime: formData.time || template.starttime,
//       order_content: {
//         ...template.order_content,
//         hospital: formData.hospital_name || template.order_content.hospital,
//         order_name: formData.companion_name || template.order_content.order_name,
//         order_mobile: formData.tel || template.order_content.order_mobile,
//         serve_time: formData.time || template.order_content.serve_time
//       },
//       patient_content: {
//         ...template.patient_content,
//         patient_name: formData.companion_name || template.patient_content.patient_name,
//         patient_mobile: formData.tel || template.patient_content.patient_mobile
//       },
//       order_remark: formData.demand || template.order_remark,
//       mainGood: {
//         ...template.mainGood,
//         name: orderType
//       }
//     }
//
//     return newOrder
//   }
//
//   /**
//    * 保存订单（内存存储）
//    */
//   static saveOrder(
//     formData: form_list_type,
//     orderType: string
//   ): {
//     success: boolean;
//     orderId?: string;
//     orderData?: OrderItemType;
//   } {
//     try {
//       console.log('开始创建订单...')
//       console.log('订单类型:', orderType)
//       console.log('表单数据:', JSON.stringify(formData))
//
//       // 创建新订单
//       const orderData = SimpleOrderManager.createNewOrder(orderType, formData)
//
//       // 添加到订单列表开头
//       SimpleOrderManager.orders.unshift(orderData)
//
//       console.log('✅ 订单创建成功（内存存储）:', orderData.orderID)
//       console.log('当前订单总数:', SimpleOrderManager.orders.length)
//
//       return {
//         success: true,
//         orderId: orderData.orderID,
//         orderData: orderData
//       }
//     } catch (error) {
//       console.error('保存订单失败:', error)
//       return { success: false }
//     }
//   }
//
//   /**
//    * 获取订单列表
//    */
//   static getOrderList(): OrderItemType[] {
//     return SimpleOrderManager.orders
//   }
//
//   /**
//    * 根据订单ID获取订单
//    */
//   static getOrderById(orderId: string): OrderItemType | undefined {
//     return SimpleOrderManager.orders.find(order => order.orderID === orderId)
//   }
//
//   /**
//    * 根据状态筛选订单
//    */
//   static filterOrdersByStatus(status: number): OrderItemType[] {
//     if (status === 0) {
//       return SimpleOrderManager.orders
//     }
//     return SimpleOrderManager.orders.filter(order => order.mainGood.type === status)
//   }
//
//   /**
//    * 调试方法
//    */
//   static debugStorage(): void {
//     console.log('=== 内存存储调试信息 ===')
//     console.log('订单数量:', SimpleOrderManager.orders.length)
//     console.log('订单ID列表:', SimpleOrderManager.orders.map(o => o.orderID))
//     console.log('========================')
//   }
// }