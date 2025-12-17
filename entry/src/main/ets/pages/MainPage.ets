import { router } from '@kit.ArkUI'
import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import HomePage from '../view/HomePage';
import ServicePage from '../view/ServicePage'
import MinePage from '../view/MinePage';
import OrderListPage from '../view/OrderListPage'
import Logger from '../utils/Logger';
import MultipleDevicesUtils from '../utils/MultipleDevicesUtils';

interface params {
  index:number
}

@Entry
@Component
struct MainPage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  tabsController: TabsController = new TabsController();
  @State currentIndex: number = CommonConstants.HOME_TAB_INDEX;
  @State changeFlag:boolean = true
  @State orderTypeId:number = 0

  aboutToDisappear() {
    MultipleDevicesUtils.unregister();
  }
  onPageShow(): void {
    if(router.getParams()){
      let index = (router.getParams() as params).index
      this.tabsController.changeIndex(index)
    }
    this.changeFlag = true
  }
  onPageHide(): void {
    this.changeFlag = false
  }

  goIndex(index:number,id:number){
    this.tabsController.changeIndex(index)
    this.orderTypeId = id
  }

  goChangeOrderTab(orderTypeId:number){
    this.tabsController.changeIndex(2)
    this.orderTypeId = orderTypeId
  }

  build() {
    Tabs({
      barPosition: this.currentDeviceSize === CommonConstants.LG ?
      BarPosition.Start : BarPosition.End,
      index: this.currentIndex,
      controller: this.tabsController
    }) {
      TabContent() {
        HomePage()
      }
      .tabBar(this.TabBuilder($r('app.string.home_title'), CommonConstants.HOME_TAB_INDEX,
        $r('app.media.tab_firefly_block'), $r('app.media.tab_firefly')))

      TabContent() {
        ServicePage()
      }
      .tabBar(this.TabBuilder($r('app.string.service_title'), CommonConstants.SERVICE_TAB_INDEX,
        $r('app.media.tab_service_block'), $r('app.media.tab_service')))

      TabContent() {
        OrderListPage({changeFlag:this.changeFlag,orderTypeId:this.orderTypeId})
      }
      .tabBar(this.TabBuilder($r('app.string.order_list_title'), CommonConstants.ORDER_TAB_INDEX,
        $r('app.media.tab_order_block'), $r('app.media.tab_order')))

      TabContent() {
        MinePage({
          goChangeOrderTab: (orderTypeId:number) => {
            this.goChangeOrderTab(orderTypeId)
          }
        })
      }
      .tabBar(this.TabBuilder($r('app.string.mine_title'), CommonConstants.MINE_TAB_INDEX,
        $r('app.media.tab_mine_block'), $r('app.media.tab_mine')))
    }
    .barWidth(this.currentDeviceSize === CommonConstants.LG ?
    StyleConstants.BAR_WIDTH_LG : StyleConstants.FULL_PARENT)
    .barHeight(this.currentDeviceSize === CommonConstants.LG ?
    StyleConstants.BAR_HEIGHT_LG : StyleConstants.BAR_DEFAULT_HEIGHT)
    .vertical(this.currentDeviceSize === CommonConstants.LG)
    .backgroundColor($r('app.color.color_white'))
    .barMode(BarMode.Fixed)
    .scrollable(false)
    .onChange((index: number) => {
      this.currentIndex = index;
      Logger.info(CommonConstants.TAG_MAIN_PAGE, 'onChange index ' + JSON.stringify(index));
    })
  }

  @Builder TabBuilder(title: Resource, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width($r('app.float.base_tab_size'))
        .height($r('app.float.base_tab_size'))
        .fillColor(this.currentIndex === index ? $r('app.color.primary_color') : $r('app.color.font_secondary'))
      Text(title)
        .margin({ top: $r('app.float.base_tab_top') })
        .fontSize($r("app.float.tab_font_size"))
        .fontColor(this.currentIndex === index ? $r('app.color.primary_color') : $r('app.color.font_secondary'))
    }
    .justifyContent(FlexAlign.Center)
    .height(StyleConstants.FULL_PARENT)
    .width(StyleConstants.FULL_PARENT)
  }
}