
import window from '@ohos.window';
export interface IImmersiveConfig{
  barColor: string,
  contentColor: string,
  navigationColor: string,
  navigatorColor: string
}
export class ImmersiveUtils {
  public static immersive(windowStage: window.WindowStage, config: IImmersiveConfig) {
    windowStage.getMainWindow()
      .then(win => {
        win.setWindowSystemBarProperties({
          statusBarColor: config.barColor,
          statusBarContentColor: config.contentColor,
          navigationBarColor: config.navigationColor,
          navigationBarContentColor: config.navigatorColor
        });
      })
  }
}