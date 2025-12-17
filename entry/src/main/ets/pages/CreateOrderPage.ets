import { orderProgress } from '../components/OrderProgress'
import {return_companion_type, form_list_type, obj_list} from '../api/apiConstants'
import { mockHospital, HospitalItem ,medicalChaperonData, MedicalChaperonItem} from  '../mock/publicHospital'
import { equityList } from '../mock/packageList'
import type { EquityType } from '../mock/packageList'
import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import { PopupPicker } from '../components/PopupPicker'
import { PopupDateTimePicker} from '../components/PopupTimePicker'
import { DateUtils } from '../utils/DateUtils'
import CommonUtils from '../utils/CommonUtils'
import { CommonHeader } from '../components/CommonHeader';
import { router } from '@kit.ArkUI';
import { promptAction } from '@kit.ArkUI';


// 定义 radius 类型
interface SheetRadius {
  topLeft?: number
  topRight?: number
  bottomLeft?: number
  bottomRight?: number
}
// 定义 options 类型
interface SheetPopupInnerOptions {
  height: number
  backgroundColor: Color | Resource
  showClose: boolean
  radius?: SheetRadius
  onWillAppear?: () => void
  onAppear?: () => void
  onWillDisappear?: () => void
  onDisappear?: () => void
}
// 定义完整返回类型
interface SheetPopupOptions {
  show: boolean
  content: CustomBuilder
  options: SheetPopupInnerOptions
}

@Entry
@Component
struct CREATE_ORDER_PAGE {
  @State orderData:return_companion_type | undefined = undefined
  @State hospitalData:string[]  = []  // 医院列表
  @State medicalChaperonSix:string[] = []  // 陪诊师性别
  @State isPaymentConfirmShow: boolean = false;
  // 当前选择的订单类型（从主页传递过来）
  @State orderType: string = '专享半天陪诊'

  // 获取当前服务类型的图标
  @State currentServiceIcon: Resource = $r('app.media.equity_half_day')
  @State currentServiceContent: string = '专享1对1半天陪诊，最长4小时'
  @State currentServiceTimes: number = 1
  @State currentServicePrice: string = '258'

  @State form_list:form_list_type = {
    hospital_name:'请选择医院',
    hospital_id:undefined,
    starttime:undefined,
    time:'请选择就诊时间',
    companion_name:'请选择陪诊师',
    companion_id:undefined,
    receiveAddress:'请填写就诊人地址',
    tel:'请填写您的联系方式',
    demand:'请简单描述您要就诊的科室'
  }
  list:obj_list={
    hospital_name:'就诊医院',
    time:'就诊时间',
    companion_name:'陪诊师',
    receiveAddress:'接送地址',
    tel:"联系电话"
  }

  // 用于生成订单ID的计数器
  private orderIdCounter: number = 1000;


  onPageShow(): void {
    // 获取数据
    this.hospitalData = mockHospital.map((item: HospitalItem) => item.name)
    this.medicalChaperonSix = medicalChaperonData.map((item: MedicalChaperonItem) => item.name)

    // 获取从主页传递的参数
    const params = router.getParams() as Record<string, string>

    if (params) {
      if (params.orderType) {
        // 从主页直接传递的服务名称
        this.orderType = params.orderType

        // 根据服务名称在 equityList 中查找对应的服务信息
        const equity = equityList.find((item: EquityType) => item.name === this.orderType)
        if (equity) {
          this.updateServiceInfo(equity)
        }
      } else if (params.index) {
        // 从主页的 GridItemView 传递的 index
        const index = parseInt(params.index)
        if (index >= 0 && index < equityList.length) {
          const equity = equityList[index]
          this.orderType = equity.name
          this.updateServiceInfo(equity)
        }
      }
    }

    console.log('订单类型:', this.orderType)
  }

