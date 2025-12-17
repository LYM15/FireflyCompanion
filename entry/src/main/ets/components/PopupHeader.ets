@Entry
@Component
export struct PopupHeader {
  private title: string = '标题'//标题信息
  private cancelText: string = '取消'
  private confirmText: string = '确定'
  cancel: () => void = () => {
  };
  confirm: () => void = () => {
  };

  build() {
    Row() {
      Text(this.cancelText)
        .fontSize(18)
        .fontWeight(FontWeight.Normal)
        .fontColor($r('app.color.font_tertiary'))
        .onClick(()=>{
          this.cancel()
        })
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Text(this.confirmText)
        .fontSize(18)
        .fontWeight(FontWeight.Normal)
        .fontColor($r('app.color.primary_color'))
        .onClick(()=>{
          this.confirm()
        })
    }
    .width('100%')
    .height(44)
    .padding({left:16,right:16})
    .margin({bottom:20,top:16})
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}