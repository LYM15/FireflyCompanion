import { orderListData ,OrderItemType} from '../mock/OrderListData'
import { ORDER_CODE_STATUS, ORDER_STATUS_COLOR } from '../api/orderStatusConfig'
import { CommonEmpty } from '../components/CommonEmpty'
import CommonUtils from '../utils/CommonUtils'
import CommonConstants from '../constants/CommonConstants';
import { router } from '@kit.ArkUI';

// @Entry
@Component
export default struct orderList {
  // @Prop orderTypeId:number
  @State orderDataFilter:OrderItemType[] = orderListData
  @Prop @Watch('updateFilter') orderTypeId: number;

  // 数据筛选
  // 根据 orderTypeId 过滤数据
  filterOrderData(orderTypeId: number): OrderItemType[] {
    if(orderTypeId== 0){
      return orderListData
    }else{
      const filtered: OrderItemType[] = [];
      for (let i = 0; i < orderListData.length; i++) {
        const item = orderListData[i];
        if (orderTypeId === item.mainGood.type) {
          filtered.push(item);
        }
      }
      return filtered;
    }
  }

  // 调用 filter 并更新状态
  updateFilter(orderTypeId: number) {
    this.orderDataFilter = this.filterOrderData(orderTypeId);
  }

  aboutToAppear(): void {
    this.updateFilter(this.orderTypeId)
  }


