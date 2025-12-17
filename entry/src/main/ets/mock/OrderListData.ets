
export interface MainGoodType {
  _id: string
  anchor: string
  city: string
  content: string
  pic: string| Resource
  price: number
  type: number
  name: string
}

export interface OrderContentType {
  hospital: string
  order_name: string
  order_sex: string
  city: string
  serve_time: string
  order_mobile: string
}

export interface PatientContentType {
  patient_address?: string
  patient_age: number
  patient_name: string
  patient_remark: string
  patient_move: string
  patient_id: string
  patient_sex: string
  patient_mobile: string
}

export interface OrderItemType {
  orderID: string
  mainGood: MainGoodType
  order_content: OrderContentType
  patient_content: PatientContentType
  serviceImg: string | Resource
  service_name: string
  hospital_name: string
  starttime: string
  trade_state?: string
  order_start_time?: number
  out_trade_no?: string
  order_remark?: string
  create_time?: number
  serve_img?: string
  isBill?: number
  isInsure?: number
  custom_type?: string
  custom_key?: string
  _add_time_str?: string
  serve_amount?: number
  from?: number
}

// 在 OrderListData.ts 中添加以下函数
export function addNewOrderToOrderList(newOrder: OrderItemType) {
  // 将新订单添加到列表开头
  orderListData.unshift(newOrder);
  return newOrder.orderID;
}


export const orderListData:OrderItemType[] = [
  {
    orderID: 'PZ2025082664168874',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '专享半天陪诊',
    hospital_name: '协和医院本院区',
    starttime: '2025-12-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '6823e672ee97ef53e40cf92b',
      anchor: 'SV1001',
      city: '武汉',
      content: '半天（4小时）专享陪同就医服务',
      pic: $r('app.media.equity_half_day'),
      price: 258,
      type: 201,
      name: '半天陪诊服务'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '李先生',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-12-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '李四',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ20250826689768544',
    serviceImg: $r('app.media.equity_consultation'),
    service_name: '代办问诊',
    hospital_name: '协和医院本院区',
    starttime: '2025-12-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-12-20 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '658a9484337a9f43948788d1',
      anchor: 'SV1001',
      city: '武汉',
      content: '代客户到机构咨询问诊',
      pic: $r('app.media.equity_half_day'),
      price: 258,
      type: 202,
      name: '代办问诊'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '李先生',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-12-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '李三',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ202508234568074',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '待约检查',
    hospital_name: '协和医院本院区',
    starttime: '2025-12-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '653f34ee189f86f5be340e3c',
      anchor: 'SV1001',
      city: '南京',
      content: 'MRI/胃肠镜、CT/超声检查',
      pic: $r('app.media.equity_half_day'),
      price: 178,
      type: 203,
      name: '待约检查'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '吴女士',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-12-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '吴思',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ2025897654168874',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '代办买药',
    hospital_name: '协和医院本院区',
    starttime: '2025-10-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '652df1d7213929cbce22e41e',
      anchor: 'SV1001',
      city: '南京',
      content: '人工排队代买药',
      pic: $r('app.media.equity_buy_medicine'),
      price: 258,
      type: 204,
      name: '代办买药'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '吴女士',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-10-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '吴金',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ2025082344168874',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '专享半天陪诊',
    hospital_name: '协和医院本院区',
    starttime: '2025-10-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '6823e672ee97ef53e40cf92b',
      anchor: 'SV1001',
      city: '南京',
      content: '半天（4小时）专享陪同就医服务',
      pic: $r('app.media.equity_half_day'),
      price: 258,
      type: 205,
      name: '半天陪诊服务'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '吴女士',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-10-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '吴姣',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ20250826665874',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '专享半天陪诊',
    hospital_name: '协和医院本院区',
    starttime: '2025-10-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '6823e672ee97ef53e40cf92b',
      anchor: 'SV1001',
      city: '南京',
      content: '半天（4小时）专享陪同就医服务',
      pic: $r('app.media.equity_half_day'),
      price: 258,
      type: 201,
      name: '半天陪诊服务'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '吴女士',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-10-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '吴一',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ20250826128874',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '专享半天陪诊',
    hospital_name: '协和医院本院区',
    starttime: '2025-10-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '6823e672ee97ef53e40cf92b',
      anchor: 'SV1001',
      city: '南京',
      content: '半天（4小时）专享陪同就医服务',
      pic: $r('app.media.equity_half_day'),
      price: 258,
      type: 201,
      name: '半天陪诊服务'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '吴女士',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-10-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '吴三',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ202508264568874',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '专享半天陪诊',
    hospital_name: '协和医院本院区',
    starttime: '2025-10-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '6823e672ee97ef53e40cf92b',
      anchor: 'SV1001',
      city: '武汉',
      content: '半天（4小时）专享陪同就医服务',
      pic: $r('app.media.equity_half_day'),
      price: 258,
      type: 201,
      name: '半天陪诊服务'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '吴女士',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-10-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '吴昊',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ2025082664134574',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '专享半天陪诊',
    hospital_name: '协和医院本院区',
    starttime: '2025-10-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '6823e672ee97ef53e40cf92b',
      anchor: 'SV1001',
      city: '武汉',
      content: '半天（4小时）专享陪同就医服务',
      pic: $r('app.media.equity_half_day'),
      price: 258,
      type: 201,
      name: '半天陪诊服务'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '吴女士',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-10-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '吴浩',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  {
    orderID: 'PZ2025082634268874',
    serviceImg: $r('app.media.equity_half_day'),
    service_name: '专享半天陪诊',
    hospital_name: '协和医院本院区',
    starttime: '2025-10-28 08:00',
    order_remark: '接送取药',
    create_time: 1756199960263,
    _add_time_str: '2025-08-26 17:19:20',
    serve_amount: 258,
    from: 1000,
    mainGood: {
      _id: '6823e672ee97ef53e40cf92b',
      anchor: 'SV1001',
      city: '武汉',
      content: '半天（4小时）专享陪同就医服务',
      pic: $r('app.media.equity_half_day'),
      price: 258,
      type: 201,
      name: '半天陪诊服务'
    },
    order_content: {
      hospital: '协和医院本院区',
      order_name: '吴女士',
      order_sex: '女性陪诊师',
      city: '武汉',
      serve_time: '2025-10-28 08:00',
      order_mobile: '18571720036'
    },
    patient_content: {
      patient_address: '',
      patient_age: 63,
      patient_name: '吴晓',
      patient_remark: '',
      patient_move: '无障碍',
      patient_id: '68ad7bdd6e5d2d42e6a4b93b',
      patient_sex: '男性',
      patient_mobile: '15672351678'
    }
  },
  // {
  //   _id: '658a9484337a9f43948788d1',
  //
  // },
  // {
  //   _id: '653f34ee189f86f5be340e3c',
  //
  // },
  // {
  //   _id: '652df1d7213929cbce22e41e',
  //
  // }
]