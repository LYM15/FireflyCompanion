import { orderProgress } from '../components/OrderProgress'
import { orderProgressDec } from '../components/OrderProgressDec'
import { CommonHeader } from '../components/CommonHeader'
import { CommonEmpty } from '../components/CommonEmpty'
import { orderListData ,OrderItemType } from '../mock/OrderListData'
import { router } from '@kit.ArkUI';


@Entry
@Component
struct orderDecPage {
  @State orderDataFilter:OrderItemType[] = orderListData
  @State orderTypeId:number = 201
  @State orderId:string = 'PZ20250826689768544'
  @State orderItemFilter?: OrderItemType | undefined =  undefined // 单个对象，可能为空

  filterOrderData(orderId: string): OrderItemType | undefined {
    return orderListData.find(item => item.orderID === orderId)
  }

  updateFilter(orderId: string) {
    const result = this.filterOrderData(orderId)
    if (result) {
      this.orderItemFilter = result
    } else {
      console.warn(`未找到匹配的订单: ${orderId}`)
      this.orderItemFilter = undefined
    }
  }

  onPageShow(): void {
    // 根据路由传过来的id进行数据的筛选
    // 实际上是需要根据id调接口查询的
    const params = router.getParams() as Record<string, Object>;
    console.log('接收到的路由参数:', JSON.stringify(params));
    if (params) {
      this.orderId = params['orderId'] as string;
      this.orderTypeId = params['orderTypeId'] as number;
      console.log(`接收到参数: ${this.orderId}, ${this.orderTypeId}`);

      // 如果是新创建的订单，添加一个日志
      if (params['isNewOrder']) {
        console.log('这是新创建的订单');
      }

      this.updateFilter(this.orderId)
    } else {
      console.warn('没有接收到路由参数');
    }
  }

  build() {
    Scroll() {
      Column() {
        CommonHeader({title:"订单详情",showLeftMenu:true})
        // 进度
        orderProgress({orderTypeId:this.orderTypeId}).height(140)
        // 说明
        orderProgressDec({orderTypeId:this.orderTypeId})
          .padding(16)
          .margin(16)
          .backgroundColor($r('app.color.color_white'))
          .borderRadius($r('app.float.card_radius'))
        if(this.orderItemFilter){
          // 预约信息
          orderContent({orderContent:this.orderItemFilter})
          // 就诊人信息
          patientContent({orderContent:this.orderItemFilter})
          // 订单信息
          orderDec({orderContent:this.orderItemFilter})
        }else{
          CommonEmpty({title:'没有订单数据'})
        }

      }.justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .alignSelf(ItemAlign.Start)
    .backgroundColor($r('app.color.background'))
  }
}


// 预约信息
@Component
struct orderContentTitle {
  private title?: string;

  aboutToAppear() {

  }
  build() {
    Row(){
      Blank()
        .width(4)
        .height(16)
        .backgroundColor($r('app.color.primary_color'))
        .margin({right:8})
      Text(this.title)
        .fontSize(16)
        .lineHeight(16)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.font_primary'))
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .margin({top:10,bottom:10,left:0})
    .width('100%')
  }
}


// 预约信息
@Component
struct orderContent {
  @Prop orderContent?: OrderItemType;
  aboutToAppear() {


  }
  build() {
    Column(){
      orderContentTitle({title:'预约信息'})
      Row(){
        Text('就诊城市')
          .orderFormLabelStyle()
        Text(this.orderContent?.order_content?.city)
          .orderFormValueStyle()
      }
      .orderItemRowStyle()
      Row(){
        Text('就诊医院')
          .orderFormLabelStyle()
        Text(this.orderContent?.order_content.hospital)
          .orderFormValueStyle()
      }
      .orderItemRowStyle()
      Row(){
        Text('就诊时间')
          .orderFormLabelStyle()
        Text(this.orderContent?.starttime)
          .orderFormValueStyle()
      }
      .orderItemRowStyle()
      Row(){
        Text('预约人')
          .orderFormLabelStyle()
        Text(this.orderContent?.order_content?.order_name)
          .orderFormValueStyle()
      }
      .orderItemRowStyle()
      Row(){
        Text('预约人电话')
          .orderFormLabelStyle()
        Text(this.orderContent?.order_content?.order_mobile)
          .orderFormValueStyle()
      }
      .orderItemRowStyle()
      Row(){
        Text('陪诊师性别')
          .orderFormLabelStyle()
        Text(this.orderContent?.order_content?.order_sex)
          .orderFormValueStyle()
      }
      .orderItemRowStyle()
      Row(){
        Text('服务要求')
          .orderFormLabelStyle()
        Text(this.orderContent?.order_remark)
          .orderFormValueStyle()
      }
      .orderItemRowStyle()
    }.orderColumnStyle()
  }
}

// 就诊人信息
@Component
struct patientContent {
  @Prop orderContent: OrderItemType;
  @State patientInfo:Record<string,string | number | Resource > = {}

