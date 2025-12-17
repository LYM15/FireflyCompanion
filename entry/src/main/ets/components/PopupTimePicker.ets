import { PopupHeader } from './PopupHeader'

export type PickerMode = 'date' | 'time' | 'datetime'

@Component
export struct PopupDateTimePicker {
  @Prop title: string = '请选择'
  @Prop isLunar: boolean = false // 是否显示农历（仅对 DatePicker 有效）
  @Prop defaultDate: Date  // 默认日期
  @Prop fieldKey:string = '' // 用于标记是哪一项选择
  @Prop mode: PickerMode = 'datetime'   // 选择器模式
  @Prop isMilitaryTime: boolean = true;  // 是否使用24小时制
  @Prop startDate: Date   // 起始日期
  @Prop endDate: Date ;  // 结束日期 起始日期后100年  // new Date(new Date().setFullYear(new Date().getFullYear() + 100))
  @Prop startTime: string = '00:00';  // 起始时间
  @Prop endTime: string = '23:59';  // 结束时间

  @State private selectedDate: Date = this.defaultDate   // 选择的日期
  @State private selectedTime: Date = this.defaultDate   // 选择的时间

  @Link isShow: boolean

  // 把选中的值和 fieldKey 传给父组件
  confirm: (value: Date,key?:string) => void = () => {}
  cancel: () => void = () => {}

  // 把 selectedDate 和 selectedTime 合并为一个完整的 Date
  private combineDateTime(): Date {
    let result = new Date(this.selectedDate)
    result.setHours(this.selectedTime.getHours(), this.selectedTime.getMinutes(), this.selectedTime.getSeconds())
    return result
  }

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
          // this.confirm(this.selectedDate,this.fieldKey)
          this.confirm(this.combineDateTime(), this.fieldKey) // 返回完整时间
        }
      })
      Stack(){
        if(this.mode === 'date'){
          DatePicker({
            start: this.startDate,
            end: this.endDate,
            selected: this.selectedDate,
          })
            .DatePickerStyle()
            .lunar(this.isLunar)
            .onDateChange((value: Date) => {
              this.selectedDate = value
              console.info('select current date is: ' + value.toString());
            })
            .width('100%')
            .onAppear(() => {
              // 初始化默认值
              this.selectedDate = this.defaultDate
            })
        }
        else if(this.mode === 'time'){
          TimePicker({
            selected: this.selectedTime
          })
            .TimePickerStyle()
            .useMilitaryTime(this.isMilitaryTime)
            .onChange((value: TimePickerResult) => {
              if (value.hour >= 0) {
                this.selectedTime.setHours(value.hour, value.minute);
                console.info('select current time is: ' + JSON.stringify(value));
              }
            })
            .onAppear(() => {
              // 初始化默认时间
              this.selectedTime = this.defaultDate
            })
        }
        // 日期时间模式
        else if(this.mode === 'datetime'){
          Row(){
            DatePicker({
              start: this.startDate,
              end: this.endDate,
              selected: this.selectedDate,
            })
              .DatePickerStyle()
              .lunar(this.isLunar)
              .onDateChange((value: Date) => {
                this.selectedDate = value
                console.info('select current date is: ' + value.toString());
              })
              .onAppear(() => {
                // 初始化默认值
                this.selectedDate = this.defaultDate
              })
              .width('60%')
            TimePicker({
              selected: this.selectedTime
            })
              .TimePickerStyle()
              .useMilitaryTime(this.isMilitaryTime)
              .loop(true) // 支持滚动循环
              .dateTimeOptions({ hour: "numeric", minute: "2-digit", second: "2-digit" }) // 设置时间格式
              .onChange((value: TimePickerResult) => {
                if (value.hour >= 0) {
                  this.selectedTime.setHours(value.hour, value.minute);
                  console.info('select current time is: ' + JSON.stringify(value));
                }
              })
              .onAppear(() => {
                this.selectedTime = this.defaultDate
              })
              .width('40%')
          }
        }
      }.padding({left:8,right:8})
    }
    .width('100%')
    .height(300)
    .backgroundColor($r('app.color.color_white'))
  }
}

// ============ 公共样式 ============
@Extend(DatePicker) function DatePickerStyle() {
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
}
@Extend(TimePicker ) function TimePickerStyle() {
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
}

