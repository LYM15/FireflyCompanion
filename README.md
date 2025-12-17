# FireflyCareOnHarmonyOS

#### 介绍

基于华为官方示例Login开发：https://gitee.com/harmonyos/codelabs/tree/master/LoginDemo

结合哔哩哔哩上的鸿蒙免费课程编写的ArkTs项目

项目中封装了接口请求数据axios的httpCore，数据持久化PreferenceUtil，提示信息带图标和不带图标的CommonUtils方法，在utils文件夹内部

封装了一些通用组件，CommonEmpty，CommonHeader，ImgActionTips，OrderProgress，PopupPicker，PopupTimePicker等，在components文件夹内部

模拟数据是抓包的鲸鱼陪诊，页面部分有的是参考的华为，有的是网上找的【不要介意】

其中颜色，字体的变量定义参考的华为官网，地址为：https://developer.huawei.com/consumer/cn/doc/design-guides/color-0000001776857164#section7268141401117


#### 效果预览
| 登录                                                | 主页                                                     | 订单页                                                          | 我的                                                              |
|---------------------------------------------------|---------------------------------------------------------|----------------------------------------------------------------|--------------------------------------------------------------------|
| ![登录](%E6%88%AA%E5%9B%BE/01_%E7%99%BB%E5%BD%95.png) | ![主页](%E6%88%AA%E5%9B%BE/03_%E4%B8%BB%E9%A1%B5.png) | ![订单页](%E6%88%AA%E5%9B%BE/04_%E8%AE%A2%E5%8D%95%E5%88%97%E8%A1%A8.png) | ![我的](%E6%88%AA%E5%9B%BE/07_%E6%88%91%E7%9A%84.png) |

| 权益列表                                                | 订单填写                                                     | 订单填写                                                          | 订单填写                                                              |
|---------------------------------------------------|---------------------------------------------------------|----------------------------------------------------------------|--------------------------------------------------------------------|
| ![权益列表](%E6%88%AA%E5%9B%BE/04_%E6%9D%83%E7%9B%8A%E5%88%97%E8%A1%A8.png) | ![订单填写](%E6%88%AA%E5%9B%BE/08_%E6%96%B0%E5%BB%BA%E8%AE%A2%E5%8D%95.png) | ![订单填写](%E6%88%AA%E5%9B%BE/08_%E6%96%B0%E5%BB%BA%E8%AE%A2%E5%8D%95_%E9%80%89%E6%8B%A9%E5%8C%BB%E9%99%A2.png) | ![订单填写](%E6%88%AA%E5%9B%BE/09_%E6%96%B0%E5%BB%BA%E8%AE%A2%E5%8D%95_%E9%80%89%E6%8B%A9%E6%97%A5%E6%9C%9F.png) |



#### 工程目录

```
├──entry/src/main/ets/
│  ├─api  // 接口封装相关
│  │      apiConstants.ets   // 所有与api相关的类型定义
│  │      apiEndpoint.ets  // 接口请求方法
│  │      orderStatusConfig.ets  // 数据相关的常量定义
│  ├─components  // 组件封装
│  │      CommonEmpty.ets  
│  │      CommonHeader.ets
│  │      ImgActionTips.ets
│  │      OrderProgress.ets
│  │      OrderProgressDec.ets
│  │      PopupHeader.ets
│  │      PopupPicker.ets
│  │      PopupTimePicker.ets
│  │      TelTextInput.ets
│  ├─constants  // 常量定义
│  │      CommonConstants.ets
│  │      config.ets
│  │      StyleConstants.ets
│  ├─mock  // 模拟数据
│  │      ItemData.ets
│  │      MainViewModel.ets
│  │      OrderListData.ets
│  │      packageList.ets
│  │      publicHospital.ets
│  │      SourceData.et
│  ├─pages  // 页面
│  │      CreateOrderPage.ets
│  │      LoginPage.ets
│  │      MainPage.ets
│  │      OrderDecPage.ets
│  ├─utils  // 方法
│  │  │  CommonUtils.ets
│  │  │  DateUtils.ets
│  │  │  GlobalContext.ets
│  │  │  immersiveUtils.ets
│  │  │  Logger.ets
│  │  │  LoginUtils.ets
│  │  │  MultipleDevicesUtils.ets
│  │  │  PreferenceUtil.ets
│  │  │  PromptActionClass.ets
│  │  │  resetDateUtils.ets
│  │  └─httpCore  // axios接口封装
│  │          checkStatus.ets
│  │          http.ets
│  └─view  // 子页面
│          HomePage.ets
│          HomePage_copy.ets
│          MinePage.ets
│          OrderList.ets
│          OrderListPage.ets
│          ServicePage.ets
└─resources  // 资源目录
│   └─base
│       ├─element
│       │──── color.json   // 颜色值定义
│       │──── float.json   // 字体大小等定义
│       └──── string.json   // 字段定义
└──module.json5        // Stage模型模块配置文件，主要包含HAP的配置信息、应用在具体设备上的配置信息以及应用的全局配置信息
```


### 相关权限

网络权限：【ohos.permission.INTERNET】


### 约束与限制

1.仅支持标准系统上运行，支持设备：华为手机。

2.HarmonyOS系统：HarmonyOS 5.0.4 Release及以上。

3.DevEco Studio版本：DevEco Studio 5.0.4 Release及以上。

4.HarmonyOS SDK版本：HarmonyOS 5.0.4 Release SDK及以上。https://gitee.com/gitee-stars/)