import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import CommonUtils from '../utils/CommonUtils';
import ItemData from '../mock/ItemData';
import mainViewModel from '../mock/MainViewModel';
import Logger from '../utils/Logger';
import { ORDER_STATUS_MAP, ORDER_CODE_STATUS } from '../api/orderStatusConfig'
import { CommonHeader } from '../components/CommonHeader';
import { UserDataUtils, UserInfo } from '../utils/UserDataUtils';

// 用户信息接口
interface CurrentUserInfo {
  nickName: string;
  account: string;
}

// @Entry
@Component
export default struct MinePage {
  @State userInfo: CurrentUserInfo = { nickName: '我的', account: 'Mr. Ling' };
  // 添加状态控制提示框显示
  @State showLogoutDialog: boolean = false;

  goChangeOrderTab: (orderTypeId: number) => void = () => {}

  aboutToAppear() {
    this.loadUserInfo();
  }

  loadUserInfo() {
    try {
      console.info('=== 开始获取当前用户信息 ===');

      // 方法1: 从 AppStorage 获取当前用户
      if (AppStorage.has('currentUser')) {
        const currentUser = AppStorage.get('currentUser') as UserInfo;
        this.updateUserInfo(currentUser);
        console.info('从 AppStorage currentUser 获取用户信息:', currentUser);
        return;
      }

      // 方法2: 如果没有当前用户，尝试从用户列表中获取（这里可能需要知道当前是哪个用户）
      this.tryGetFromUserList();

    } catch (error) {
      Logger.error(CommonConstants.TAG_MINE_PAGE, '获取用户信息失败: ' + JSON.stringify(error));
      this.userInfo = { nickName: '我的', account: 'Mr. Ling' };
    }
  }

  tryGetFromUserList() {
    try {
      const userList = UserDataUtils.getUserList();
      console.info('用户列表:', userList);

      // 如果有用户列表，使用第一个用户作为演示（实际应该根据登录状态确定）
      if (userList && userList.length > 0) {
        const user = userList[0]; // 这里应该根据实际登录状态获取对应用户
        this.updateUserInfo(user);
        console.info('从用户列表获取用户信息:', user);
      } else {
        console.info('用户列表为空，使用默认信息');
        this.userInfo = { nickName: '我的', account: 'Mr. Ling' };
      }
    } catch (err) {
      console.error('从用户列表获取信息失败:', err);
    }
  }

  updateUserInfo(userData: UserInfo) {
    if (!userData) return;

    this.userInfo = {
      // 使用昵称，如果没有昵称则使用账号
      nickName: userData.nickname || userData.account || '我的',
      // 使用账号
      account: userData.account || 'Mr. Ling'
    };
  }

  /**
   * 显示退出登录确认对话框
   */
  showLogoutConfirm() {
    this.showLogoutDialog = true;
  }

  /**
   * 执行退出登录操作
   */
  performLogout() {
    Logger.info(CommonConstants.TAG_MINE_PAGE, '开始退出登录');

    // 清除当前用户信息
    try {
      AppStorage.setOrCreate('currentUser', undefined);
      console.info('已清除当前用户信息');
    } catch (err) {
      console.error('清除用户信息失败:', err);
    }

    // 关闭对话框
    this.showLogoutDialog = false;

    // 跳转到登录页面
    CommonUtils.routerPage(CommonConstants.LOGIN_PAGE_URL);
  }

  build() {
    Stack() {
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
          Column() {
            CommonHeader({title:$r('app.string.mine_title')})
            MineTitleView({ userInfo: this.userInfo })
            MineTabView({goChangeOrderTab:this.goChangeOrderTab})
            MineListView()
            Blank()

            // 修改按钮点击事件，调用显示确认对话框
            Button('退出登录')
              .width(StyleConstants.BUTTON_WIDTH)
              .height($r('app.float.big_btn_height'))
              .fontSize($r('app.float.body_text'))
              .fontColor($r('app.color.color_white'))
              .fontWeight(FontWeight.Medium)
              .backgroundColor($r('app.color.danger_color'))
              .margin({ bottom: $r('app.float.margin_bottom') })
              .onClick(() => {
                this.showLogoutConfirm();
              })
          }
          .height(StyleConstants.FULL_PARENT)
          .padding({
            left: $r('app.float.padding_left'),
            right: $r('app.float.padding_right')
          })
        }
      }
      .backgroundColor($r('app.color.background'))

