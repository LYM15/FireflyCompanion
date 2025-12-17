/**
 * 提示弹窗的参数类
 */
export class ImgActionParams {
  text: ResourceStr = '提示';
  text2: ResourceStr = '';
  type: 'success' | 'warning' | 'error' | 'normal' = 'success'; // 默认 success

  constructor(text: ResourceStr, text2: ResourceStr, type?: 'success' | 'warning' | 'error' | 'normal') {
    this.text = text;
    this.text2 = text2;
    if (type) this.type = type;
  }
}

/**
 * 构建带图标的提示内容
 * @param params 文本参数
 * @param type 图标类型
 */
@Builder
export function buildImgActionTips(
  params: ImgActionParams
) {
    Row() {
      if(!params.type || params.type === 'success'){
        Image($r('app.media.toast_icon_check_filled'))
          .ImageIconStyle()
          .fillColor($r('app.color.success_color'))
      }else if( params.type === 'warning'){
        Image($r('app.media.toast_icon_info_filled'))
          .ImageIconStyle()
          .fillColor($r('app.color.warning_color'))
      }else if( params.type === 'error'){
        Image($r('app.media.toast_icon_close_filled'))
          .ImageIconStyle()
          .fillColor($r('app.color.danger_color'))
      }else if( params.type === 'normal'){
        Image($r('app.media.toast_icon_info_filled'))
          .ImageIconStyle()
          .fillColor($r('app.color.font_fourth'))
      }
      Text(params.text)
        .fontSize(16)
        .fontColor($r('app.color.font_primary'))
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.color_white'))
    .padding({ left: 24, right: 24 })
    .height(50)
    .borderRadius(24)
}

// 通用样式
@Extend(Image) function ImageIconStyle() {
  .fillColor('rgba(255,255,255,.4)')
  .width(24)
  .height(24)
  .margin({ right: 8 })
}

// 确认弹窗的方法
/**
 * 提示弹窗的参数类
 */
export interface ConfirmDialogOptions {
  title?: ResourceStr
  content?: ResourceStr
  cancelBtnText?: ResourceStr
  confirmBtnText?: ResourceStr
  showCancelBtn?: boolean
  clickConfirmBtn?: () => void
  clickCancelBtn?: () => void
}

export class ConfirmActionParams {
  title: ResourceStr = '提示';
  content: ResourceStr = '';
  cancelBtnText: ResourceStr = '取消';
  confirmBtnText: ResourceStr = '确定';
  showCancelBtn: boolean = true; // 默认true
  clickConfirmBtn?: () => void;
  clickCancelBtn?: () => void;

  constructor(options?: ConfirmDialogOptions) {
    if (!options) return
    if (options.title !== undefined) this.title = options.title
    if (options.content !== undefined) this.content = options.content
    if (options.cancelBtnText !== undefined) this.cancelBtnText = options.cancelBtnText
    if (options.confirmBtnText !== undefined) this.confirmBtnText = options.confirmBtnText
    if (options.showCancelBtn !== undefined) this.showCancelBtn = options.showCancelBtn
    if (options.clickConfirmBtn) this.clickConfirmBtn = options.clickConfirmBtn
    if (options.clickCancelBtn) this.clickCancelBtn = options.clickCancelBtn
  }
}

@Builder
// 构建确认弹窗
export function buildConfirmDialogComponent(params: ConfirmActionParams) {
  Column() {
    Column() {
      Text(params.title).fontSize(20)
        .fontWeight(FontWeight.Bold)
      if(params.content){
        Text(params.content)
          .fontSize(16)
          .fontColor(Color.Gray)
      }
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .height(120)

    Row() {
      if (params.showCancelBtn) {
        buildDialogButton(params.cancelBtnText, params.clickCancelBtn)
      }
      buildDialogButton(params.confirmBtnText, params.clickConfirmBtn)
    }
    .height(50)
  }
  .width(350)
  .padding({ bottom: 8 })
  .borderRadius(32)
  .backgroundColor($r('app.color.color_white'))
}

/**
 * 通用按钮
 */
@Builder
function buildDialogButton(text: ResourceStr, onClick?: () => void) {
  Text(text)
    .fontColor('#0A59F7')
    .width('50%')
    .height('100%')
    .textAlign(TextAlign.Center)
    .onClick(() => {
      if (onClick) {
        onClick()
      }
    })
}

