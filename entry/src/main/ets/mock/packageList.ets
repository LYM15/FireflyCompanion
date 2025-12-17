
// 单个服务项
export interface AtomServe {
  _index: string
  _id: string
  times: number
  name: string
  content: string
  pic: string
  price: string | number
  anchor: string
  type: number
  isTransfer: boolean
}

// 套餐规格
export interface Sku {
  _index: string
  name: string
  content: string
  img: string
  price: number
  stock: number
  times: number
}

// 套餐等级
export interface PackageLevel {
  stage: number
  name: string
  remark?: string
}

// 主套餐
export interface PackageInfo {
  _id: string
  number: string
  city: string
  name: string
  content: string
  pic: string
  price: string | number
  packageAnchor: string
  atomServe: AtomServe[]
  sku: Sku[]
  level: PackageLevel
  wait_term: number
  ensure_term: number
  isTransfer: boolean
  isPublic: boolean
  create_time: number
  _add_time: number
  _add_time_str: string
}

export const packageList:PackageInfo[] = [
  {
    "_id": "6530f34709664c3d3304c6a6",
    "number": "1308",
    "city": "通用",
    "name": "代办问诊权益卡",
    "content": "多次代办问诊·一年有效期",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/8463e312-2bd3-4b48-b00b-e2d11d42b167.png",
    "price": "658",
    "packageAnchor": "PK1003",
    "atomServe": [
      {
        "_index": "0wj2hk3ebh2n58ecp4letlsjf",
        "_id": "65645a33f082105ea41702eb",
        "times": 1,
        "name": "代办问诊服务",
        "content": "代客户到机构咨询问诊",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/90751226-03c8-419f-b49a-b7aec4553685.png",
        "price": "258",
        "anchor": "SV1004",
        "type": 201,
        "isTransfer": true
      }
    ],
    "sku": [
      {
        "_index": "w59em8r8b0c4cdj6ikxd97mku",
        "name": "3次服务",
        "content": "3次代问诊服务",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/55c22e9a-7ab5-4ef9-b1b9-03f843d2fa88.png",
        "price": 658,
        "stock": 999,
        "times": 3
      },
      {
        "_index": "6wfqtuywcue83z3713y9tmkbj",
        "name": "5次服务",
        "content": "5次代问诊服务",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/55c22e9a-7ab5-4ef9-b1b9-03f843d2fa88.png",
        "price": 1028,
        "stock": 999,
        "times": 5
      },
      {
        "_index": "xhm3vfacezd8veuk4ef4t6pnv",
        "name": "10次服务",
        "content": "10次代问诊服务",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/55c22e9a-7ab5-4ef9-b1b9-03f843d2fa88.png",
        "price": 1928,
        "stock": 999,
        "times": 10
      }
    ],
    "level": {
      "stage": 1,
      "name": "微信公开套餐",
      "remark": "可公开售卖的套餐"
    },
    "wait_term": 0,
    "ensure_term": 365,
    "isTransfer": true,
    "isPublic": true,
    "create_time": 1697706821000,
    "_add_time": 1697706823478,
    "_add_time_str": "2023-10-19 17:13:43"
  },
  {
    "_id": "658a9484337a9f43948788d1",
    "number": "1302",
    "city": "通用",
    "name": "半天陪诊权益卡",
    "content": "多次半天陪诊 · 一年有效期",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/286f16c3-9833-44a4-8a9d-a3570944e679.png",
    "price": "738",
    "packageAnchor": "PK1001",
    "atomServe": [
      {
        "_index": "5l7wubttxewvrq9bffhraa8ku",
        "_id": "652df114a7c432fcf86447db",
        "times": 1,
        "name": "半天陪诊服务",
        "content": "专享1对1半天陪诊，最长4小时",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/8e7b7122-e453-46da-aaa9-2c336936ad99.png",
        "price": "288",
        "anchor": "SV1001",
        "type": 201,
        "isTransfer": true
      }
    ],
    "sku": [
      {
        "_index": "1hc9ba47vmzuoq3ccdpqi9oqa",
        "name": "3次服务",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/962f18c4-ef9f-4cdf-8734-0c52de8136fd.png",
        "content": "3次陪诊服务",
        "price": 738,
        "stock": 9999,
        "times": 3
      },
      {
        "_index": "oll4r2rj1nsciqo5eosj1nr65",
        "name": "5次服务",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/8f43b3ef-2189-40b4-b2cf-b1a2d766c216.png",
        "content": "5次陪诊服务",
        "price": 1158,
        "stock": 9999,
        "times": 5
      },
      {
        "_index": "ei4305elu56wz2kl09ws6o9hz",
        "name": "10次服务",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/8f43b3ef-2189-40b4-b2cf-b1a2d766c216.png",
        "content": "10次陪诊服务",
        "price": 2158,
        "stock": 9999,
        "times": 10
      }
    ],
    "level": {
      "stage": 1,
      "name": "微信公开套餐",
      "remark": "可公开售卖的套餐"
    },
    "wait_term": 0,
    "ensure_term": 365,
    "isTransfer": true,
    "isPublic": true,
    "create_time": 1697525793000,
    "_add_time": 1703580804111,
    "_add_time_str": "2023-12-26 16:53:24"
  },
  {
    "_id": "658a949c7ad52d5932e11e8b",
    "number": "1304",
    "city": "通用",
    "name": "代办买药权益卡",
    "content": "多次代办买药·一年有效期",
    "pic": "https://mp-b5004239-46a6-403a-8597-de3ff75aabbf.cdn.bspapp.com/cloudstorage/2c5f5eb6-0ba2-4ef5-923f-71cb24510123.png",
    "price": "378",
    "packageAnchor": "PK1002",
    "atomServe": [
      {
        "_index": "igtibrn3pi7fcpc9l30poeffn",
        "_id": "65645a75a09a9b17674b3a99",
        "times": 1,
        "name": "代办买药服务",
        "content": "人工排队代买药服务",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/d8a09b39-984f-42ea-8e04-cfa705940896.png",
        "price": "148",
        "anchor": "SV1005",
        "type": 201,
        "isTransfer": true
      }
    ],
    "sku": [
      {
        "_index": "0czn84jx6qmpp9ds62ehtk0oo",
        "name": "3次服务",
        "content": "3次代办买药服务",
        "img": "https://mp-b5004239-46a6-403a-8597-de3ff75aabbf.cdn.bspapp.com/cloudstorage/4b690a28-8d28-4b69-922b-0d913283b2e7.png",
        "price": 378,
        "stock": 9999,
        "times": 3
      },
      {
        "_index": "rvrqh5260ytxntm4q6fx7se2e",
        "name": "5次服务",
        "content": "5次代办买药服务",
        "img": "https://mp-b5004239-46a6-403a-8597-de3ff75aabbf.cdn.bspapp.com/cloudstorage/045d2d84-612b-4676-8970-e4d561f2e4e7.png",
        "price": 588,
        "stock": 9999,
        "times": 5
      },
      {
        "_index": "oqjofcniohcp02gzaqlqjlon2",
        "name": "10次服务",
        "content": "10次代办买药服务",
        "img": "https://mp-b5004239-46a6-403a-8597-de3ff75aabbf.cdn.bspapp.com/cloudstorage/552cca0c-45ea-40aa-8c8f-eedc98cc8e3b.png",
        "price": 1108,
        "stock": 9999,
        "times": 10
      }
    ],
    "level": {
      "stage": 1,
      "name": "微信公开套餐",
      "remark": "可公开售卖的套餐"
    },
    "wait_term": 0,
    "ensure_term": 365,
    "isTransfer": true,
    "isPublic": true,
    "create_time": 1701076491000,
    "_add_time": 1703580828009,
    "_add_time_str": "2023-12-26 16:53:48"
  },
  {
    "_id": "68254d846523417562e8a174",
    "number": "1601",
    "city": "通用",
    "name": "绿通权益服务",
    "content": "快速高效就医+蓝色保障",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/71d82456-9f64-4b99-9525-d14ae8e7da73.png",
    "price": "398",
    "packageAnchor": "PK3001",
    "atomServe": [
      {
        "_index": "f8iyjtvhj7lnkplocsqaca8t1",
        "_id": "652df1d7213929cbce22e41e",
        "times": 1,
        "name": "不指定门诊绿通",
        "content": "三甲医院·不指定专家",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/a5e17d8d-b891-4208-9b4b-9560f41400dd.png",
        "price": "800",
        "anchor": "SV3001",
        "type": 203,
        "isTransfer": true
      },
      {
        "_index": "j0ptouob6o5vynrmlgxeo4a1c",
        "_id": "653f34ee189f86f5be340e3c",
        "times": 1,
        "name": "指定门诊绿通",
        "content": "三甲医院·指定专家",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/a963f20f-c2e6-4e5e-a094-df0b8df8eec8.png",
        "price": "1600",
        "anchor": "SV3002",
        "type": 203,
        "isTransfer": true
      }
    ],
    "sku": [
      {
        "_index": "8gws2v2uiy18k4do3oblniyr6",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/a6c0bf82-eb72-40fd-9a2c-c69363dccfd1.png",
        "name": "速享绿通",
        "content": "不指定普通绿通权益包",
        "price": 398,
        "stock": 9999,
        "times": 1
      },
      {
        "_index": "syyj9r2ahwfcto3vvz9qnb8au",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/a6c0bf82-eb72-40fd-9a2c-c69363dccfd1.png",
        "name": "优享绿通",
        "content": "不指定副主任绿通权益包",
        "price": 598,
        "stock": 9999,
        "times": 1
      },
      {
        "_index": "6wim667aykzr9zrdmu99cwats",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/a6c0bf82-eb72-40fd-9a2c-c69363dccfd1.png",
        "name": "尊享绿通",
        "content": "不指定主任绿通权益包",
        "price": 798,
        "stock": 9999,
        "times": 1
      },
      {
        "_index": "4obi0uimwihmhq57yil3skwo2",
        "img": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/a6c0bf82-eb72-40fd-9a2c-c69363dccfd1.png",
        "name": "臻享绿通",
        "content": "指定专家绿通权益包",
        "price": 998,
        "stock": 9999,
        "times": 1
      }
    ],
    "level": {
      "stage": 1,
      "name": "微信公开套餐"
    },
    "wait_term": 0,
    "ensure_term": 365,
    "isTransfer": true,
    "isPublic": true,
    "create_time": 1747275580000,
    "_add_time": 1747275140376,
    "_add_time_str": "2025-05-15 10:12:20"
  }
]


export interface EquityType {
  _id: string
  name: string
  content: string
  pic: string | Resource
  price: string | number
  times:number
}

export const equityList:EquityType[] = [
  {
    _id: '6530f34709664c3d3304c6a6',
    name: '半天陪诊',
    content: '专享1对1半天陪诊，最长4小时',
    pic: $r('app.media.equity_half_day'),
    price: '258',
    times: 1,
  },
  {
    _id: '658a9484337a9f43948788d1',
    name: '代办问诊',
    content: '代客户到机构咨询问诊',
    pic: $r('app.media.equity_consultation'),
    price: '258',
    times: 1,
  },
  {
    _id: '653f34ee189f86f5be340e3c',
    name: '待约检查',
    content: 'MRI/胃肠镜、CT/超声检查',
    pic: $r('app.media.equity_inspect'),
    price: '178',
    times: 1,
  },
  {
    _id: '652df1d7213929cbce22e41e',
    name: '代办买药',
    content: '人工排队代买药',
    pic: $r('app.media.equity_buy_medicine'),
    price: '148',
    times: 1,
  }
]