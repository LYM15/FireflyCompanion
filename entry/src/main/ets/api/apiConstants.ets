export interface ResponseType<T> {
  code: number;    // 业务码
  message: string; // 提示信息
  data: T;         // 业务数据
  ok: boolean;     // 是否成功
}

export interface option_type{
  method?:string
  url:string
  data?:object
  params?:object
  headers?:object
}

export interface request_dataType{
  code:number
  message?:string
  data?:object | null
}

// 登录页
export interface return_login_type{
  token:string,
  userInfo:userInfo
}
export interface userInfo{
  avatar:string,
  name:string
}
export interface login_type{
  passWord:string,
  userName:string
}

export interface hospitals{
  avatar_url:string
  id:number
  intro:string
  label:string
  name:string
  rank:string
}
export interface nav2s{
  pic_image_url:string
}

export interface slides{
  pic_image_url:string
}
export interface return_home_type{
  hospitals:Array<hospitals>,
  nav2s:Array<nav2s>,
  slides:Array<slides>,
}

// 创建订单
export interface obj_list{
  hospital_name:string,
  time:string
  companion_name:string
  receiveAddress:string
  tel:string,
}

export interface form_list_type{
  hospital_name:string,
  starttime:number|undefined
  companion_name:string
  receiveAddress:string
  tel:string
  demand:string
  hospital_id:number|undefined
  companion_id:number|undefined
  time:string
}

// 接口数据
export interface companion{
  age:number
  id:number
  mobile:string
  name:string
}
export interface companion_hospitals{
  service_id:number
  id:number
  name:string
  service_price:string
}
export interface service{
  serviceImg:string
  serviceName:string
}
export interface return_companion_type{
  companion:Array<companion>,
  hospitals:Array<companion_hospitals>
  service:service
}

// 支付接口
export interface createOrder_type{
  hospital_name:string,
  starttime:number
  receiveAddress:string
  tel:string
  demand:string
  hospital_id:number
  companion_id:number
}
export interface return_createOrder_type{
  wx_code:string
}

// 订单接口
export interface return_order_type{
  _id:string,
  serviceImg:string
  service_name:string
  hospital_name:string
  starttime:string
  trade_state:string
  order_start_time:number
  out_trade_no:string
}
export interface order_type{
  state:number
}

// 详情页面接口
export interface detail_type{
  oid:string
}
export interface client{
  mobile:string
  name:string
}
export interface return_detail_type{
  service_name:string
  hospital_name:string
  starttime:string
  client:client
  receiveAddress:string
  demand:string
  order_start_time:number
  price:string
  out_trade_no:string
  trade_state:string
  code_url:string
}













// MainGoodType 定义（根据你的错误信息推断）
export interface MainGoodType {
  name: string
  price: number
  type: number
  content: string
  pic: string | Resource
  // 注意：根据错误信息，可能没有 times 字段
}

// PatientContentType 定义
export interface PatientContentType {
  patient_name: string
  patient_sex: string
  patient_age: number
  patient_mobile: string
  patient_move: string
  patient_remark: string
  patient_id: string
}

// OrderContentType 定义
export interface OrderContentType {
  city: string
  hospital: string
  order_name: string
  order_mobile: string
  order_sex: string
  serve_time: string
}

// 确保 OrderItemType 有 order_status 字段
export interface OrderItemType {
  orderID: string
  service_name: string
  serve_amount: number
  order_status: number  // 添加这个字段
  _add_time_str: string
  create_time: number
  starttime: string
  order_content: OrderContentType
  patient_content: PatientContentType
  order_remark: string
  mainGood: MainGoodType
  serviceImg: string | Resource
}