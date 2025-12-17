
import { AppStorageV2 } from '@kit.ArkUI';

class UserInfo {
  account: string = '';
  password: string = '';
  nickname: string = '';
  phone: string = '';
  email: string = '';
}

class UserDataUtils {
  private static readonly STORAGE_KEY: string = 'userDataList';

  // 保存用户列表
  static saveUserList(userList: UserInfo[]): void {
    try {
      AppStorage.setOrCreate(UserDataUtils.STORAGE_KEY, JSON.stringify(userList));
    } catch (err) {
      console.error('Failed to save user list:' + JSON.stringify(err));
    }
  }

  // 获取用户列表
  static getUserList(): UserInfo[] {
    try {
      const userListStr: string = AppStorage.get(UserDataUtils.STORAGE_KEY) as string;
      if (userListStr && userListStr !== 'undefined') {
        return JSON.parse(userListStr) as UserInfo[];
      }
      return [];
    } catch (err) {
      console.error('Failed to get user list:' + JSON.stringify(err));
      return [];
    }
  }

  // 检查账号是否已存在
  static isAccountExist(account: string): boolean {
    const userList: UserInfo[] = UserDataUtils.getUserList();
    return userList.some((user: UserInfo) => user.account === account);
  }

  // 注册新用户
  static registerUser(userInfo: UserInfo): boolean {
    try {
      const userList: UserInfo[] = UserDataUtils.getUserList();

      // 检查账号是否已存在
      if (UserDataUtils.isAccountExist(userInfo.account)) {
        return false;
      }

      userList.push(userInfo);
      UserDataUtils.saveUserList(userList);
      return true;
    } catch (err) {
      console.error('Failed to register user:' + JSON.stringify(err));
      return false;
    }
  }

  // 验证登录
  static verifyLogin(account: string, password: string): boolean {
    const userList: UserInfo[] = UserDataUtils.getUserList();
    return userList.some((user: UserInfo) => user.account === account && user.password === password);
  }
}

export { UserInfo, UserDataUtils };