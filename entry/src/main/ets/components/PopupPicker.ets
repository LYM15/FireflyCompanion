import { PopupHeader } from './PopupHeader'


@Component
export struct PopupPicker {
  @Prop title: string = '请选择'
  @Prop options: string[] = []
  @Prop defaultIndex: number = 0
  @Prop fieldKey:string = '' // 用于标记是哪一项选择


  @State private currentIndex: number = 0
  @State private currentValue: string = ''

  @Link isShow: boolean

  // 把选中的值和 fieldKey 传给父组件
  confirm: (value: string, index: number,key?:string) => void = () => {}
  cancel: () => void = () => {}

  build() {
    Column() {
      // 头部
      PopupHeader({
        title: this.title,
        cancelText: '取消',
        confirmText: '确定',
        cancel: () => {
          this.isShow = false
          this.cancel()
        },
        confirm: () => {
          this.isShow = false
          this.confirm(this.currentValue, this.currentIndex,this.fieldKey)
        }
      })

      // 选择器
      TextPicker({
        range: this.options,
        selected: this.defaultIndex
      })
        .onChange((value: string | string[], index: number | number[]) => {
          this.currentValue = value as string
          this.currentIndex = index as number
        })
        .textStyle({
          color: $r('app.color.font_primary'),
          font: { size: $r('app.float.title_text_s'), weight: FontWeight.Normal }
        })
        .selectedTextStyle({
          color: $r('app.color.primary_6'),
          font: { size: $r('app.float.title_text_s'), weight: FontWeight.Bold }
        })
        .disappearTextStyle({
          color: $r('app.color.font_primary'),
          font: { size: $r('app.float.title_text_s'), weight: FontWeight.Normal }
        })
        .gradientHeight(100)
        .canLoop(this.options.length > 4)
        .width('100%')
        .onAppear(() => {
          // 初始化默认值
          this.currentIndex = this.defaultIndex
          this.currentValue = this.options[this.defaultIndex] ?? ''
        })
    }
    .width('100%')
    .height(300)
    .backgroundColor($r('app.color.color_white'))
  }
}
