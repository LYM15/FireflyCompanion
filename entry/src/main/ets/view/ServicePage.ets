import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import CommonUtils from '../utils/CommonUtils';
import type { HospitalItem } from '../mock/publicHospital'
import { packageList} from '../mock/packageList'
import type { PackageInfo} from '../mock/packageList'
import { CommonHeader } from '../components/CommonHeader';


@Entry
@Component
export default struct ServicePage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;

  build() {
    Scroll() {
      Column() {
        CommonHeader({title:$r('app.string.service_title')})
        // 顶部
        TopSearch().margin({bottom:10,top:10})
        // tab
        TabView()
      }
      .width(StyleConstants.FULL_PARENT)
      .backgroundColor($r('app.color.color_white'))
      .padding({
        left:16,
        right:16
      })
    }
    .scrollBar(BarState.Off)
  }
}



@Preview
@Component
struct TopSearch {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;

  build() {
    Row() {
      Row(){
        Image($r('app.media.icon_address'))
          .height(16)
          .fillColor($r('app.color.font_primary'))
          .margin({right:6})
        Text('武汉').fontSize($r('app.float.body_text')).fontColor($r('app.color.font_primary'))

        Image($r('app.media.icon_arrow_down'))
          .height(16)
          .fillColor($r('app.color.font_primary'))
          .margin({left:3,right:6})
      }.alignItems(VerticalAlign.Center).margin({right:10})
    }
    .width('100%')
    .padding({left:6,right:20,top:10,bottom:0})
  }
}


@Preview
@Component
struct TabView {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @State currentIndex: number = 0;
  private scrollerForList: Scroller = new Scroller();

  @Builder
  tabBuilder(index: number, name: ResourceStr) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? $r('app.color.color_white') : $r('app.color.gray_8'))
        .backgroundColor(this.currentIndex === index ? $r('app.color.green_6') : $r('app.color.green_1'))
        .fontSize($r('app.float.body_text'))
        .fontWeight(FontWeight.Normal)
        .padding({top:4,bottom:4})
        .width('100%')
        .textAlign(TextAlign.Center)
        .border({radius:1})

        // .lineHeight($r('app.float.mid_btn_height'))
        .margin({
          top: $r('app.float.margin_top'),
          bottom: $r('app.float.margin_bottom'),
          right:this.currentIndex === 2?'0':'16'
        })

    }
  }

  @Builder
  listBuilder(tabName: ResourceStr, index: number) {
    TabContent() {
      List({ space: StyleConstants.IMAGE_LIST_SPACE , scroller: this.scrollerForList }) {
        ForEach(packageList, (packageItem: PackageInfo, itemIndex: number) => {
          ListItem() {
            // 传递itemIndex给ItemView
            ItemView({ packageItem: packageItem, itemIndex: itemIndex })
          }
          .margin({ right: $r('app.float.list_margin'),bottom: $r('app.float.list_margin')})
          .borderRadius($r('app.float.card_radius'))
          .onClick(() => {
            CommonUtils.showToastContent(packageItem.content);
          })
        }, (hospitalItem: HospitalItem) => JSON.stringify(hospitalItem._id))
      }
      .width(StyleConstants.COMMON_WIDTH)
      .lanes(this.currentDeviceSize === CommonConstants.SM ?
      StyleConstants.LIST_COLUMN_ONE :
        (this.currentDeviceSize === CommonConstants.MD ?
        StyleConstants.LIST_COLUMN_TWO : StyleConstants.LIST_COLUMN_THREE))
      .width('100%')
      .height('100%')
      .edgeEffect(EdgeEffect.None)
      .scrollBar(BarState.Off)
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
    }
    .tabBar(this.tabBuilder(index, tabName))
  }

  build() {
    Column() {
      Text("权益套餐")
        .fontSize($r('app.float.body_text'))
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)
        .margin({
          left: $r('app.float.common_margin'),
          top: $r('app.float.common_margin')
        })
      Tabs() {
        this.listBuilder('全部服务', 0)
        this.listBuilder('陪诊服务', 1)
        this.listBuilder('权益套餐', 3)
      }
      .barWidth('100%')
      .onAnimationStart((_index: number, targetIndex: number, _event: TabsAnimationEvent) => {
        this.currentIndex = targetIndex;
      })

    }.margin({left:16,right:16})
  }
}


@Component
struct ItemView {
  private packageItem?: PackageInfo;
  private itemIndex?: number;  // 添加索引属性
  private listItemImage?: Resource;
  private listItemName?: Resource | string;
  private listItemContent?: Resource | string;
  private listItemPrice?: Resource | number | string;

  aboutToAppear() {
    if (this.packageItem !== undefined && this.itemIndex !== undefined) {
      // 根据索引选择对应的图片（循环使用4张图片）
      const imageIndex = (this.itemIndex % 4) + 1;  // 计算图片索引，范围为1-4
      this.listItemImage = this.getServiceImage(imageIndex);

      this.listItemName = this.packageItem.name;
      this.listItemContent = this.packageItem.content;
      this.listItemPrice = this.packageItem.price;
    }
  }

  // 根据索引获取对应的图片资源
  private getServiceImage(index: number): Resource {
    // 直接调用media中的四张图片
    if (index === 1) {
      return $r('app.media.service_1');
    } else if (index === 2) {
      return $r('app.media.service_3');
    } else if (index === 3) {
      return $r('app.media.service_2');
    } else {
      return $r('app.media.service_4');
    }
  }

  build() {
    Row(){
      Image(this.listItemImage)
        .width(72)
        .height(72)
        .backgroundColor(Color.Gray)
        .borderRadius($r('app.float.card_radius'))
        .objectFit(ImageFit.Cover)
        // .aspectRatio(StyleConstants.GRID_ASPECT_RATIO)
        .syncLoad(true)

      Column() {
        Text(this.listItemName)
          .fontSize($r('app.float.body_text'))
          .lineHeight(22)
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Start)
          .margin({bottom:6})
        Text(this.listItemContent)
          .fontSize($r('app.float.body_text_s'))
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Start)
          .fontColor($r('app.color.gray_6'))

        Row(){
          Row(){
            Text(`￥${this.listItemPrice}`)
              .fontSize($r('app.float.body_text'))
              .fontWeight(FontWeight.Medium)
              .alignSelf(ItemAlign.Start)
              .fontColor($r('app.color.red_6'))
              .lineHeight(14)
            Text('起')
              .fontSize($r('app.float.body_text_s'))
              .fontWeight(FontWeight.Normal)
              .alignSelf(ItemAlign.Start)
              .fontColor($r('app.color.gray_6'))
              .lineHeight(14)
              .margin({bottom:-4,left:2})
          }.layoutWeight(1)

          Button('购买',{ type: ButtonType.Normal, stateEffect: true })
            .width(60)
            .height(24)
            .backgroundColor($r('app.color.green_6'))
            .fontColor($r('app.color.color_white'))
            .alignSelf(ItemAlign.Center)
            .fontSize(FontWeight.Normal)
            .padding(0)
            .borderRadius($r('app.float.card_radius'))
        }
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({top:8,bottom:5})
      }
      .layoutWeight(1)
      .margin({
        left: $r('app.float.item_text_margin'),
        top: 3
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}