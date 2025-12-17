// import CommonConstants from '../constants/CommonConstants';
// import Logger from './Logger';
// import { PromptActionClass } from './PromptActionClass';
// import { promptAction } from '@kit.ArkUI';
//
// import { ComponentContent, UIContext} from '@kit.ArkUI';
// import { buildImgActionTips, ImgActionParams,buildConfirmDialogComponent,ConfirmActionParams,ConfirmDialogOptions} from '../components/ImgActionTips';
//
// const uiContext: UIContext | undefined = AppStorage.get('uiContext');
// type ToastType = 'success' | 'warning' | 'error' | 'normal';
//
//
// /**
//  * Common operation tools.
//  */
// class CommonUtils {
//   /**
//    * Router page
//    *
//    * @param {string} url page url
//    */
//   public routerPage(url: string): void {
//     uiContext!.getRouter().replaceUrl({
//       url: url
//     }).catch((error: Error) => {
//       Logger.error(CommonConstants.TAG_COMMON_UTILS, 'replace url error ' + JSON.stringify(error));
//     });
//   }
//
//   // 默认提示
//   /**
//    * 弹框提示
//    * @param message
//    */
//   alertMsg(message: string): void {
//     promptAction.showToast({
//       message: message,
//       duration: CommonConstants.TOAST_DURATION
//     });
//   }
//
//   /**
//    * Show toast content.
//    *
//    * @param {Resource | string} content content to show
//    */
//   public showToastContent(content: Resource | string): void {
//     promptAction.showToast({
//       message: content,
//       duration: CommonConstants.TOAST_DURATION
//     });
//   }
//
//   /**
//    * 显示带图标的自定义 Toast
//    * @param content 文本内容
//    * @param type 图标类型
//    * @param duration 持续时间（毫秒）
//    */
//   public showImgToastContent(
//     content: string | Resource,
//     type: ToastType = 'success',
//     duration: number = 3000
//   ): void {
//     if (!content) {
//       Logger.warn('CommonUtils', 'showImgToastContent: content is empty');
//       return;
//     }
//     if (!uiContext) {
//       Logger.warn('CommonUtils', 'showImgToastContent: uiContext is empty');
//       return;
//     }
//
//     // 创建独立的 ComponentContent
//     const params = new ImgActionParams(content, '', type);
//     const imageTipsContentNode = new ComponentContent(uiContext, wrapBuilder(buildImgActionTips), params);
//     PromptActionClass.setContext(uiContext);
//     PromptActionClass.setContentNode(imageTipsContentNode);
//     PromptActionClass.setOptions({
//       isModal: false,
//       alignment: DialogAlignment.Bottom,
//       offset: { dx: 0, dy: -80 },
//     });
//     PromptActionClass.openDialog();
//     setTimeout(() => {
//       PromptActionClass.closeDialog(imageTipsContentNode);
//     }, duration);
//   }
//
//   /**
//    * 显示确认的弹窗
//    * @param title 标题
//    * @param content 内容
//    * @param cancelBtnText 取消按钮文本
//    * @param confirmBtnText 确认按钮文本
//    * @param clickConfirmBtn 确认回调
//    * @param clickCancelBtn 取消回调
//    * @param showCancelBtn 是否显示取消按钮
//    */
//   public showConfirmDialog(
//     title: string | Resource,
//     content: string | Resource,
//     cancelBtnText: string = '取消',  // 改为字符串
//     confirmBtnText: string = '确定',  // 改为字符串
//     clickConfirmBtn?: () => void | Promise<boolean>,
//     clickCancelBtn?: () => void,
//     showCancelBtn: boolean = true,
//   ): void {
//     if (!content) {
//       Logger.warn('CommonUtils', 'showConfirmDialog: content is empty');
//       return;
//     }
//     if (!uiContext) {
//       Logger.warn('CommonUtils', 'showConfirmDialog: uiContext is empty');
//       return;
//     }
//
//     // 创建独立的 ComponentContent
//     PromptActionClass.setContext(uiContext);
//     const ConfirmDialogContentNode = new ComponentContent(
//       uiContext,
//       wrapBuilder(buildConfirmDialogComponent),
//       new ConfirmActionParams({
//         title,
//         content,
//         cancelBtnText,
//         confirmBtnText,
//         showCancelBtn,
//         // 确认按钮包装
//         clickConfirmBtn: async () => {
//           try {
//             if (clickConfirmBtn) {
//               const result = clickConfirmBtn();
//               let success: boolean;
//
//               if (result instanceof Promise) {
//                 success = await result;
//               } else if (typeof result === 'boolean') {
//                 success = result;
//               } else {
//                 success = true;
//               }
//
//               if (success) {
//                 PromptActionClass.closeDialog(ConfirmDialogContentNode);
//               }
//             } else {
//               PromptActionClass.closeDialog(ConfirmDialogContentNode);
//             }
//           } catch (err) {
//             Logger.error('CommonUtils', 'clickConfirmBtn error: ' + JSON.stringify(err));
//           }
//         },
//         // 取消按钮包装，直接关闭
//         clickCancelBtn: () => {
//           PromptActionClass.closeDialog(ConfirmDialogContentNode);
//           clickCancelBtn?.();
//         }
//       })
//     );
//
//     PromptActionClass.setContentNode(ConfirmDialogContentNode);
//     PromptActionClass.setOptions({ autoCancel: false });
//     PromptActionClass.openDialog();
//   }
//
//   // 格式化时间
//   public numberToTime(number: number): string {
//     // 毫秒 → 秒 → 分+秒; 先判断是否大于1分钟
//     if (number > 60 * 1000) {
//       const s = Math.floor(number / 1000 % 60);
//       const m = Math.floor(number / 1000 / 60);
//       const second = s.toString().padStart(2, '0');
//       const minute = m.toString().padStart(2, '0');
//       return minute + ':' + second;
//     } else {
//       const s = Math.floor(number / 1000 % 60);
//       const second = s.toString().padStart(2, '0');
//       return '00:' + second;
//     }
//   }
// }
//
// export default new CommonUtils();






