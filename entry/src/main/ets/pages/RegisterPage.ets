// pages/RegisterPage.ets
import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import { RegisterUtils } from '../utils/RegisterUtils';
import CommonUtils from '../utils/CommonUtils';
import MultipleDevicesUtils from '../utils/MultipleDevicesUtils';
import router from '@ohos.router';

@Entry
@Component
struct RegisterPage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;

  onPageShow() {
    MultipleDevicesUtils.register();
  }

  build() {
    GridRow({
      columns: {
        sm: StyleConstants.COLUMNS_SM,
        md: StyleConstants.COLUMNS_MD,
        lg: StyleConstants.COLUMNS_LG
      },
      gutter: {
        x: StyleConstants.GRID_GUTTER
      }
    }) {
      GridCol({
        span: {
          sm: StyleConstants.SPAN_SM,
          md: StyleConstants.SPAN_MD,
          lg: StyleConstants.SPAN_LG
        }, offset: {
          md: StyleConstants.OFFSET_MD,
          lg: StyleConstants.OFFSET_LG
        }
      }) {
        Column({}) {
          // Title component
          RegisterTitle()
          // Bottom component
          RegisterBottom()
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
    }
    .backgroundColor($r('app.color.color_bg'))
    .width('100%')
    .height('100%')
  }
}

@Component
struct RegisterTitle {
  build() {
    Column() {
      Image($r('app.media.fireflyBlockBold'))
        .width($r('app.float.logo_image_size'))
        .height($r('app.float.logo_image_size'))
        .margin({ bottom: $r('app.float.logo_margin_bottom') })
      Text('注册账号')
        .fontSize($r('app.float.title_text'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.font_primary'))
      Text('创建您的新账号')
        .fontSize($r('app.float.body_text'))
        .fontColor($r('app.color.font_secondary'))
        .margin({
          top: $r('app.float.margin_top'),
          bottom: $r('app.float.margin_bottom')
        })
    }
    .backgroundColor($r('app.color.color_bg'))
    .justifyContent(FlexAlign.Center)
    .width(StyleConstants.FULL_PARENT)
    .height(StyleConstants.LOGIN_LOGO_HEIGHT)
  }
}

@Component
struct RegisterBottom {
  @State account: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';
  @State nickname: string = '';

  build() {
    Column() {
      Column() {
        // 昵称输入
        TextInput({ placeholder: '请输入昵称' })
          .maxLength(StyleConstants.INPUT_ACCOUNT_LENGTH)
          .type(InputType.Normal)
          .inputStyleExtend()
          .onChange((value: string) => {
            this.nickname = value;
          })

        Line()
          .width(StyleConstants.FULL_PARENT)
          .height($r('app.float.line_height'))
          .margin({
            left: $r('app.float.line_margin_left'),
            right: $r('app.float.line_margin_left')
          })
          .backgroundColor($r('app.color.line_border'))

        // 账号输入
        TextInput({ placeholder: '请输入账号' })
          .maxLength(StyleConstants.INPUT_ACCOUNT_LENGTH)
          .type(InputType.Normal)
          .inputStyleExtend()
          .onChange((value: string) => {
            this.account = value;
          })

        Line()
          .width(StyleConstants.FULL_PARENT)
          .height($r('app.float.line_height'))
          .margin({
            left: $r('app.float.line_margin_left'),
            right: $r('app.float.line_margin_left')
          })
          .backgroundColor($r('app.color.line_border'))

        // 密码输入
        TextInput({ placeholder: '请输入密码' })
          .maxLength(StyleConstants.INPUT_PASSWORD_LENGTH)
          .type(InputType.Password)
          .inputStyleExtend()
          .onChange((value: string) => {
            this.password = value;
          })

        Line()
          .width(StyleConstants.FULL_PARENT)
          .height($r('app.float.line_height'))
          .margin({
            left: $r('app.float.line_margin_left'),
            right: $r('app.float.line_margin_left')
          })
          .backgroundColor($r('app.color.line_border'))

        // 确认密码
        TextInput({ placeholder: '请确认密码' })
          .maxLength(StyleConstants.INPUT_PASSWORD_LENGTH)
          .type(InputType.Password)
          .inputStyleExtend()
          .onChange((value: string) => {
            this.confirmPassword = value;
          })
      }
      .backgroundColor($r('app.color.color_white'))
      .borderRadius($r('app.float.card_radius'))

      // 注册按钮
      Button('注册')
        .id(CommonConstants.REGISTER_BUTTON_ID)
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
          RegisterUtils.registerArkTS(this.account, this.password, this.confirmPassword, this.nickname);
        })

      // 返回登录
      Row() {
        Text('已有账号？')
          .fontColor($r('app.color.font_secondary'))
          .fontSize($r('app.float.body_text'))
        Text('返回登录')
          .blueTextStyleExtend()
          .onClick(() => {
            router.back();
          })
      }
      .justifyContent(FlexAlign.Center)
      .width(StyleConstants.FULL_PARENT)
      .margin({ top: $r('app.float.margin_top') })
    }
    .backgroundColor($r('app.color.background'))
    .width(300)
    .padding(20)
  }
}

// 扩展函数
@Extend(TextInput) function inputStyleExtend() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.big_btn_height'))
  .fontSize($r('app.float.body_text'))
  .backgroundColor($r('app.color.color_white'))
  .margin({
    top: $r('app.float.login_input_margin_top'),
    bottom: $r('app.float.login_input_margin_bottom')
  })
  .padding({ left: StyleConstants.INPUT_PADDING_LEFT })
  .width('100%')
}

@Extend(Text) function blueTextStyleExtend() {
  .fontColor($r('app.color.primary_4'))
  .fontSize($r('app.float.body_text_s'))
  .fontWeight(FontWeight.Medium)
}