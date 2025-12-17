import mainViewModel from '../mock/MainViewModel';
import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import CommonUtils from '../utils/CommonUtils';
import { mockHospital } from '../mock/publicHospital'
import type { HospitalItem } from '../mock/publicHospital'

import { equityList} from '../mock/packageList'
import type { EquityType} from '../mock/packageList'

import { CommonHeader } from '../components/CommonHeader'
import { router } from '@kit.ArkUI';


@Entry
@Component
export default struct HomePage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;

  build() {
    Scroll() {
      Column() {
        CommonHeader({title:$r('app.string.home_title')})
        TopSearch().margin({bottom:10})
        SwiperView().margin({bottom:10})
        CenterGridView()

        // 医院列表
        ListView()
      }
      .width(StyleConstants.FULL_PARENT)
      .backgroundColor($r('app.color.background'))
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
        Text('中部地区').fontSize($r('app.float.body_text')).fontColor($r('app.color.font_primary'))

        Image($r('app.media.icon_arrow_down'))
          .height(16)
          .fillColor($r('app.color.font_primary'))
          .margin({left:3,right:6})
      }.alignItems(VerticalAlign.Center).margin({right:10})
      Row(){
        Row() {
          Image($r('app.media.icon_search'))
            .height(16)
            .fillColor($r('app.color.placeholder_color'))
            .margin({right:6})
          Text('搜索')
            .fontSize($r('app.float.body_text'))
            .fontColor($r('app.color.placeholder_color'))
        }
        .height(32)
        .borderRadius(16)
        .backgroundColor($r('app.color.gray_2'))
        .padding({ left: 10 })
        .flexGrow(1)
      }.flexGrow(1)
    }
    .width('100%')
    .padding({left:20,right:20,top:10,bottom:0})
  }
}


@Preview
@Component
struct SwiperView {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;

  // 定义轮播图图片数组
  private swiperImages: Resource[] = [
    $r('app.media.hospital_11'), // 第一张轮播图
    $r('app.media.hospital_22'), // 第二张轮播图
    $r('app.media.hospital_33')  // 第三张轮播图
  ];

  build() {
    Column() {
      Text("了解陪诊")
        .fontSize($r('app.float.body_text'))
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)
        .margin({
          left: $r('app.float.common_margin'),
          top: $r('app.float.common_margin')
        })
      Swiper() {
        ForEach(this.swiperImages, (item: Resource) => {
          Image(item)
            .borderRadius($r('app.float.card_radius'))
            .syncLoad(true)
        }, (item: Resource) => JSON.stringify(item))
      }
      .displayCount(CommonConstants.SWIPER_CACHE_COUNT)
      .autoPlay(true)
      .width(StyleConstants.COMMON_WIDTH)
      .itemSpace(this.currentDeviceSize === CommonConstants.SM ?
        0 : StyleConstants.ITEM_SPACE)
      .margin($r('app.float.common_margin'))
      .displayCount(this.currentDeviceSize === CommonConstants.SM ?
      StyleConstants.SWIPER_COUNT_ONE :
        (this.currentDeviceSize === CommonConstants.MD ?
        StyleConstants.SWIPER_COUNT_TWO : StyleConstants.SWIPER_COUNT_THREE))
    }.backgroundColor($r('app.color.color_white')).margin({left:16,right:16}).borderRadius($r('app.float.card_radius'))
  }
}


@Component
struct GridItemView {
  @Prop item: EquityType;
  private gridItemImg?: string | Resource;
  private gridItemTitle?: string | Resource;
  private gridItemPrompt?: string | Resource;

  aboutToAppear() {
    if (this.item !== undefined) {
      this.gridItemImg = this.item.pic;
      this.gridItemTitle = this.item.name;
      this.gridItemPrompt = this.item.content;
    }
  }

