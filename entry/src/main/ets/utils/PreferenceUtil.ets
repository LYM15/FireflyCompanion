import { preferences } from '@kit.ArkData';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { globalHttp} from '../constants/config'
import Logger from './Logger';

const TAG = 'PreferenceUtil'

/**
 * getPreferences(context: Context, name: string): Promise<Preferences>
 * context  应用上下文。
 * name  Preferences实例的名称
 *
 * put(key: string, value: ValueType, callback: AsyncCallback<void>): void
 * key 要修改的存储的Key，不能为空
 * value  存储的新值
 * 当对应的键已经存在时，put()方法会覆盖其值。
 *
 * hasSync(key: string): boolean
 * 可以使用hasSync()方法检查是否存在对应键值对。
 */

class PreferenceUtil {
  async get(key:string,value:preferences.ValueType){
    try{
      const context:Context = getContext(this)

      const preferences_obj = await preferences.getPreferences(context,globalHttp.USER_INFO)
      const result = await preferences_obj.get(key,value)
      Logger.info(TAG,`获取[${key}]成功`)
      return result
    }catch (e) {
      Logger.error(TAG,`获取[${key}]失败`)
      return value
    }
  }

  async set(key:string,value:preferences.ValueType){
    try{
      const context:Context = getContext(this)
      const preferences_obj = await preferences.getPreferences(context,globalHttp.USER_INFO)
      await preferences_obj.put(key,value)
      await preferences_obj.flush()
      Logger.info(TAG,`存储[${key}]成功`)
    }catch (e) {
      Logger.error(TAG,`存储[${key}]失败`)
    }
  }

  async delete(key:string){
    try{
      const context:Context = getContext(this)
      const preferences_obj = await preferences.getPreferences(context,globalHttp.USER_INFO)
      await preferences_obj.delete(key)
      await preferences_obj.flush()
      Logger.info(TAG,`存储[${key}]成功`)
    }catch (e) {
      Logger.error(TAG,`存储[${key}]失败`)
    }
  }
}

export default new PreferenceUtil()