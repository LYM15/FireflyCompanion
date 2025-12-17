// 引入封装的请求
import { httpCore } from '../utils/httpCore/http'
import type { ExtraRequestOptions} from '../utils/httpCore/http'
import { globalHttp} from '../constants/config'

// 引入类型定义
import { login_type, return_login_type,ResponseType } from  '../api/apiConstants'

export class ApiEndpoint {
  public static LOGIN = "/login"
  public static ORDER_LIST = "/order/list"
  public static ORDER_DETAIL = "/order/detail"
  public static COMPANION = "/h5/companion"
  public static LOGINADMIN = '/api/upms/login/loginByAdmin'
  public static BSP_APP = '/client'
}

// export const Login = (data: login_type): Promise<ResponseType<return_login_type>> => {
//   return http.post<return_login_type>(ApiEndpoint.LOGIN, data, {
//     needToken: false // 登录接口不需要 token
//   });
// };

// interface ApiResponse {
//   code?: number;
//   data: object | null;
//   message?: string;
// }



interface LoginType {
  username:string,
  password:string,
  clientId:string,
  loginType:string

}
const loginDate:LoginType = {
  "username": "Ling0036",
  "password": "123456",
  "clientId": "10",
  "loginType": "3"
}
export function LoginByAdmin(){
  return httpCore.post<ApiResponse>(ApiEndpoint.LOGINADMIN,loginDate)
}


// 抓包鲸鱼陪诊的部分数据

// 单独抽离 clientInfo
export interface ClientInfo {
  PLATFORM: string
  OS: string
  APPID: string
  DEVICEID: string
  scene: number
  deviceId: string
  appId: string
  appName: string
  appVersion: string
  appVersionCode: string
  appLanguage: string
  uniCompilerVersion: string
  uniRuntimeVersion: string
  uniPlatform: string
  deviceBrand: string
  deviceModel: string
  deviceType: string
  osName: string
  osVersion: string
  hostVersion: string
  hostName: string
  locale: string
  LOCALE: string
}

export interface FunctionArgs<T> {
  $url: string
  data: T
  clientInfo: ClientInfo
}

export interface RequestPayload<T> {
  functionTarget: string
  functionArgs: FunctionArgs<T>
}

export interface ApiResponse<T = object> {
  code: number
  message: string
  data: T
}

// 固定的 clientInfo
const clientInfo: ClientInfo = {
  PLATFORM: "mp-weixin",
  OS: "ios",
  APPID: "__UNI__3BA30B2",
  DEVICEID: "1754964744590596992",
  scene: 1089,
  deviceId: "1754964744590596992",
  appId: "__UNI__3BA30B2",
  appName: "鲸鱼陪诊2.0",
  appVersion: "1.0.0",
  appVersionCode: "100",
  appLanguage: "zh-Hans",
  uniCompilerVersion: "4.55",
  uniRuntimeVersion: "4.55",
  uniPlatform: "mp-weixin",
  deviceBrand: "iphone",
  deviceModel: "iPhone SE (2nd generation)<iPhone12,8>",
  deviceType: "phone",
  osName: "ios",
  osVersion: "18.5",
  hostVersion: "8.0.61",
  hostName: "WeChat",
  locale: "zh-Hans",
  LOCALE: "zh-Hans"
}

export interface RequestDataType {
  method: string
  params: string
  spaceId: string
  token: string
  timestamp: string
}

// 通用请求封装（url 和 data 外部传入）
// 热门医院列表 getPublicHospital
interface dataType{
  city:string
}

export function getPublicHospital(data:dataType){

  const functionArgsData:FunctionArgs<dataType> = {
    $url: "client/pub.package.getPackageList",
    data,
    clientInfo
  }

  const bodyData:RequestPayload<dataType> = {
    functionTarget:'router',
    functionArgs:functionArgsData
  }

  const params:RequestDataType = {
    method: "serverless.function.runtime.invoke",
    params: JSON.stringify(bodyData),
    spaceId: 'mp-b5004239-46a6-403a-8597-de3ff75aabbf',
    token: globalHttp.BSP_APP_TOKEN,
    timestamp:Date.now().toString()
  }

  const requestOptions:ExtraRequestOptions = {
    xServerlessSign:'f474b9dfe8bb9e95752d30d20d2edba9'
  }

  return httpCore.post<ApiResponse>(ApiEndpoint.BSP_APP,params,requestOptions)
}