  build() {
    Column() {
      if(this.gridItemImg) {
        Image(this.gridItemImg)
          .width($r('app.float.home_cell_size'))
          .height($r('app.float.home_cell_size'))
          .syncLoad(true)
      }
      if (this.gridItemTitle) {
        Text(this.gridItemTitle)
          .fontSize($r('app.float.body_text'))
          .margin({ top: $r('app.float.home_cell_margin') })
      }
    }
    .onClick(() => {
      if(!this.gridItemPrompt) {
        return;
      }
      CommonUtils.showToastContent(this.gridItemPrompt);
      router.pushUrl({
        url: 'pages/CreateOrderPage',
        params: {
          orderType: this.item.name,
        }
      })
    })
  }
}


@Preview
@Component
struct CenterGridView {
  build() {
    Column() {
      Grid() {
        ForEach(equityList, (item: EquityType) => {
          GridItem() {
            GridItemView({ item: item })
          }.onClick(()=>{
            router.pushUrl({
              url: 'pages/CreateOrderPage',
              params: {
                orderType: item.name,
              }
            })
          })
        }, (item: EquityType) => JSON.stringify(item._id))
      }
      .columnsTemplate(StyleConstants.GRID_COLUMNS)
      .rowsTemplate(StyleConstants.GRID_ROWS)
      .columnsGap($r('app.float.grid_column_gap'))
      .rowsGap($r('app.float.grid_row_gap'))
      .height(StyleConstants.HOME_GRID_HEIGHT)
      .backgroundColor($r('app.color.color_white'))
      .borderRadius($r('app.float.card_radius'))
      .padding({
        top: $r('app.float.home_grid_padding'),
        bottom: $r('app.float.home_grid_padding')
      })
      .width(StyleConstants.COMMON_WIDTH)
      .margin($r('app.float.common_margin'))
    }
  }
}

@Preview
@Component
struct ListView {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;

  build() {
    Column() {
      Text("医院列表")
        .fontSize($r('app.float.body_text'))
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)
        .margin({
          left: $r('app.float.common_margin'),
          top: $r('app.float.common_margin')
        })

      List({ space: StyleConstants.IMAGE_LIST_SPACE }) {
        ForEach(mockHospital, (hospitalItem: HospitalItem) => {
          ListItem() {
            ItemView({ hospitalItem: hospitalItem })
          }
          .margin({ right: $r('app.float.list_margin'), bottom: $r('app.float.list_margin') })
          .borderRadius($r('app.float.card_radius'))
          .backgroundColor($r('app.color.color_white'))
          .shadow({
            offsetX: 0,
            offsetY: 1,
            radius: 3,
            color: '#20000000'
          })
          .onClick(() => {
            CommonUtils.showToastContent(hospitalItem.name);
            // 跳转到创建订单页面，传递医院信息
            router.pushUrl({
              url: 'pages/CreateOrderPage',
              params: {
                hospitalName: hospitalItem.name,
                hospitalId: hospitalItem._id
              }
            })
          })
        }, (hospitalItem: HospitalItem) => JSON.stringify(hospitalItem._id))
      }
      .width(StyleConstants.COMMON_WIDTH)
      .margin($r('app.float.common_margin'))
      .lanes(this.currentDeviceSize === CommonConstants.SM ?
      StyleConstants.LIST_COLUMN_ONE :
        (this.currentDeviceSize === CommonConstants.MD ?
        StyleConstants.LIST_COLUMN_TWO : StyleConstants.LIST_COLUMN_THREE))
    }.backgroundColor($r('app.color.color_white')).margin({left:16,right:16}).borderRadius($r('app.float.card_radius'))
  }
}

@Component
struct ItemView {
  @Prop hospitalItem: HospitalItem;
  @State private imageLoaded: boolean = false;
  @State private imageError: boolean = false;