  // 更新服务信息
  private updateServiceInfo(equity: EquityType) {
    this.currentServiceIcon = equity.pic as Resource
    this.currentServiceContent = equity.content
    this.currentServiceTimes = equity.times
    this.currentServicePrice = equity.price.toString()

    // 根据不同的服务类型设置不同的标题
    let serviceTitle = ''
    switch (equity.name) {
      case '半天陪诊':
        serviceTitle = '专享半天陪诊'
        // this.currentServiceContent = '专享1对1半天陪诊，最长4小时'
        break
      case '代办问诊':
        serviceTitle = '代办问诊服务'
        // this.currentServiceContent = '代客户到机构咨询问诊'
        break
      case '待约检查':
        serviceTitle = '代约检查服务'
        // this.currentServiceContent = 'MRI/胃肠镜、CT/超声检查'
        break
      case '代办买药':
        serviceTitle = '代办买药服务'
        // this.currentServiceContent = '人工排队代买药'
        break
      default:
        serviceTitle = equity.name
    }
    this.orderType = serviceTitle
  }

  // 更新 form_list
  private updateFormField = (key: keyof form_list_type, value: string) => {
    Reflect.set(this.form_list, key, value)
  }

  // 提交订单
  submitOrderForm(){
    let itemArr = ['hospital_name','time','companion_name','receiveAddress','tel','demand']
    for(const element of itemArr){
      const val = Reflect.get(this.form_list,element) as string
      // 统一判空 / 默认占位符
      if (!val || val.includes('请选择') || val.includes('请填写')) {
        const label = Reflect.get(this.list, element) as string
        CommonUtils.alertMsg(`请填写${label}`)
        return
      }
      // 特殊校验：手机号格式
      if (element === 'tel') {
        const phoneRegex = /^1[3-9]\d{9}$/
        if (!phoneRegex.test(val)) {
          CommonUtils.alertMsg('请输入正确的手机号')
          return
        }
      }
    }
    // 校验通过
    console.log('订单类型:', this.orderType)
    console.log('服务信息:', {
      icon: this.currentServiceIcon,
      content: this.currentServiceContent,
      times: this.currentServiceTimes,
      price: this.currentServicePrice
    })
    console.log('填写的值：',JSON.stringify(this.form_list))
    router.pushUrl({
      url: 'pages/OrderDecPage',
      params: {
        orderTypeId: 202,
      }
    })
  }

