import { orderProgress } from '../components/OrderProgress'
import {return_companion_type, form_list_type, obj_list} from '../api/apiConstants'
import { mockHospital, HospitalItem ,medicalChaperonData, MedicalChaperonItem} from  '../mock/publicHospital'
import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import { PopupPicker } from '../components/PopupPicker'
import { PopupDateTimePicker} from '../components/PopupTimePicker'

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


  onPageShow(): void {
    // 获取数据
    this.hospitalData = mockHospital.map((item: HospitalItem) => item.name)
    this.medicalChaperonSix = medicalChaperonData.map((item: MedicalChaperonItem) => item.name)
  }

  build() {
    Column() {
      orderProgress({typeIndex:0}).height(140)
      OrderServerType({serverType:0})
      OrderServerForm({hospitalData:this.hospitalData,companionData:this.medicalChaperonSix})

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
        })
        .width('90%')
    }
    .width('100%')
    .height('100%')
    .width(StyleConstants.FULL_PARENT)
    .backgroundColor($r('app.color.background'))
  }
}

// 陪诊标题内容
@Component
struct OrderServerType {
  private serverType?: number;

  aboutToAppear() {

  }
  build() {
    Row(){
      Row(){
        Stack(){
          Image($r('app.media.equity_half_day'))
            .width(18)
            .height(18)
        }
        .backgroundColor($r('app.color.green_1'))
        .border({radius:2})
        .margin({right:6})
        .width(32)
        .height(32)

        Text('专享半天陪诊')
          .fontSize($r('app.float.subtitle_text_l'))
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(VerticalAlign.Center)
      Row(){
        Image($r('app.media.icon_swap'))
          .width(12)
          .height(12)
          .fillColor($r('app.color.gray_8'))
          .margin({right:4})

          Text('更换服务')
            .fontSize($r('app.float.body_text_s'))
            .fontWeight(FontWeight.Normal)
            .alignSelf(ItemAlign.Start)
            .fontColor($r('app.color.gray_6'))
            .lineHeight(14)
            .margin({bottom:-4,left:2})
        }
    }
    .height('60')
    .padding({top:8,bottom:8,left:16,right:16})
    .backgroundColor($r('app.color.color_white'))
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({top:8,bottom:8,left:16,right:16})
    .width('100%')
  }
}

// 订单填写的报表配置
// @Preview
// @Entry 和 @Preview 的组件，都必须是“自给自足”的，不能依赖外部传参（@Prop、@Consume、@Link 等）。
@Component
struct OrderServerForm {

  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  // @Prop orderData?: return_companion_type;

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

  // 构建医院列表的popup
  @Builder
  BuilderHospitalPopup() {
    PopupPicker({
      title: '选择医院',
      options: this.hospitalData,
      defaultIndex: this.hospitalSelect,
      fieldKey: 'hospital_name',
      confirm: (value: string, index: number,fieldKey?:string) => {
        this.form_list.hospital_name = value
        this.hospitalSelect = index
        console.log(`确认选择: ${fieldKey},${value}, index: ${index}`)
      },
      cancel: () => {
        console.log("取消选择")
      },
      isShow: this.isHospitalPopupShow   // ✅ 必须传递
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
        this.form_list.companion_name = value
        this.companionSelect = index
        console.log(`确认选择: ${fieldKey},${value}, index: ${index}`)
      },
      cancel: () => {
        console.log("取消选择")
      },
      isShow: this.isCompanionPopupShow   // ✅ 必须传递
    })
  }

  // 构建日期选择
  @Builder
  BuilderDatePickerPopup() {
    PopupDateTimePicker({
      title: '选择陪诊时间',
      isLunar: false,
      selectedDate: new Date(),
      fieldKey:'',
      confirm: (value: Date,key?:string ) => {
        this.form_list.companion_name = value.toString()
        console.log(`确认选择,${key},${value}`)
      },
      cancel: () => {
        console.log("取消选择")
      },
      isShow: this.isDatePickerShow   // ✅ 必须传递
    })
  }

  // 通用 bindSheet 工具，返回 Builder
  // ===================== 通用 sheet options =====================
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

  // 返回对应 item 的显示状态
  private getSheetShow(item: string): boolean {
    console.log('getSheetShow==getSheetBuilder',item)
    if(item === 'hospital_name') return this.isHospitalPopupShow;
    if(item === 'companion_name') return this.isCompanionPopupShow;
    if(item === 'time') return this.isDatePickerShow;
    return false;
  }
  // 返回对应 item 的 Builder
  private getSheetBuilder(item: string): CustomBuilder {
    console.log('getSheetBuilder',item)
    if(item === 'hospital_name') return this.BuilderHospitalPopup;
    if(item === 'companion_name') return this.BuilderCompanionPopup;
    if(item === 'time') return this.BuilderDatePickerPopup;
    return (): void => {};
  }


  build() {
    Column(){
      Column() {
        ForEach(Object.keys(this.list),(item:string,index:number)=>{

          Row(){
            Text(Reflect.get(this.list,item))
              .orderFormLabelStyle()
              .width('40%')
            if(item ==='receiveAddress' || item === 'tel'){
              OrderServerInput({form_list:this.form_list,text:item})
                .width('60%')
            } else {
              Row(){
                Text(Reflect.get(this.form_list,item))
                  .orderFormLabelStyle()
                  .textAlign(TextAlign.End)
                Image($r('app.media.icon_arrow_right'))
                  .width(12)
                  .height(12)
                  .fillColor($r('app.color.gray_6'))
                  .margin({left:4,top:5})
              }
              .width('60%')
              .height(32)
              .justifyContent(FlexAlign.End)
              .alignItems(VerticalAlign.Center)
              .onClick(() => {
                if(item ==='hospital_name'){
                  this.isHospitalPopupShow = true
                }else if(item ==='companion_name'){
                  this.isCompanionPopupShow = true
                }else if(item === 'time'){
                  this.isDatePickerShow = true
                }
              })
              .bindSheet(
                this.getSheetShow(item),
                this.getSheetBuilder(item),
                this.createSheetOptions()
              )
              // 参考文档：https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-universal-attributes-sheet-transition#bindsheet
              // .bindSheet($$this.isHospitalPopupShow,
              //   this.BuilderHospitalPopup(),
              //   this.createSheetOptions()
              //   })
            }
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({bottom:index === Object.keys(this.list).length - 1 ? 0 : 10})
          .borderWidth({ bottom: index === Object.keys(this.list).length - 1 ? 0 : 1 })
          .borderStyle(BorderStyle.Solid)
          .borderColor($r('app.color.line_border'))
        })
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
      }.backgroundColor($r('app.color.background'))
    }
  }
}

// 订单填写的报表配置
@Preview
@Component
struct OrderServerInput{
  private form_list?: form_list_type;
  private text?: string;
  build() {
    Column() {
      TextInput({text:'',placeholder: `${Reflect.get(this.form_list,this.text)}`})
        .orderFormInputStyle()
        .onChange(value=>{
          if (this.form_list && this.text){
            Reflect.set(this.form_list,this.text,value)
          }
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
  //计数器显示效果为用户当前输入字符数/最大字符限制数。最大字符限制数通过maxLength()接口设置。
  //如果用户当前输入字符数达到最大字符限制乘50%（thresholdPercentage）。字符计数器显示。
  //用户设置highlightBorder为false时，配置取消红色边框。不设置此参数时，默认为true。
  // .inputFilter(value: ResourceStr, error?: (value: string) => void)
  // .onChange((value:string)=>{
  //
  // })
}