  // 获取医院对应的图片资源 - 根据医院编号分配不同的图片
  private getHospitalImage(): Resource {
    // 根据医院编号分配不同的图片资源
    const hospitalNumber = this.hospitalItem.number;

    console.log(`分配图片: 医院编号 ${hospitalNumber} - ${this.hospitalItem.name}`);

    switch (hospitalNumber) {
      case 4321: // 武汉大学人民医院 - 使用 hospital_1
        return $r('app.media.hospital_1');
      case 4322: // 华中科技大学同济医学院附属协和医院 - 使用 hospital_2
        return $r('app.media.hospital_2');
      case 4323: // 武汉大学中南医院 - 使用 hospital_3
        return $r('app.media.hospital_3');
      case 4324: // 武汉市中心医院 - 使用 hospital_4
        return $r('app.media.hospital_4');
      case 4325: // 武汉市妇女儿童医疗保健中心 - 使用 hospital_5
        return $r('app.media.hospital_5');
      case 4328: // 武汉地区-其他医院 - 使用 hospital_6
        return $r('app.media.hospital_6');
      default:  // 默认使用 hospital_1
        console.warn(`未知医院编号 ${hospitalNumber}, 使用默认图片`);
        return $r('app.media.hospital_1');
    }
  }

  aboutToAppear() {
    // 在组件出现时打印调试信息
    console.log('=== 医院信息详情 ===');
    console.log('医院名称:', this.hospitalItem.name);
    console.log('医院编号:', this.hospitalItem.number);
    console.log('医院ID:', this.hospitalItem._id);
    console.log('分配图片方法:', this.getHospitalImage());
    console.log('===================');
  }

  build() {
    Row(){
      // 图片区域 - 使用本地图片资源
      Stack() {
        // 医院图片 - 使用对应的本地图片
        Image(this.getHospitalImage())
          .width('100%')
          .height('100%')
          .backgroundColor($r('app.color.gray_1'))  // 加载时的背景色
          .borderRadius(8)   // 圆角
          .objectFit(ImageFit.Cover)  // 关键：保持比例填充
          .syncLoad(true)
          .onAppear(() => {
            this.imageLoaded = true;
            // 调试信息
            console.log('加载医院图片:', this.hospitalItem.name, '编号:', this.hospitalItem.number);
          })
          .onError(() => {
            this.imageError = true;
            console.error('图片加载失败:', this.hospitalItem.name, '编号:', this.hospitalItem.number);
          })

        // 加载指示器
        if (!this.imageLoaded && !this.imageError) {
          // 使用LoadingProgress替代Progress
          LoadingProgress()
            .width(20)
            .height(20)
            .color($r('app.color.primary_color'))
        }

        // 加载失败时显示占位
        if (this.imageError) {
          Column() {
            Text("🏥")
              .fontSize(24)
            Text('图片加载中')
              .fontSize(10)
              .fontColor($r('app.color.gray_6'))
              .margin({ top: 4 })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor($r('app.color.gray_1'))
          .borderRadius(8)
        }

        // 医院等级徽章（可选）
        if (this.hospitalItem.rank) {
          Column() {
            Text(this.hospitalItem.rank)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .padding({ left: 4, right: 4, top: 2, bottom: 2 })
          }
          .backgroundColor($r('app.color.primary_color'))
          .borderRadius({ topLeft: 0, topRight: 4, bottomLeft: 0, bottomRight: 4 })
          .position({ x: 0, y: 0 })
        }
      }
      .width(110)    // 图片容器宽度
      .height(90)    // 图片容器高度
      .borderRadius(8)
      .clip(true)    // 裁剪超出部分

      // 文字信息区域
      Column() {
        Text(this.hospitalItem.name)
          .fontSize($r('app.float.subtitle_text'))
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Start)
          .margin({ bottom: 6 })
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          // 医院等级标签
          Column() {
            Text(this.hospitalItem.rank)
              .fontSize($r('app.float.body_text_s'))
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          }
          .backgroundColor($r('app.color.primary_color'))
          .borderRadius(12)

          // 医院类型
          Text(this.hospitalItem.type)
            .fontSize($r('app.float.body_text_s'))
            .fontColor($r('app.color.gray_8'))
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 8 })

        // 地址信息
        Row() {
          Text('地址：')
            .fontSize($r('app.float.body_text_s'))
            .fontColor($r('app.color.gray_6'))
          Text(this.hospitalItem.address)
            .fontSize($r('app.float.body_text_s'))
            .fontColor($r('app.color.gray_6'))
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .alignItems(VerticalAlign.Top)
        .width('100%')
      }
      .layoutWeight(1)
      .margin({ left: 12 })
      .padding({ top: 4, bottom: 4 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
  }
}