  aboutToAppear() {
    if (this.orderContent) {
      this.patientInfo = {
        '姓名':this.orderContent.patient_content.patient_name,
        '性别':this.orderContent.patient_content.patient_sex,
        '年龄':this.orderContent.patient_content.patient_age,
        '手机号':this.orderContent.patient_content.patient_mobile,
        '行动能力':this.orderContent.patient_content.patient_move,
      }
    }
    console.log('orderContent-patientInfo',JSON.stringify(this.patientInfo))

  }
  build() {
    Column(){
      orderContentTitle({title:'就诊人信息'})
      ForEach(Object.keys(this.patientInfo),(key:string)=>{
        Row(){
          Text(key)
            .orderFormLabelStyle()
          Text(`${this.patientInfo[key]}`)
            .orderFormValueStyle()
        }
        .orderItemRowStyle()
      })
    }.orderColumnStyle()
  }
}
// 订单信息
@Component
struct orderDec {
  @Require @Prop orderContent: OrderItemType;

  @State orderInfo:Record<string,string | number | Resource | undefined > = {}

  aboutToAppear() {
    if (this.orderContent) {
      this.orderInfo = {
        '服务内容':this.orderContent.service_name,
        '服务标价':`￥ ${this.orderContent.serve_amount}`,
        '订单金额':`￥ ${this.orderContent.mainGood.price}`,
        '订单编号':this.orderContent.orderID,
        '下单日期':this.orderContent._add_time_str,
      }
    }
    console.log('orderDec',JSON.stringify(this.orderContent))
    console.log('orderDec-orderInfo',JSON.stringify(this.orderInfo))

  }
  build() {
    Column(){
      orderContentTitle({title:'订单信息'})
      ForEach(Object.keys(this.orderInfo),(key:string)=>{
        Row(){
          Text(key)
            .orderFormLabelStyle()
          Text(`${this.orderInfo[key]}`)
            .orderFormValueStyle()
        }
        .orderItemRowStyle()
      })
    }.orderColumnStyle()
  }
}
// 通用样式
@Extend(Text) function orderFormLabelStyle() {
  .fontColor($r('app.color.gray_8'))
  .fontSize($r('app.float.body_text'))
  .fontWeight(FontWeight.Medium)
  .height(32)                  // 固定高度
  .lineHeight(32)               // 行高与高度一致
  .textAlign(TextAlign.Start)
  .width('33%')
}

@Extend(Text) function orderFormValueStyle() {
  .fontColor($r('app.color.gray_6'))
  .fontSize($r('app.float.body_text'))
  .fontWeight(FontWeight.Medium)
  .height(32)                  // 固定高度
  .lineHeight(32)               // 行高与高度一致
  .textAlign(TextAlign.Start)
  .width('67%')
}

@Extend(Column) function orderColumnStyle() {
  .justifyContent(FlexAlign.SpaceBetween)
  .margin({left:16,right:16,bottom:10})
  .padding(16)
  .backgroundColor($r('app.color.color_white'))
  .borderRadius($r('app.float.card_radius'))
}

@Extend(Row) function orderItemRowStyle() {
  .width('100%')
  .alignItems(VerticalAlign.Center)
  .justifyContent(FlexAlign.SpaceBetween)
  .padding({bottom:10})
}

