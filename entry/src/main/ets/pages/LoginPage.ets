// 登录页面
import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import LoginUtils from '../utils/LoginUtils';
import CommonUtils from '../utils/CommonUtils'
import MultipleDevicesUtils from '../utils/MultipleDevicesUtils';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct LoginPage {
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
          LoginTitle()
          // Bottom component
          LoginBottom()

        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
    }
    .backgroundColor($r('app.color.color_bg'))
    .width('100%')

  }
}

// @Preview
@Component
struct LoginTitle {
  build() {
    Column() {
      Image($r('app.media.fireflyBlockBold'))
        .width($r('app.float.logo_image_size'))
        .height($r('app.float.logo_image_size'))
        .margin({ bottom: $r('app.float.logo_margin_bottom') })
      Text($r('app.string.logo_title'))
        .fontSize($r('app.float.title_text'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.font_primary'))
      Text($r('app.string.logo_subtitle'))
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

@Preview
@Component
struct LoginBottom {
  @State account: string = '';
  @State password: string = '';

  build() {
    Column() {
      Column() {
        TextInput({ placeholder: $r('app.string.account') })
          .maxLength(StyleConstants.INPUT_ACCOUNT_LENGTH)
          .type(InputType.Normal)
          .inputStyle()
          .onChange((value: string) => {
            this.account = value;
          })
          .width('100%')

        Line()
          .width(StyleConstants.FULL_PARENT)
          .height($r('app.float.line_height'))
          .margin({
            left: $r('app.float.line_margin_left'),
            right: $r('app.float.line_margin_left')
          })
          .backgroundColor($r('app.color.line_border'))

        TextInput({ placeholder: $r('app.string.password') })
          .maxLength(StyleConstants.INPUT_PASSWORD_LENGTH)
          .type(InputType.Password)
          .inputStyle()
          .onChange((value: string) => {
            this.password = value;
          })
      }
      .backgroundColor($r('app.color.color_white'))
      .borderRadius($r('app.float.card_radius'))

      Row() {
        Text($r('app.string.message_login'))
          .blueTextStyle()
          .onClick(() => {
            CommonUtils.showToastContent($r('app.string.incomplete_toast'));
          })
        Text($r('app.string.forgot_password'))
          .blueTextStyle()
          .onClick(() => {
            CommonUtils.showToastContent($r('app.string.incomplete_toast'));
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(StyleConstants.FULL_PARENT)
      .margin({ top: $r('app.float.margin_top') })
      // .padding({
      //   left: $r('app.float.padding_left'),
      //   right: $r('app.float.padding_right')
      // })
      .width('100%')

      Button($r('app.string.login'))
        .id(CommonConstants.LOGIN_BUTTON_ID)
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
          LoginUtils.loginArkTS(this.account, this.password);
        })
        .width('100%')

      // 在 LoginBottom 组件中修改注册按钮
      Text($r('app.string.register_account'))
        .fontColor($r('app.color.primary_color'))
        .fontSize($r('app.float.body_text'))
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          router.pushUrl({
            url: 'pages/RegisterPage'
          }, router.RouterMode.Standard, (err: Error) => {
            if (err) {
              console.error('Push url failed.' + JSON.stringify(err));
            }
          });
        })
    }
    .backgroundColor($r('app.color.background'))
    .height(StyleConstants.LOGIN_BOTTOM_HEIGHT)
    .width(300)

  }
}

@Extend(TextInput) function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.big_btn_height'))
  .fontSize($r('app.float.body_text'))
  .backgroundColor($r('app.color.color_white'))
  .margin({
    top: $r('app.float.login_input_margin_top'),
    bottom: $r('app.float.login_input_margin_bottom') })
  .padding({ left: StyleConstants.INPUT_PADDING_LEFT })
  .width('100%')
}

@Extend(Text) function blueTextStyle() {
  .fontColor($r('app.color.primary_4'))
  .fontSize($r('app.float.body_text_s'))
  .fontWeight(FontWeight.Medium)
}