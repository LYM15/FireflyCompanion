export class DateUtils {
  /**
   * 格式化日期
   * @param date Date 对象
   * @param pattern 格式模板，支持 yyyy MM dd HH mm ss
   * @returns 格式化后的字符串
   */
  static format(date: Date, pattern: string = 'yyyy-MM-dd HH:mm'): string {
    const year = date.getFullYear()
    const month = DateUtils.pad(date.getMonth() + 1)
    const day = DateUtils.pad(date.getDate())
    const hour = DateUtils.pad(date.getHours())
    const minute = DateUtils.pad(date.getMinutes())
    const second = DateUtils.pad(date.getSeconds())

    return pattern
      .replace('yyyy', year.toString())
      .replace('MM', month)
      .replace('dd', day)
      .replace('HH', hour)
      .replace('mm', minute)
      .replace('ss', second)
  }

  /**
   * 数字补零
   */
  private static pad(num: number): string {
    return num < 10 ? '0' + num : num.toString()
  }
}
