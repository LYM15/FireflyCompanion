import { getOrderStatusColor} from '../api/orderStatusConfig'
// @Entry
@Component
export struct orderProgressDec {
  @Prop orderTypeId: number

  build() {
    Row() {
      ImageIcon()
      Column(){
        if(this.orderTypeId===205){
          Column() {
            Text("订单已取消")
              .decTitle()
              .fontColor(getOrderStatusColor(205))
            Text("期待下次为您服务，如需帮助可咨询客服")
              .decContent()
              .fontColor("#ff7a7a7a")
          }.alignItems(HorizontalAlign.Start)
        }else if(this.orderTypeId===202){
          Column() {
            Text("正在为您安排服务专员...")
              .decTitle()
              .fontColor(getOrderStatusColor(202))
            Text("请保持手机畅通，稍后将有服务专员与您联系")
              .decContent()
              .fontColor("#ff7a7a7a")
          }.alignItems(HorizontalAlign.Start)
        }else if(this.orderTypeId===204){
          Column() {
            Text("服务已完成")
              .decTitle()
              .fontColor(getOrderStatusColor(204))
            Text("感谢您的使用，如有售后问题请联系客服")
              .decContent()
              .fontColor("#ff7a7a7a")
          }.alignItems(HorizontalAlign.Start)
        }else if(this.orderTypeId===201){
          Row() {
            Column(){
              Row(){
                Text("订单待支付")
                  .decTitle()
                  .fontColor(getOrderStatusColor(201))
                  .margin(0)
                  // .lineHeight(30)
                Button(`支付`, { type: ButtonType.Normal, stateEffect: true })
                  .borderRadius($r('app.float.card_radius'))
                  .fontSize($r('app.float.body_text'))
                  .fontWeight(FontWeight.Bold)
                  .backgroundColor($r('app.color.primary_color'))
                  .width(50)
                  .height(30)
                  .padding(0)
                  .onClick(() => {
                  })
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Top)
              .width('100%')

              Row(){
                Text("请在").decContent()
                // counter({allSeconds:this.allSeconds})
                Text("内完成支付，超时订单自动取消").decContent()
              }.alignItems(VerticalAlign.Center)
            }.width('100%').alignItems(HorizontalAlign.Start)
          }.width('100%').justifyContent(FlexAlign.SpaceBetween)
        }
      }.layoutWeight(1)
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
  }
}

@Preview
@Component
struct ImageIcon{
  build() {
    Stack() {
      Image($r('app.media.tab_firefly_block'))
        .width(30)
        .height(30)
        .fillColor($r('app.color.color_white'))
    }.width(36).height(50).borderRadius($r('app.float.card_radius')).backgroundColor($r('app.color.green_7')).margin({right:8})
  }
}

// 通用样式
@Extend(Text) function decTitle() {
  .fontColor($r('app.color.gray_6'))
  .fontSize(16)
  .fontWeight(FontWeight.Medium)
  .textAlign(TextAlign.Start)
  .margin({bottom:6})
}

@Extend(Text) function decContent() {
  .fontColor($r('app.color.gray_8'))
  .fontSize($r('app.float.body_text_s'))
  .fontWeight(FontWeight.Normal)
  .textAlign(TextAlign.Start)
}

@Extend(Text) function decStatusText() {
  .fontColor($r('app.color.gray_8'))
  .fontSize($r('app.float.body_text'))
  .fontWeight(FontWeight.Normal)
  .textAlign(TextAlign.End)
}