import prompt from '@ohos.prompt'
import CommonConstants from '../constants/CommonConstants';
import Logger from './Logger';
import { PromptActionClass } from './PromptActionClass';
import { promptAction } from '@kit.ArkUI';

import { ComponentContent, UIContext} from '@kit.ArkUI';
import { buildImgActionTips, ImgActionParams,buildConfirmDialogComponent,ConfirmActionParams,ConfirmDialogOptions} from '../components/ImgActionTips';

const uiContext: UIContext | undefined = AppStorage.get('uiContext');
type ToastType = 'success' | 'warning' | 'error' | 'normal';


/**
 * Common operation tools.
 */
class CommonUtils {
  /**
   * Router page
   *
   * @param {string} url page url
   */
  public routerPage(url: string): void {
    uiContext!.getRouter().replaceUrl({
      url: url
    }).catch((error: Error) => {
      Logger.error(CommonConstants.TAG_COMMON_UTILS, 'replace url error ' + JSON.stringify(error));
    });
  }

  static showAlert(message: string): void {
    try {
      prompt.showToast({
        message: message,
        duration: 2000
      })
    } catch (error) {
      console.error('显示提示失败:', error)
    }
  }

  // 默认提示
  /**
   * 弹框提示
   * @param message
   */
  alertMsg(message: string): void {
    promptAction.showToast({
      message: message,
      duration: CommonConstants.TOAST_DURATION
    });
  }

  /**
   * Show toast content.
   *
   * @param {Resource | string} content content to show
   */
  public showToastContent(content: Resource | string): void {
    promptAction.showToast({
      message: content,
      duration: CommonConstants.TOAST_DURATION
    });
  }

