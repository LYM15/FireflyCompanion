// utils/RegisterUtils.ets
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { UserDataUtils, UserInfo } from './UserDataUtils';

class RegisterUtils {

  // 注册逻辑
  static async registerArkTS(account: string, password: string, confirmPassword: string, nickname: string): Promise<void> {
    // 验证输入
    if (!RegisterUtils.validateInput(account, password, confirmPassword)) {
      return;
    }

    // 创建用户信息
    const userInfo: UserInfo = {
      account: account,
      password: password,
      nickname: nickname || account,
      phone: '',
      email: ''
    };

    try {
      // 注册用户
      const success: boolean = await UserDataUtils.registerUser(userInfo);

      if (success) {
        // 注册成功
        promptAction.showToast({
          message: '注册成功，跳转到登录页面',
          duration: 2000
        });

        // 延迟跳转到登录页面
        setTimeout(() => {
          router.back();
        }, 1500);
      } else {
        // 账号已存在
        promptAction.showToast({
          message: '账号已存在',
          duration: 2000
        });
      }
    } catch (error) {
      console.error('Register failed:' + JSON.stringify(error));
      promptAction.showToast({
        message: '注册失败，请重试',
        duration: 2000
      });
    }
  }

  // 验证输入
  private static validateInput(account: string, password: string, confirmPassword: string): boolean {
    if (!account || account.length < 3) {
      promptAction.showToast({
        message: '账号长度至少3位',
        duration: 2000
      });
      return false;
    }

    if (!password || password.length < 6) {
      promptAction.showToast({
        message: '密码长度至少6位',
        duration: 2000
      });
      return false;
    }

    if (password !== confirmPassword) {
      promptAction.showToast({
        message: '两次输入的密码不一致',
        duration: 2000
      });
      return false;
    }

    return true;
  }
}

export { RegisterUtils };