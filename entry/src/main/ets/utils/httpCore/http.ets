import axios, { InternalAxiosRequestConfig, AxiosResponse, AxiosError, AxiosInstance } from '@ohos/axios';
import { promptAction } from '@kit.ArkUI';
import { globalHttp} from '../../constants/config'
import { checkStatus} from './checkStatus'

import PreferenceUtil from '../../utils/PreferenceUtil'
import Logger from '../Logger'
const TAG = 'httpCore =='

interface ApiResponse<T> { //根据项目实际项目修改
  code?: number;
  data: T | null;
  message?: string;
  ok?: boolean;     // 是否成功
}

/**
 * 扩展的 Axios 配置
 * - 继承 InternalAxiosRequestConfig
 * - 新增 extraData
 */
export interface ExtraRequestOptions  {
  ignoreToken?: boolean;     // 是否加 token
  rawResponse?: boolean;   // 是否返回原始数据
  xServerlessSign?:string  // 自定义签名
}
export interface ExtendedAxiosRequestConfig<T = object> extends InternalAxiosRequestConfig<T> {
  extraRequestOptions?: ExtraRequestOptions;
}

// 创建实例
const instance: AxiosInstance = axios.create({
  // 默认地址请求地址
  baseURL: globalHttp.BSP_APP_URL,
  // 设置超时时间
  timeout: 100000,
  headers: {
    'Content-Type': 'application/json;charset=utf-8',
    'Content-Language': 'zh_CN',
    // 'clientId':10
    'Terminal':globalHttp.TERMINAL
  },
});


// 添加请求拦截器
instance.interceptors.request.use(async (config: ExtendedAxiosRequestConfig) => {
  Logger.info(TAG,'extraRequestOptions',JSON.stringify(config))
 // 忽略token
  if(!config.extraRequestOptions?.ignoreToken){
    const token = await PreferenceUtil.get('token','')
    if (token) {
      config.headers['h-token'] = token;
    }
  }
  if(config.extraRequestOptions?.xServerlessSign){
    config.headers['x-serverless-sign'] = config.extraRequestOptions?.xServerlessSign;
  }
  return config
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error)
})

// 添加响应拦截器 错误统一处理等
instance.interceptors.response.use((response: AxiosResponse) => {
  Logger.debug(TAG,"请求回来", JSON.stringify(response))
  // 对响应数据做点什么
  // 下面配置根据系统返回来配置的，不同的系统配置不同
  if (response.data.code == 0) {
    promptAction.showToast({
      //用到了 @kit.ArkUI 的 promptAction进行系统弹窗提示
      message: response.data.massage || '请求成功',
      duration: 2000,
      alignment: Alignment.Center
    });
    Logger.debug(TAG,"请求成功", JSON.stringify(response))
    return response.data;
  } else {
    // 根据不同的错误码进行不同的处理
    promptAction.showToast({
      message: response.data.message || '请求失败，请稍后重试',
      duration: 2000,
      alignment: Alignment.Center
    });
    Logger.error(TAG,"Error", JSON.stringify(response))
    return Promise.reject(response.data);
  }
}, (error: AxiosError) => {
  // 请求超时 && 网络错误单独判断，没有 response
  if (error.message.indexOf("timeout") !== -1) {
    promptAction.showToast({ message: "请求超时！请您稍后重试" });
  }
  if (error.message.indexOf("Network Error") !== -1) {
    promptAction.showToast({ message: "网络错误！请您稍后重试" });
  }
  Logger.error(TAG,"AxiosError", JSON.stringify(error.response))
  console.log(TAG,"AxiosError", JSON.stringify(error.response))
  // 根据服务器响应的错误状态码，做不同的处理
  const status = error.response?.status;
  Logger.error(TAG,"status", JSON.stringify(status))
  if (status) {
    checkStatus(status);
  }
  Logger.error(TAG,"error", JSON.stringify(error))
  return Promise.reject(error)
})

// 封装请求方法
class RequestHttp {

  get<T>(url: string, params?: object,): Promise<ApiResponse<T>> {
    return instance.get<null, ApiResponse<T>>(url, { params })
  }

  // 封装post方法
  // 直接将参数添加到headers上
  // post<T>(url: string, data?: object,extraRequestOptions?: ExtraRequestOptions): Promise<ApiResponse<T>> {
  //   Logger.info(TAG,'requestOptions',JSON.stringify(extraRequestOptions))
  //   const headers: Record<string, string> = {};
  //   if (extraRequestOptions?.xServerlessSign) {
  //     headers['x-serverless-sign'] = extraRequestOptions.xServerlessSign;
  //   }
  //   return instance.post<null, ApiResponse<T>>(url, data, { headers });
  // }

  // 将参数添加到extraRequestOptions上
  post<T>(url: string, data?: object, extraRequestOptions?: ExtraRequestOptions): Promise<ApiResponse<T>> {
    return instance.post<null, ApiResponse<T>>(url, data, { extraRequestOptions } as ExtendedAxiosRequestConfig);
  }

  // 封装delete方法
  delete<T>(url: string, data?: object): Promise<ApiResponse<T>> {
    return instance.delete<null, ApiResponse<T>>(url, data)
  }

  // 封装put方法
  put<T>(url: string, data?: object): Promise<ApiResponse<T>> {
    return instance.put<null, ApiResponse<T>>(url, data)
  }
}

export const httpCore = new RequestHttp();