  build() {
    Column() {
      List({ space: 20 }){
        if(this.orderDataFilter.length > 0){
          ForEach(this.orderDataFilter,(item:OrderItemType)=>{
            ListItem() {
              orderItem({item:item})
            }.onClick(()=>{
              console.log('路由跳转：',CommonConstants.TAG_ORDER_DEC_PAGE)
              router.pushUrl({
                url: 'pages/OrderDecPage',
                params: {
                  orderId: item.orderID,
                  orderTypeId:item.mainGood.type
                }
              })
            })
          }, (item: OrderItemType) => JSON.stringify(item.orderID))
        }else{
          CommonEmpty({title:'没有订单数据'})
        }
      }.margin({top:20})
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct orderItem {
  private item?: OrderItemType;

  private gridItemServiceName?: string
  private gridItemServiceImg?: string | Resource;
  private gridItemOrderID?: string
  private gridItemOrderPrice?: number
  private gridItemOrderCity?: string
  private gridItemOrderHospital?: string
  private gridItemOrderPatientName?: string
  private gridItemOrderServeTime?: string | number | undefined
  private gridItemOrderCreateTime?: string| number | undefined
  private gridItemOrderType?: number

  getOrderStatusText(code:number){
    return ORDER_CODE_STATUS[code] || '未知状态';
  }

  getOrderStatusColor(code: number): string | Resource {
    const statusText = ORDER_CODE_STATUS[code];
    if (!statusText) return '#999999';
    return ORDER_STATUS_COLOR[statusText] || '#999999';
  }

  aboutToAppear() {
    if (this.item !== undefined) {
      this.gridItemServiceName = this.item.service_name;
      this.gridItemServiceImg = this.item.serviceImg;
      this.gridItemOrderID = this.item.orderID;
      this.gridItemOrderPrice = this.item.mainGood.price;
      this.gridItemOrderCity = this.item.order_content.city;
      this.gridItemOrderHospital = this.item.order_content.hospital;
      this.gridItemOrderPatientName = this.item.patient_content.patient_name;
      this.gridItemOrderServeTime = this.item.order_content.serve_time;
      this.gridItemOrderCreateTime = this.item.create_time;
      this.gridItemOrderType = this.item.mainGood.type;
    }
  }
  build() {
    Stack(){
      Column(){
        Row(){
          Text(this.gridItemServiceName)
            .fontColor($r('app.color.font_primary'))
            .fontSize($r('app.float.title_text_s'))
            .fontWeight(FontWeight.Medium)
          Text(`${this.getOrderStatusText(this.gridItemOrderType)}`)
            .fontColor(this.getOrderStatusColor(this.gridItemOrderType as number))
            .fontSize($r('app.float.body_text'))
        }
        .margin({bottom:16})
        .orderRowItemStyle()
        Row(){
          Image(this.gridItemServiceImg)
            .width(60)
            .height(60)
            .backgroundColor($r('app.color.green_1'))
            .borderRadius($r('app.float.card_radius'))
            .syncLoad(true)
            .padding(8)
            .margin({right:10})
          Column(){
            Text(`￥ ${this.gridItemOrderPrice}`)
              .width('100%')
              .fontColor($r('app.color.font_primary'))
              .fontSize($r('app.float.subtitle_text_l'))
            Text(`订单号： ${this.gridItemOrderID}`)
              .orderItemLabelStyle()
              .width('100%')
          }.width('100%')
        }.width('100%')
        Grid() {
            GridItem() {
              Row(){
                Text(`就诊城市`)
                  .orderItemLabelStyle()
                Text(`${this.gridItemOrderCity}`)
                  .orderItemValueStyle()
              }
            }.height(24)
          GridItem() {
            Row(){
              Text(`就诊医院`)
                .orderItemLabelStyle()
              Text(`${this.gridItemOrderHospital}`)
                .orderItemValueStyle()
            }
          }
          GridItem() {
            Row(){
              Text(`就诊人`)
                .orderItemLabelStyle()
              Text(`${this.gridItemOrderPatientName}`)
                .orderItemValueStyle()
            }
          }
          GridItem() {
            Row(){
              Text(`就诊时间`)
                .orderItemLabelStyle()
              Text(`${this.gridItemOrderServeTime}`)
                .orderItemValueStyle()
            }
          }
        }
        .columnsTemplate('1fr 2fr')
        .rowsTemplate('1fr 1fr')
        .height(60)
        .width('100%')
        .margin($r('app.float.common_margin'))
        Row(){
          Text(`下单时间： ${this.gridItemOrderCreateTime}`).orderItemLabelStyle()
          if(this.gridItemOrderType === 201){
            Button('状态', { type: ButtonType.Capsule, stateEffect: true })
              .orderButtonStyle()
          }
        }
        .orderRowItemStyle()
      }
      .width('100%')
      .padding(16)
      .shadow({
        radius: 15,  // 阴影半径（模糊程度）
        color: $r('app.color.gray_3'), // 阴影颜色
        offsetX: 10,  // X轴偏移量
        offsetY: 10   // Y轴偏移量
      })
    }
    .width('100%')
    // .border({color:$r('app.color.gray_3'),width:1,style:BorderStyle.Solid})
    .shadow({
      radius: 10,  // 阴影半径（模糊程度）
      color: $r('app.color.gray_3'), // 阴影颜色
      offsetX: 10,  // X轴偏移量
      offsetY: -10   // Y轴偏移量
    })
  }
}

@Extend(Text) function orderItemLabelStyle() {
  .fontColor($r('app.color.gray_6'))
  .fontSize($r('app.float.body_text'))
  .fontWeight(FontWeight.Normal)
  .height(32)                  // 固定高度
  .lineHeight(32)               // 行高与高度一致
  .textAlign(TextAlign.Start)
  .margin({right:4})
}

@Extend(Text) function orderItemValueStyle() {
  .fontColor($r('app.color.gray_8'))
  .fontSize($r('app.float.body_text'))
  .fontWeight(FontWeight.Normal)
  .height(32)                  // 固定高度
  .lineHeight(32)               // 行高与高度一致
  .textAlign(TextAlign.Start)
  .layoutWeight(1)
}

@Extend(Button) function orderButtonStyle() {
  .width('80')
  .height('28')
  .backgroundColor($r('app.color.danger_color'))
  .fontColor($r('app.color.color_white'))
  .fontSize($r('app.float.body_text'))
  .alignSelf(ItemAlign.Center)
  .align(Alignment.Center)
}

@Extend(Row) function orderRowItemStyle() {
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
  .alignItems(VerticalAlign.Center)
}