      // 自定义确认对话框
      if (this.showLogoutDialog) {
        this.LogoutConfirmDialog()
      }
    }
  }

  // 自定义退出登录确认对话框
  @Builder
  LogoutConfirmDialog() {
    Column() {
      // 遮罩层
      Column() {
        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#000000')
      .opacity(0.5)
      .onClick(() => {
        // 点击遮罩层关闭对话框
        this.showLogoutDialog = false;
      })

      // 对话框内容
      Column() {
        Column() {
          Text($r('app.string.logout_title'))
            .fontSize($r('app.float.title_text'))
            .fontColor($r('app.color.font_primary'))
            .fontWeight(FontWeight.Bold)
            .margin({ top: 24, bottom: 12 })

          Text($r('app.string.logout_confirm_message'))
            .fontSize($r('app.float.body_text'))
            .fontColor($r('app.color.font_secondary'))
            .textAlign(TextAlign.Center)
            .margin({ left: 24, right: 24, bottom: 24 })

          // 按钮区域
          Row() {
            // 取消按钮
            Button($r('app.string.cancel'))
              .layoutWeight(1)
              .height(44)
              .fontSize($r('app.float.body_text'))
              .fontColor($r('app.color.font_primary'))
              .backgroundColor($r('app.color.background'))
              .borderRadius($r('app.float.card_radius'))
              .onClick(() => {
                this.showLogoutDialog = false;
              })

            // 确认按钮
            Button($r('app.string.confirm'))
              .layoutWeight(1)
              .height(44)
              .fontSize($r('app.float.body_text'))
              .fontColor($r('app.color.color_white'))
              .backgroundColor($r('app.color.danger_color'))
              .borderRadius($r('app.float.card_radius'))
              .margin({ left: 12 })
              .onClick(() => {
                this.performLogout();
              })
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 16 })
        }
        .width('80%')
        .backgroundColor($r('app.color.color_white'))
        .borderRadius($r('app.float.card_radius'))
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
  }
}

@Component
struct MineTitleView {
  // 将私有属性改为公共属性，通过构造函数传入
  userInfo: CurrentUserInfo = { nickName: '我的', account: 'Mr. Ling' };

  build() {
    Row() {
      Image($r('app.media.tab_firefly_block'))
        .width($r('app.float.mine_title_size'))
        .height($r('app.float.mine_title_size'))
      Column() {
        // 大字显示用户昵称
        Text(this.userInfo.nickName)
          .fontSize($r('app.float.title_text_l'))
          .fontColor($r('app.color.font_primary'))  // 修改为存在的颜色资源
          .fontWeight(FontWeight.Bold)

        // 小字显示用户账号
        Text(this.userInfo.account)
          .fontSize($r('app.float.body_text'))
          .fontColor($r('app.color.font_secondary'))  // 修改为存在的颜色资源
          .margin({ top: $r('app.float.mine_name_margin') })
      }
      .margin({ left: $r('app.float.mine_title_margin') })
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(VerticalAlign.Center)
    .width(StyleConstants.FULL_PARENT)
    .height($r('app.float.mine_title_height'))
    .backgroundColor($r('app.color.color_white'))
    .padding({ left: $r('app.float.mine_title_padding') })
    .borderRadius($r('app.float.card_radius'))
    .margin({
      top: 16,
    })
  }
}

@Preview
@Component
struct MineListView {
  build() {
    List() {
      ForEach(mainViewModel.getMineListData(), (item: ItemData) => {
        ListItem() {
          // 修改 Item 组件的属性传递方式
          Item({ itemData: item })
        }
        .height($r('app.float.mine_list_height'))
      }, (item: ItemData) => JSON.stringify(item))
    }
    .width(StyleConstants.FULL_PARENT)
    .backgroundColor($r('app.color.color_white'))
    .divider({
      strokeWidth: $r('app.float.list_stroke_width'),
      color: $r('app.color.divider_color'),
      startMargin: $r('app.float.list_start_margin'),
      endMargin: $r('app.float.list_end_margin')
    })
    .borderRadius($r('app.float.card_radius'))
    .padding({
      top: $r('app.float.mine_list_padding'),
      bottom: $r('app.float.mine_list_padding')
    })
  }
}

@Component
struct Item {
  // 将私有属性改为公共属性
  itemData?: ItemData;
  private itemCellImage?: Resource;
  private itemCellTitle?: Resource;
  private itemCellOthers?: Resource;
  private itemClickPrompt?: Resource;

  aboutToAppear() {
    if (this.itemData) {
      Logger.info(CommonConstants.TAG_LIST_ITEM, 'item = ' + JSON.stringify(this.itemData));
      this.itemCellImage = this.itemData.img;
      this.itemCellTitle = this.itemData.title;
      this.itemCellOthers = this.itemData.others;
      this.itemClickPrompt = this.itemData.clickPrompt;
    }
  }

  build() {
    Row() {
      Row({ space: StyleConstants.COMMON_SPACE }) {
        if (this.itemCellImage) {
          Image(this.itemCellImage)
            .width($r('app.float.mine_item_size'))
            .height($r('app.float.mine_item_size'))
        }
        Text(this.itemCellTitle)
          .fontSize($r('app.float.body_text'))
      }

      if (this.itemCellOthers === undefined) {
        Image($r('app.media.icon_arrow_right'))
          .width($r('app.float.mine_arrow_width'))
          .height($r('app.float.mine_arrow_height'))
          .fillColor($r("app.color.font_fourth"))
      } else {
        Toggle({ type: ToggleType.Switch, isOn: false })
          .onChange((isChange: boolean) => {
            let change: Resource = isChange ? $r('app.string.open_news') : $r('app.string.close_news');
            CommonUtils.showToastContent(change);
          })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(StyleConstants.FULL_PARENT)
    .padding({
      left: $r('app.float.mine_item_margin'),
      right: $r('app.float.mine_item_margin')
    })
    .onClick(() => {
      if (this.itemCellOthers === null && this.itemClickPrompt) {
        CommonUtils.showToastContent(this.itemClickPrompt);
      }
    })
  }
}

@Preview
@Component
struct MineTabView{
  goChangeOrderTab: (orderTypeId: number) => void = () => {}

  // 根据文字返回 code
  getCodeByText(text: string): number | undefined {
    const keys = Object.keys(ORDER_CODE_STATUS); // 返回 string[]
    for (let i = 0; i < keys.length; i++) {
      const key = Number(keys[i]); // 转成 number
      if (ORDER_CODE_STATUS[key] === text) {
        return key; // 找到对应 code
      }
    }
    return undefined; // 没找到返回 undefined
  }

  @Builder
  tabItemBuilder(text: string, image: string | Resource) {
    Column(){
      Stack(){
        Image(image)
          .mainTabItemImageStyle()
      }
      Text(text)
        .mainTabItemStyle()
    }.onClick(() => {
      console.log('goChangeOrderTab-1',text)
      const code = this.getCodeByText(text)
      if(code){
        this.goChangeOrderTab(code)
      }
    })
  }

  build() {
    Row(){
      ForEach(Object.keys(ORDER_STATUS_MAP),(key:string)=>{
        this.tabItemBuilder(ORDER_STATUS_MAP[key], $r(key))
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(16)
    .margin(16)
    .backgroundColor($r('app.color.color_white'))
    .border({radius:8})
  }
}

@Extend(Text) function mainTabItemStyle() {
  .fontColor($r('app.color.gray_8'))
  .fontSize($r('app.float.body_text'))
  .fontWeight(FontWeight.Normal)
  .textAlign(TextAlign.Start)
  .margin({right:4})
}
@Extend(Image) function mainTabItemImageStyle() {
  .width(60)
  .height(60)
  .borderRadius($r('app.float.card_radius'))
  .syncLoad(true)
  .padding(8)
  .margin({bottom:0})
}