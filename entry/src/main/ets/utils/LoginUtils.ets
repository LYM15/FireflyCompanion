// import CommonConstants from '../constants/CommonConstants';
// import CommonUtils from './CommonUtils'
// import Logger from './Logger';
// import { UserDataUtils } from './UserDataUtils';
//
// /**
//  * Common operation tools.
//  */
// export class LoginUtils {
//   /**
//    * ArkTS login account and password.
//    *
//    * @param {string} account account
//    * @param {string} password password
//    */
//   public async loginArkTS(account: string, password: string): Promise<void> {
//     let check: Resource | string = this.loginCheckArkTS(account, password);
//     if (CommonConstants.LOGIN_TEXT !== check) {
//       Logger.error(CommonConstants.TAG_COMMON_UTILS, 'login account or password is empty');
//       CommonUtils.showToastContent(check);
//       return;
//     }
//
//     // 添加真实的用户验证逻辑
//     const isValidUser: boolean = UserDataUtils.verifyLogin(account, password);
//     if (!isValidUser) {
//       CommonUtils.showToastContent('账号或密码错误');
//       return;
//     }
//
//     // 登录成功，显示欢迎提示
//     CommonUtils.showToastContent(`登录成功，欢迎用户 ${account}`);
//
//     CommonUtils.routerPage(CommonConstants.MAIN_PAGE_URL);
//   }
//
//   /**
//    * Native login account and password.
//    *
//    * @param {string} account account
//    * @param {string} password password
//    */
//   // public loginNative(account: string, password: string): void {
//   //   let check: string = this.loginCheckNative(account, password);
//   //   if (CommonConstants.LOGIN_TEXT !== check) {
//   //     Logger.error(CommonConstants.TAG_COMMON_UTILS, 'login account or password is empty');
//   //     this.showToastContent(check);
//   //     return;
//   //   }
//   //   this.routerPage(CommonConstants.MAIN_PAGE_URL);
//   // }
//
//   /**
//    * 验证账号和密码是否为空.
//    *
//    * @param {string} account account
//    * @param {string} password password
//    * @return {Resource|string} return check result
//    */
//   private loginCheckArkTS(account: string, password: string): Resource | string {
//     let check: string = '';
//     if (account === '') {
//       return $r('app.string.please_input_account');
//     } else if (password === '') {
//       return $r('app.string.please_input_password');
//     } else {
//       check = CommonConstants.LOGIN_TEXT;
//     }
//     return check;
//   }
//
//   /**
//    * Native login account and password.
//    *
//    * @param {string} account account
//    * @param {string} password password
//    * @return {string} return  check result
//    */
//   // private loginCheckNative(account: string, password: string): string {
//   //   let check: string = libCheckNapi.nativeCheck(account, password);
//   //   return check;
//   // }
// }
//
// export default new LoginUtils();





import CommonConstants from '../constants/CommonConstants';
import CommonUtils from './CommonUtils'
import Logger from './Logger';
import { UserDataUtils, UserInfo } from './UserDataUtils';

/**
 * Common operation tools.
 */
export class LoginUtils {
  /**
   * ArkTS login account and password.
   *
   * @param {string} account account
   * @param {string} password password
   */
  public async loginArkTS(account: string, password: string): Promise<void> {
    let check: Resource | string = this.loginCheckArkTS(account, password);
    if (CommonConstants.LOGIN_TEXT !== check) {
      Logger.error(CommonConstants.TAG_COMMON_UTILS, 'login account or password is empty');
      CommonUtils.showToastContent(check);
      return;
    }

    // 添加真实的用户验证逻辑
    const isValidUser: boolean = UserDataUtils.verifyLogin(account, password);
    if (!isValidUser) {
      CommonUtils.showToastContent('账号或密码错误');
      return;
    }

    // 登录成功，存储当前用户信息
    this.setCurrentUser(account);

    // 显示欢迎提示
    CommonUtils.showToastContent(`登录成功，欢迎用户 ${account}`);

    CommonUtils.routerPage(CommonConstants.MAIN_PAGE_URL);
  }

  /**
   * Native login account and password.
   *
   * @param {string} account account
   * @param {string} password password
   */
  // public loginNative(account: string, password: string): void {
  //   let check: string = this.loginCheckNative(account, password);
  //   if (CommonConstants.LOGIN_TEXT !== check) {
  //     Logger.error(CommonConstants.TAG_COMMON_UTILS, 'login account or password is empty');
  //     this.showToastContent(check);
  //     return;
  //   }
  //   this.routerPage(CommonConstants.MAIN_PAGE_URL);
  // }

  /**
   * 设置当前登录用户
   */
  private setCurrentUser(account: string): void {
    try {
      const userList = UserDataUtils.getUserList();
      const currentUser = userList.find((user: UserInfo) => user.account === account);

      if (currentUser) {
        // 存储当前用户信息到 AppStorage
        AppStorage.setOrCreate('currentUser', currentUser);
        Logger.info(CommonConstants.TAG_COMMON_UTILS, '当前用户信息已存储: ' + JSON.stringify(currentUser));
      } else {
        Logger.error(CommonConstants.TAG_COMMON_UTILS, '未找到对应用户信息: ' + account);
      }
    } catch (err) {
      Logger.error(CommonConstants.TAG_COMMON_UTILS, '存储当前用户信息失败: ' + JSON.stringify(err));
    }
  }

  /**
   * 验证账号和密码是否为空.
   *
   * @param {string} account account
   * @param {string} password password
   * @return {Resource|string} return check result
   */
  private loginCheckArkTS(account: string, password: string): Resource | string {
    let check: string = '';
    if (account === '') {
      return $r('app.string.please_input_account');
    } else if (password === '') {
      return $r('app.string.please_input_password');
    } else {
      check = CommonConstants.LOGIN_TEXT;
    }
    return check;
  }

  /**
   * Native login account and password.
   *
   * @param {string} account account
   * @param {string} password password
   * @return {string} return  check result
   */
  // private loginCheckNative(account: string, password: string): string {
  //   let check: string = libCheckNapi.nativeCheck(account, password);
  //   return check;
  // }
}

export default new LoginUtils();