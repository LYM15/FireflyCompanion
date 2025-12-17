import { router } from '@kit.ArkUI'

@ComponentV2
export struct CommonHeader {
  @Param title: string | Resource = '首页';
  @Param showTitle: boolean = true;
  @Param showLeftMenu: boolean = false;
  @Param showRightMenu: boolean = false;
  @Param bgColor: ResourceColor | string = $r('app.color.color_white');

  build() {
    Row() {
      Row() {
        Row() {
          if (this.showLeftMenu) {
            Stack(){
              Image($r('app.media.icon_arrow_left'))
                .width(20)
                .height(20)
            }
            .width(30).height(30)
            .backgroundColor($r('app.color.gray_1'))
            .borderRadius($r('app.float.card_radius'))
            .onClick(() => {
              router.back()
            })
          }
          if (this.showTitle) {
            Text(this.title)
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor($r('app.color.font_primary'))
              .margin({ left: 8 })
          }
        }
      }
    }
    .height(56)
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .shadow({
      offsetX: 0,
      offsetY: 4,
      color: '#1A000000',
      radius: 0,
    })
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.bgColor)
  }
}