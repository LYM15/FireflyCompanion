import { ORDER_CODE_STATUS } from '../api/orderStatusConfig'
// @Entry
@Component
export struct orderProgress {

  @Prop orderTypeId:number = 205
  @State typeLen:number =  3 // 已完成和已取消是同一个状态 都是最后一步，第四步

  @State private typeIndex: number = this.getStatusIndex(this.orderTypeId)
  typeWidth:Array<number> = [15,33,65,100]


  /**
   * 获取状态索引
   * 特殊规则：204 和 205 归为同一个索引 (最后一步)
   */
  getStatusIndex(code: number): number {
    switch (code) {
      case 201: return 0; // 待支付
      case 202: return 1; // 服务中
      case 203: return 2; // 待评价
      case 204: return 3; // 已完成
      case 205: return 3; // 已取消（归并）
      default:  return 0; // 未知状态，默认第0步
    }
  }

  onPageShow(): void {
    console.log(
      'orderTypeId：',this.orderTypeId,
      ',typeLen：',this.typeLen,
      ',typeIndex：',this.typeIndex,
      ',progressWidth：',this.typeWidth[this.typeIndex],
    )
  }

  build() {

    Column() {
      Column(){
        // 上方进度
        Row(){
          Stack({alignContent:Alignment.Start}) {
            // 背景
            Row()
              .borderRadius(20)
              .width('100%')
              .height(20)
              .padding(1)
              .backgroundColor(this.typeIndex > this.typeLen || this.typeIndex < 0 ? $r('app.color.gray_6') :
              $r('app.color.color_white'))
            // 进度条
            Row()
              .borderRadius(20)
              .width(`${this.typeWidth[this.typeIndex]}%`)
              .height(18)
              .margin({ left: 1 })
              .backgroundColor(this.orderTypeId === 205 ?$r('app.color.gray_6'):$r('app.color.green_6'))
          }
        }
        .width('100%')
        // Progress({ value: this.typeIndex, total: ORDER_STEP_LIST.length, type: ProgressType.Linear }).width('100%').height(20)

        // 数字
        // 下方文字标签
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          ForEach(Object.keys(ORDER_CODE_STATUS).slice(0,4), (key: string,index:number) => {
            // 单独处理已取消
            if(this.orderTypeId === 205){
              Text(`${index < 3 ? ORDER_CODE_STATUS[key] : '已取消'}`)
                // 205 时特殊处理：只高亮“已取消”
                .opacity(
                  index === 3 ? 1 : 0.2
                )
                .fontColor($r('app.color.font_primary'))
                .fontSize(16)

            }else{
              Text(ORDER_CODE_STATUS[key])
                // 205 时特殊处理：只高亮“已取消”
                .opacity(
                  this.orderTypeId === Number(key) ? 1 : 0.2
                )
                .fontColor($r('app.color.font_primary'))
                .fontSize(16)
            }

          })
        }.margin({ top: 20 })
      }
      .backgroundColor(Color.Gray)
      .padding({left:20,right:20,top:40,bottom:40})
      .linearGradient({
        angle: 90,
        colors: [
          ['#C5FFD5', 0.0],
          ['#EEFEEF', 1.0]
        ]
      })
      // .radialGradient({
      //   center: [0.5, 0.5], // 渐变中心点 (x,y) 范围 0~1
      //   radius: 0.8,
      //   colors: [
      //     ['#36d1dc', 0.0],
      //     ['#5b86e5', 1.0]
      //   ]
      // })


    }
    .width('100%')
    .height('100%')
  }
}