  build() {
    Column() {
      CommonHeader({title:'新建订单',showLeftMenu:true})
      orderProgress({typeIndex:0}).height(140)
      OrderServerType({
        serverType: 0,
        orderType: this.orderType,
        serviceIcon: this.currentServiceIcon,
        serviceContent: this.currentServiceContent,
        serviceTimes: this.currentServiceTimes,
        servicePrice: this.currentServicePrice
      })
      OrderServerForm({
        hospitalData:this.hospitalData,
        companionData:this.medicalChaperonSix,
        form_list:this.form_list,
        list:this.list,
        onChange: this.updateFormField
      })

      Blank()
      Button('提交订单')
        .id(CommonConstants.LOGIN_BUTTON_ID)
        .width(StyleConstants.FULL_PARENT)
        .height($r('app.float.big_btn_height'))
        .fontSize($r('app.float.body_text'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.primary_color'))
        .margin({
          top: $r('app.float.margin_top'),
          bottom: $r('app.float.margin_bottom')
        })
        .onClick(() => {
          this.submitOrderForm()
        })
        .width('90%')
    }
    .width('100%')
    .height('100%')
    .width(StyleConstants.FULL_PARENT)
    .backgroundColor($r('app.color.background'))
  }
}


// 陪诊标题内容 - 修改为支持动态服务类型
// 陪诊标题内容 - 修改为支持动态服务类型
@Component
struct OrderServerType {
  private serverType?: number;
  @Prop orderType: string = '专享半天陪诊'
  @Prop serviceIcon: Resource = $r('app.media.equity_half_day')
  @Prop serviceContent: string = '专享1对1半天陪诊，最长4小时'
  @Prop serviceTimes: number = 1
  @Prop servicePrice: string = '258'

  build() {
    Column() {
      Row() {
        // 左侧：图标和服务信息
        Row() {
          // 图标
          Stack() {
            Image(this.serviceIcon)
              .width(24)
              .height(24)
          }
          .backgroundColor($r('app.color.green_1'))
          .border({ radius: 4 })
          .margin({ right: 8 })
          .width(40)
          .height(40)

          // 服务名称和描述
          Column() {
            Text(this.orderType)
              .fontSize($r('app.float.subtitle_text'))
              .fontWeight(FontWeight.Medium)
              .fontColor($r('app.color.gray_8'))
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Text(this.serviceContent)
              .fontSize($r('app.float.body_text_s'))
              .fontColor($r('app.color.gray_6'))
              .margin({ top: 2 })
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .layoutWeight(1)
        }
        .alignItems(VerticalAlign.Center)
        .layoutWeight(1) // 左侧占据剩余空间

        // 右侧：更换服务和价格
        Column() {
          // 更换服务按钮
          Row() {
            Image($r('app.media.icon_swap'))
              .width(10)
              .height(10)
              .fillColor($r('app.color.gray_8'))
              .margin({ right: 4 })

            Text('更换服务')
              .fontSize($r('app.float.body_text_s'))
              .fontWeight(FontWeight.Normal)
              .fontColor($r('app.color.gray_6'))
          }
          .justifyContent(FlexAlign.End)
          .margin({ bottom: 4 })

          // 价格信息
          Row() {
            Text(`¥${this.servicePrice}`)
              .fontSize($r('app.float.body_text'))
              .fontColor($r('app.color.primary_color'))
              .fontWeight(FontWeight.Bold)
            Text(` · ${this.serviceTimes}次服务`)
              .fontSize($r('app.float.body_text_s'))
              .fontColor($r('app.color.gray_6'))
          }
          .justifyContent(FlexAlign.End)
        }
        .width(100) // 固定右侧宽度，防止被遮挡
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .height(60)
    }
    .padding({ top: 12, bottom: 12, left: 16, right: 16 })
    .backgroundColor($r('app.color.color_white'))
    .margin({ top: 8, bottom: 8, left: 16, right: 16 })
    .borderRadius($r('app.float.card_radius'))
    .width('100%')
  }
}

// 订单填写的报表配置
@Component
struct OrderServerForm {

  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @Require @Prop form_list:form_list_type
  @Require @Prop list:obj_list

  onChange: (key: keyof form_list_type, value: string) => void = () => {}

  @Prop hospitalData:string[]; // 医院列表
  @State isHospitalPopupShow: boolean = false;  // 医院列表
  @State hospitalSelect: number = 2;

  @Prop companionData:string[]  // 陪诊师性别
  @State isCompanionPopupShow: boolean = false  // 陪诊师性别
  @State companionSelect: number = 0;

  @State isDatePickerShow:boolean = false  // 是否显示日期

  @State sheetHeight: number = 300;

  // 富文本编辑器
  controller: TextAreaController = new TextAreaController();
  @State textAreaValue: string = '';

  private form_list_filter: Partial<form_list_type> = {}

  /**
   * 根据占位符过滤值
   */
  private filterValue(value: string, placeholder: string): string {
    return value === placeholder ? '' : value
  }

  aboutToAppear() {
    this.form_list_filter = {
      hospital_name: this.filterValue(this.form_list.hospital_name, '请选择医院'),
      time: this.filterValue(this.form_list.time, '请选择就诊时间'),
      companion_name: this.filterValue(this.form_list.companion_name, '请选择陪诊师'),
      receiveAddress: this.filterValue(this.form_list.receiveAddress, '请填写就诊人地址'),
      tel: this.filterValue(this.form_list.tel, '请填写您的联系方式'),
      demand: this.filterValue(this.form_list.demand, '请简单描述您要就诊的科室')
    }
  }

  // 构建医院列表的popup
  @Builder
  BuilderHospitalPopup() {
    PopupPicker({
      title: '选择医院',
      options: this.hospitalData,
      defaultIndex: this.hospitalSelect,
      fieldKey: 'hospital_name',
      confirm: (value: string, index: number,fieldKey?:string) => {
        this.hospitalSelect = index
        this.onChange('hospital_name', value)
        console.log(`确认选择: ${fieldKey},${value}, index: ${index}`)
      },
      cancel: () => {
        console.log("取消选择")
      },
      isShow: this.isHospitalPopupShow
    })
  }

  // 构建陪诊师的popup
  @Builder
  BuilderCompanionPopup() {
    PopupPicker({
      title: '选择陪诊师',
      options: this.companionData,
      defaultIndex: this.companionSelect,
      fieldKey: 'companion_name',
      confirm: (value: string, index: number,fieldKey?:string) => {
        this.companionSelect = index
        this.onChange('companion_name', value)
        console.log(`确认选择: ${fieldKey},${value}, index: ${index}`)
      },
      cancel: () => {
        console.log("取消选择")
      },
      isShow: this.isCompanionPopupShow
    })
  }

  // 构建日期选择
  @Builder
  BuilderDatePickerPopup() {
    PopupDateTimePicker({
      title: '选择陪诊时间',
      isLunar: false,
      defaultDate: new Date(),
      fieldKey:'time',
      mode:'datetime',
      startDate:new Date,
      confirm: (value: Date,key?:string ) => {
        const time = DateUtils.format(value, 'yyyy-MM-dd HH:mm')
        this.onChange('time', time)
        console.log(`确认选择,${key},${value}`)
      },
      cancel: () => {
        console.log("取消选择")
      },
      isShow: this.isDatePickerShow
    })
  }

  // 通用 bindSheet 工具，返回 Builder
  private createSheetOptions(): SheetPopupInnerOptions {
    return {
      height: this.sheetHeight,
      backgroundColor: $r('app.color.color_white'),
      showClose: false,
      radius: { topLeft:16, topRight:16 },
      onWillAppear: () => console.log("BindSheet onWillAppear."),
      onAppear: () => console.log("BindSheet onAppear."),
      onWillDisappear: () => console.log("BindSheet onWillDisappear."),
      onDisappear: () => console.log("BindSheet onDisappear.")
    }
  }

  build() {
    Column(){
      Column() {
        Row(){
          Text('就诊医院')
            .orderFormLabelStyle()
            .width('40%')
          Row(){
            Text(this.form_list.hospital_name)
              .orderFormTipsStyle()
            Image($r('app.media.icon_arrow_right'))
              .orderFormTipsIconStyle()
          }
          .orderFormTipsRowStyle()
          .onClick(() => {
            this.isHospitalPopupShow = true
          })
          .bindSheet($$this.isHospitalPopupShow,
            this.BuilderHospitalPopup(),
            this.createSheetOptions()
          )
        }.orderFormRowStyle()
        Row(){
          Text('就诊时间')
            .orderFormLabelStyle()
            .width('40%')
          Row(){
            Text(this.form_list.time)
              .orderFormTipsStyle()
            Image($r('app.media.icon_arrow_right'))
              .orderFormTipsIconStyle()
          }
          .orderFormTipsRowStyle()
          .onClick(() => {
            this.isDatePickerShow = true
          })
          .bindSheet($$this.isDatePickerShow,
            this.BuilderDatePickerPopup(),
            this.createSheetOptions()
          )
        }.orderFormRowStyle()
        Row(){
          Text('陪诊师')
            .orderFormLabelStyle()
            .width('40%')
          Row(){
            Text(this.form_list.companion_name)
              .orderFormTipsStyle()
            Image($r('app.media.icon_arrow_right'))
              .orderFormTipsIconStyle()
          }
          .orderFormTipsRowStyle()
          .onClick(() => {
            this.isCompanionPopupShow = true
          })
          .bindSheet($$this.isCompanionPopupShow,
            this.BuilderCompanionPopup(),
            this.createSheetOptions()
          )
        }.orderFormRowStyle()
        Row(){
          Text('接送地址')
            .orderFormLabelStyle()
            .width('40%')
          Row(){
            OrderServerInput({
              value: this.form_list_filter.receiveAddress,
              onChange: (val: string) => this.onChange('receiveAddress', val)
            })
          }
          .orderFormTipsRowStyle()
        }.orderFormRowStyle()
        Row(){
          Text('联系电话')
            .orderFormLabelStyle()
            .width('40%')
          Row(){
            OrderServerTelInput({
              value: this.form_list_filter.tel,
              onChange: (val: string) => this.onChange('tel', val)
            })
          }
          .orderFormTipsRowStyle()
        }.orderFormRowStyle()
      }
      .width('100%')
      .padding(16)
      .margin({top:8,bottom:8,left:16,right:12})
      .backgroundColor($r('app.color.color_white'))
      .borderRadius($r('app.float.card_radius'))

      // 服务需求
      Column(){
        Text('服务需求')
          .width('100%')
          .fontSize($r('app.float.body_text'))
          .fontColor($r('app.color.gray_6'))
          .height(24)
          .lineHeight(24)
          .margin({left:8,bottom:8})
          .padding({left:16,right:16})
        TextArea({
          text: this.textAreaValue,
          placeholder: '请输入您的服务需求...',
          controller: this.controller
        })
          .orderFormTextAreaStyle()
          .height(80)
          .maxLength(400)
          .onChange((value)=>{
            this.onChange('demand', value)
          })
      }.backgroundColor($r('app.color.background'))
    }
  }
}

// 电话号码的输入
@Preview
@Component
struct OrderServerTelInput{
  @Prop value: string = ''
  onChange: (val: string) => void = () => {}

  @State private error?: boolean = false;

  /**
   * 校验手机号
   */
  private validatePhone(value: string) {
    if (value.length === 0) {
      this.error = false
      return
    }
    // 大陆手机号规则：1 开头，第二位 3-9，总共 11 位
    const phoneRegex = /^1[3-9]\d{9}$/
    this.error = !phoneRegex.test(value) // ✅ 改为直接赋值
  }

  build() {
    Column() {
      TextInput({
        text:this.value,
        placeholder: `请填写联系方式`
      })
        .orderFormInputStyle()
        // ✅ 根据 error 动态切换颜色
        .fontColor(this.error?$r('app.color.danger_color'):$r('app.color.gray_8'))
        .type(InputType.Number) // 限制只能输入数字
        .maxLength(11) // 限制最大长度
        .onChange(value=>{
          if(value.length==11){
            this.validatePhone(value)
          }
          this.onChange(value)
        })
        .textAlign(TextAlign.End)
    }
  }
}

@Preview
@Component
struct OrderServerInput{
  @Prop value?: string = '';
  onChange: (val: string) => void = () => {}

  build() {
    Column() {
      TextInput({text:this.value,placeholder: `请输入接送地址`})
        .orderFormInputStyle()
        .maxLength(11)
        .onChange(value=>{
          this.onChange(value)
        })
        .textAlign(TextAlign.End)
    }
  }
}

// 通用样式
@Extend(Text) function orderFormLabelStyle() {
  .fontColor($r('app.color.gray_8'))
  .fontSize($r('app.float.body_text'))
  .fontWeight(FontWeight.Medium)
  .height(32)                  // 固定高度
  .lineHeight(32)               // 行高与高度一致
}

@Extend(Text) function orderFormTipsStyle() {
  .fontColor($r('app.color.gray_6'))
  .fontSize($r('app.float.body_text'))
  .fontWeight(FontWeight.Medium)
  .height(32)                  // 固定高度
  .lineHeight(32)               // 行高与高度一致
  .textAlign(TextAlign.End)
}

@Extend(Image) function orderFormTipsIconStyle() {
  .width(12)
  .height(12)
  .fillColor($r('app.color.gray_6'))
  .margin({left:4,top:5})              // 行高与高度一致
}

@Extend(Row) function orderFormTipsRowStyle() {
  .width('60%')
  .height(32)
  .justifyContent(FlexAlign.End)
  .alignItems(VerticalAlign.Center)
}

@Extend(Row) function orderFormRowStyle() {
  .width('100%')
  .alignItems(VerticalAlign.Center)
  .justifyContent(FlexAlign.SpaceBetween)
  .padding({bottom:10})
  .borderWidth({ bottom: 1 })
  .borderStyle(BorderStyle.Solid)
  .borderColor($r('app.color.line_border'))
}

@Extend(TextInput) function orderFormInputStyle() {
  .fontSize($r('app.float.body_text'))
  .backgroundColor(Color.Transparent)
  .placeholderColor($r('app.color.gray_6'))
  .placeholderFont({size:$r('app.float.body_text')})
  .caretColor($r('app.color.green_6'))
  .padding(0)
  .margin(0)
  .borderRadius(0)
  .height(32)                  // 固定高度
  .lineHeight(32)
}

@Extend(TextArea) function orderFormTextAreaStyle() {
  .fontSize($r('app.float.body_text'))
  .backgroundColor(Color.Transparent)
  .placeholderColor($r('app.color.gray_6'))
  .caretColor($r('app.color.gray_6'))
  .placeholderFont({size:$r('app.float.body_text')})
  .margin(0)
  .borderRadius(0)
  .lineHeight(18)
  .copyOption(CopyOptions.None) // 是否允许复制
  .showCounter(true, { thresholdPercentage: 50, highlightBorder: true })
  .backgroundColor($r('app.color.color_white'))
}




