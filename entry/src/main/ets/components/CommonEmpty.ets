@Component
export struct CommonEmpty {

  private title: string = '暂无数据'

  build() {
    Stack(){
      Column() {
        //显示没有订单图标
        Image($r('app.media.noData'))
          .height(80)
          .width(80)
          .fillColor($r('app.color.gray_4'))
        Text(this.title)
          .fontSize($r('app.float.body_text'))
          .fontColor($r('app.color.gray_6'))
          .margin({ top: 20 })
          .fontWeight(FontWeight.Normal)
      }
    }
    .width('100%')
    .layoutWeight(1)
  }
}