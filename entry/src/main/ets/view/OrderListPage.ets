import { hilog } from '@kit.PerformanceAnalysisKit';
import { ORDER_CODE_STATUS } from '../api/orderStatusConfig'
import { TabItem } from '../mock/TabItem';
import CommonConstants from '../constants/CommonConstants';
import { initTabData } from '../mock/TabItem'
import orderList from './OrderList'

@Component
export default struct orderListPage {
  private tabsController: TabsController = new TabsController();
  @Prop changeFlag:boolean
  /** Tab 列表 */
  @State tabArray: TabItem[] = initTabData();
  /** 当前选中的 Tab */
  @State currentIndex: number = 0
  @Prop @Watch('goChangeOrderTab') orderTypeId: number;
  aboutToAppear(): void {
    console.log('orderTypeId',this.orderTypeId)
  }

  goChangeOrderTab(){
    console.log('监听发生了变化',this.orderTypeId)
    const targetItem = this.tabArray.find((item) => item.id === this.orderTypeId);
    if (targetItem) {
      this.tabsController.changeIndex(targetItem.index);
    } else {
      console.warn(`没有找到 id=${this.orderTypeId} 的 tab`);
    }
  }

  @Builder
  tabBuilder(index: number, name: string | Resource) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? $r('app.color.green_6') : $r('app.color.font_primary'))
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? FontWeight.Normal : FontWeight.Medium)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .width(48)
        .strokeWidth(CommonConstants.STROKE_WIDTH)
        .color($r('app.color.green_6'))
        .opacity(this.currentIndex === index ? 1 : 0)
    }
  }

  build() {
    Column() {
      Tabs({ index: this.currentIndex,barPosition: BarPosition.Start ,controller: this.tabsController}) {
        ForEach(this.tabArray, (item: TabItem) => {
          TabContent() {
            Row() {
              orderList({
                orderTypeId:item.id
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .height('100%')
          }.tabBar(this.tabBuilder(item.index, item.name))
        }, (item: TabItem) => JSON.stringify(item.id))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth('100%')
      .barHeight(52)
      .animationDuration(CommonConstants.ANIMATION_DURATION)
      .onAnimationStart((index: number, targetIndex: number) => {
        hilog.info(0x0000, 'index', index.toString());
        this.currentIndex = targetIndex;
      })
      .onChange((index: number) => {
        this.currentIndex = index;
        this.orderTypeId = this.tabArray[index].id
        // 这里需要筛选数据
        console.log('点击：',index)
      })
      .width('100%')
      .height('100%')
    }.width('100%')
  }
}