  /**
   * 显示带图标的自定义 Toast
   * @param content 文本内容
   * @param type 图标类型
   * @param duration 持续时间（毫秒）
   */
  public showImgToastContent(
    content: string | Resource,
    type: ToastType = 'success',
    duration: number = 3000
  ): void {
    if (!content) {
      Logger.warn('CommonUtils', 'showImgToastContent: content is empty');
      return;
    }
    if (!uiContext) {
      Logger.warn('CommonUtils', 'showImgToastContent: uiContext is empty');
      return;
    }

    // 创建独立的 ComponentContent
    const params = new ImgActionParams(content, '', type);
    const imageTipsContentNode = new ComponentContent(uiContext, wrapBuilder(buildImgActionTips), params);
    PromptActionClass.setContext(uiContext);
    PromptActionClass.setContentNode(imageTipsContentNode);
    PromptActionClass.setOptions({
      isModal: false,
      alignment: DialogAlignment.Bottom,
      offset: { dx: 0, dy: -80 },
    });
    PromptActionClass.openDialog();
    setTimeout(() => {
      PromptActionClass.closeDialog(imageTipsContentNode);
    }, duration);
  }

  /**
   * 显示确认的弹窗
   * @param title 标题
   * @param content 内容
   * @param cancelBtnText 取消按钮文本
   * @param confirmBtnText 确认按钮文本
   * @param clickConfirmBtn 确认回调
   * @param clickCancelBtn 取消回调
   * @param showCancelBtn 是否显示取消按钮
   */
  public showConfirmDialog(
    title: string | Resource,
    content: string | Resource,
    cancelBtnText: string = '取消',  // 改为字符串
    confirmBtnText: string = '确定',  // 改为字符串
    clickConfirmBtn?: () => void | Promise<boolean>,
    clickCancelBtn?: () => void,
    showCancelBtn: boolean = true,
  ): void {
    if (!content) {
      Logger.warn('CommonUtils', 'showConfirmDialog: content is empty');
      return;
    }
    if (!uiContext) {
      Logger.warn('CommonUtils', 'showConfirmDialog: uiContext is empty');
      return;
    }

    // 创建独立的 ComponentContent
    PromptActionClass.setContext(uiContext);
    const ConfirmDialogContentNode = new ComponentContent(
      uiContext,
      wrapBuilder(buildConfirmDialogComponent),
      new ConfirmActionParams({
        title,
        content,
        cancelBtnText,
        confirmBtnText,
        showCancelBtn,
        // 确认按钮包装
        clickConfirmBtn: async () => {
          try {
            if (clickConfirmBtn) {
              const result = clickConfirmBtn();
              let success: boolean;

              if (result instanceof Promise) {
                success = await result;
              } else if (typeof result === 'boolean') {
                success = result;
              } else {
                success = true;
              }

              if (success) {
                PromptActionClass.closeDialog(ConfirmDialogContentNode);
              }
            } else {
              PromptActionClass.closeDialog(ConfirmDialogContentNode);
            }
          } catch (err) {
            Logger.error('CommonUtils', 'clickConfirmBtn error: ' + JSON.stringify(err));
          }
        },
        // 取消按钮包装，直接关闭
        clickCancelBtn: () => {
          PromptActionClass.closeDialog(ConfirmDialogContentNode);
          clickCancelBtn?.();
        }
      })
    );

    PromptActionClass.setContentNode(ConfirmDialogContentNode);
    PromptActionClass.setOptions({ autoCancel: false });
    PromptActionClass.openDialog();
  }

  // 格式化时间
  public numberToTime(number: number): string {
    // 毫秒 → 秒 → 分+秒; 先判断是否大于1分钟
    if (number > 60 * 1000) {
      const s = Math.floor(number / 1000 % 60);
      const m = Math.floor(number / 1000 / 60);
      const second = s.toString().padStart(2, '0');
      const minute = m.toString().padStart(2, '0');
      return minute + ':' + second;
    } else {
      const s = Math.floor(number / 1000 % 60);
      const second = s.toString().padStart(2, '0');
      return '00:' + second;
    }
  }
}

export default new CommonUtils();