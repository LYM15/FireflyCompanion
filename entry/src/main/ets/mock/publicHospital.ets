// 定义热门服务
export interface HotServeItem {
  _index: string;
  name: string;
  content: string;
  pic: string;
  price: number;
  anchor: string;
  type: number;
  url: string;
}

// 定义医院数据
export interface HospitalItem {
  _id: string;
  number: number;
  city: string;
  logo: string;
  name: string;
  rank: string;
  type: string;
  address: string;
  phone: string;
  pic: string;
  desc: string;
  traffic: string;
  hotServe: HotServeItem[];
  isPublic: boolean;
  isHot: boolean;
  _add_time: number;
  _add_time_str: string;
}


export const mockHospital: HospitalItem[] =  [
  {
    "_id": "6576e67cfe975f63af1d7a51",
    "number": 4321,
    "city": "武汉",
    "logo": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/46f95ebb-62a6-498e-923b-b52d75594f49.png",
    "name": "武汉大学人民医院",
    "rank": "三甲",
    "type": "综合医院",
    "address": "湖北武汉市武昌区张之洞路99号解放路238号",
    "phone": "02788041911",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/39502564-0cd3-4541-a8f3-e50ea5ed26de.png",
    "desc": "武汉大学人民医院，又名湖北省人民医院，也为武汉大学第一临床学院，创立于1923年，是湖北地区首家政府举办的公立医院。国家首批三级甲等医院、湖北省人民政府重点建设的窗口医院、全国文明单位、全国精神文明建设先进单位、全国五一劳动奖状集体、全国抗击新冠肺炎疫情先进集体。2020年在中国医院影响力综合排行榜中位居全国第11名，2020年中国科技量值位居全国前20、科技产出排名全国医院第3名。\n\n医院有首义、光谷、洪山等多个院区，设置涵盖现代临床医学的各个临床医技科室127个，位居全国前列。医疗服务辐射到全国乃至海外，2021年医院门诊量580万，位居全国第8，开放病床5200余张，位居全国第10。心、肾、肺移植例数分别位居全国第4、2、7位。\n\n主院区（首义院区）位于武昌张之洞路，开放病床3500张，建有国际一流、功能完善的门诊和住院大楼，手术室均为净化层流到百级或千级标准，重症监护室、导管室等均设备先进、管理一流，PET/CT、PET/MRI、Revolution CT、大孔径静音MRI、IGRT肿瘤放疗直线加速器等国际先进医疗设备一应俱全。东院区（光谷院区）位于武汉东湖新技术开发区，按照高新科技化、人文化、山水园林化和国际化标准建设，开放病床1700张。洪山院区是湖北省重大疫情救治基地，着眼建设世界一流的综合医疗中心、以人为本的花园疗养胜地、面向未来的国际研究基地，规划于2022年底建成。汉南院区致力于打造中部唯一、全国第四家重离子医院，以重离子医学中心为优势，建设治疗中心、医学中心、工程设备中心和数据同步交流中心。",
    "traffic": "1、地铁线路：地铁4号线复兴路站下车（D出口）\n2、公交线路：张之洞路人民医院站、长江大桥黄鹤楼南路、解放路紫阳路站下车",
    "hotServe": [
      {
        "_index": "f6p9hkyu951417t2s10crsvh1",
        "name": "陪诊服务",
        "content": "陪你去医院/代你去医院，就医没烦恼",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/9fcc9d84-61e2-4b38-8b14-2f6a898e039a.png",
        "price": 288,
        "anchor": "SV1001",
        "type": 1,
        "url": "63b6e4a6e1a35c358cc49186"
      },
      {
        "_index": "kqwqdqexzpngjlg8yu4xp0we4",
        "name": "门诊绿通",
        "content": "指定专家协助约号，全程代办服务",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/c1e88cef-21ba-462f-b9c0-5d41a4d19752.png",
        "price": 1680,
        "anchor": "PK3002",
        "type": 2,
        "url": "656460a5862066d0704757e3"
      }
    ],
    "isPublic": true,
    "isHot": true,
    "_add_time": 1702291068906,
    "_add_time_str": "2023-12-11 18:37:48"
  },
  {
    "_id": "6576e6bef082105ea43a86f8",
    "number": 4322,
    "city": "武汉",
    "logo": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/8a694c32-a569-4b2a-bd8f-02e7c54aacb9.png",
    "name": "华中科技大学同济医学院附属协和医院",
    "rank": "三甲",
    "type": "综合医院",
    "address": "湖北省武汉市解放大道1277号",
    "phone": "02785726114",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/6c99d02e-e4da-418e-8b3e-fa03abc5cc50.jpeg",
    "desc": "华中科技大学同济医学院附属协和医院始建于1866年，是扎根武汉历史最悠久的集医疗、教学、科研于一体的国家卫生健康委员会直属的大型综合性医院，是湖北省急救中心、湖北省远程医学中心挂靠单位，系国家首批三级甲等医院、全国百佳医院，荣获全国五一劳动奖状和全国文明单位等国家级荣誉。 \n\n医院由本部、西院、肿瘤中心和金银湖医院组成，编制床位5000张，年门急诊量670万人次，住院量29.8万人次，住院手术11.4万人次，主要医疗指标稳居国内前列。其中心脏移植领跑全国，心肺联合移植术、连体婴儿分离术、骨髓移植、腔镜下巨结肠切除术、细胞治疗临床研究等居国内领先水平。\n\n医院现有在职职工7742人，其中，高级职称近700人，享受国务院政府特殊津贴专家97人，双聘院士7人，国家杰出青年基金获得者7人，卫生系统突出贡献中青年专家12人，入选湖北省医学领军人才工程第一层次5人；博导264人，硕导532人。拥有10个国家重点（培育）学科和25个国家临床重点专科，15个专科挂靠湖北省质控中心，形成具有广泛影响的优势学科群。",
    "traffic": "1、轨道交通：乘坐轨道交通2号线，在中山公园下车，步行400米即可达到\n2、公交线路：9路 46路 294路 507路 527路 535路 561路 563路 575路 601路 803路",
    "hotServe": [
      {
        "_index": "f6p9hkyu951417t2s10crsvh1",
        "name": "陪诊服务",
        "content": "陪你去医院/代你去医院，就医没烦恼",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/9fcc9d84-61e2-4b38-8b14-2f6a898e039a.png",
        "price": 288,
        "anchor": "SV1001",
        "type": 1,
        "url": "63b6e4a6e1a35c358cc49186"
      },
      {
        "_index": "kqwqdqexzpngjlg8yu4xp0we4",
        "name": "门诊绿通",
        "content": "指定专家协助约号，全程代办服务",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/c1e88cef-21ba-462f-b9c0-5d41a4d19752.png",
        "price": 1680,
        "anchor": "PK3002",
        "type": 2,
        "url": "656460a5862066d0704757e3"
      }
    ],
    "isPublic": true,
    "isHot": true,
    "_add_time": 1702291134841,
    "_add_time_str": "2023-12-11 18:38:54"
  },
  {
    "_id": "6576e78b6e5d2d335a1f8901",
    "number": 4323,
    "city": "武汉",
    "logo": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/90e98576-e7fa-46b5-a44c-78d2e8b4fadc.png",
    "name": "武汉大学中南医院",
    "rank": "三甲",
    "type": "综合医院",
    "address": "武汉市武昌东湖路169号",
    "phone": "02767812999",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/21819cb4-a4c0-4581-8a20-02c6da647a49.jpeg",
    "desc": "武汉大学中南医院建于1956年，坐落在武昌东湖之滨，毗邻武汉中央文化区楚河汉街。编制床位3300张。医院名医荟萃，拥有高级职称专业人员500余人，博士研究生导师51人，硕士研究生导师195人，21人获国务院政府特殊津贴，8人入选湖北省首届医学领军人才，2人入选武汉大学珞咖杰出学者。\n\n医院学科齐全，有46个临床医技科室，17个教研室和1个检验系，有内科学、外科学、肿瘤学、临床检验诊断学等15个二级学科博士学位授予点，其中11个二级学科可招收博士生，临床医学二级学科硕士学位授予点19个，护理学一级学科硕士学位授予点1个。拥有国家药物临床试验机构、卫生部消化内镜诊疗技术培训基地、肿瘤生物学行为湖北省重点实验室、肠病湖北省重点实验室、移植医学技术湖北省重点实验室、国家中医药管理局中医内分泌科研三级实验室、国家中医药管理局脑血管病与认知障碍二级实验室。",
    "traffic": "1、公交线路：14路、411路、552路、578路\n2、地铁线路：8号线",
    "hotServe": [
      {
        "_index": "f6p9hkyu951417t2s10crsvh1",
        "name": "陪诊服务",
        "content": "陪你去医院/代你去医院，就医没烦恼",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/9fcc9d84-61e2-4b38-8b14-2f6a898e039a.png",
        "price": 288,
        "anchor": "SV1001",
        "type": 1,
        "url": "63b6e4a6e1a35c358cc49186"
      },
      {
        "_index": "kqwqdqexzpngjlg8yu4xp0we4",
        "name": "门诊绿通",
        "content": "指定专家协助约号，全程代办服务",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/c1e88cef-21ba-462f-b9c0-5d41a4d19752.png",
        "price": 1680,
        "anchor": "PK3002",
        "type": 2,
        "url": "656460a5862066d0704757e3"
      }
    ],
    "isPublic": true,
    "isHot": true,
    "_add_time": 1702291339503,
    "_add_time_str": "2023-12-11 18:42:19"
  },
  {
    "_id": "6576ef0321821b5c0f31c0c5",
    "number": 4324,
    "city": "武汉",
    "logo": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/6ef01cc0-96b6-430a-a952-3204c528c166.png",
    "name": "武汉市中心医院",
    "rank": "三甲",
    "type": "综合医院",
    "address": "武汉市江岸区胜利街26号",
    "phone": "02782811080",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/79430676-bd3d-40cd-b44b-d38311d1e8a1.jpeg",
    "desc": "穿越历史的浩瀚，屹立在长江之畔的武汉市中心医院，已走过了137年的荣光。1880年，在天主教湖北主教明位笃的筹划下，汉口天主堂诊所挂牌应诊，成为武汉市中心医院最早的前身。1914年，诊所扩建为汉口天主堂医院。1955年2月，与原武汉市立第二医院组建成新的“武汉市第二医院”。1999年12月，武汉市第二医院正式增挂院名“武汉市中心医院”。2010年6月，挂牌华中科技大学同济医学院附属武汉中心医院；2016年9月，正式成为直属附属医院暨华中科技大学同济医学院第五临床学院。历经137年的建设发展，医院如今已成为一所融医疗、科研、教学、预防、培训为一体的大型现代化三级甲等医院，综合实力位居湖北省三级医院第一方阵。\n\n医院由南京路院区、后湖院区、谌家矶医养结合示范院区、新洲院区和两个独立门诊部组成，开放床位3378张。设有38个临床科室、10个医技科室、25个教研室和1个武汉市肿瘤研究所。糖尿病中心被市政府确定为“中国中部糖尿病医疗中心”，拥有中部医疗服务中心2个，省级临床重点专科25个，市级临床重点专科39个，初步形成了以“心血管疾病诊疗中心、肿瘤诊疗中心、妇科疾病诊疗中心、糖尿病诊疗中心”四大中心为龙头的重点专学科群，重点专科数量和级别位居全省前列。",
    "traffic": "1、轨道交通：乘轨道交通1号线于循礼门站换乘2号线到江汉路站（C口）出站，往东100米即到；乘轨道交通2号线到江汉路站（C口）出站，往东100米即到；乘轨道交通3号线于范湖站换乘2号线到江汉路站（C口）出站，往东100米即到；乘轨道交通4号线于洪山广场站换乘2号线到江汉路站（C口）出站，往东100米即到；乘轨道交通6号线到江汉路站（C口）出站，往东100米即到\n2、公交线路：乘7、9、68、212、248、313、523、527、595、721、737、793路公汽于沿江大道武汉港站下",
    "hotServe": [
      {
        "_index": "f6p9hkyu951417t2s10crsvh1",
        "name": "陪诊服务",
        "content": "陪你去医院/代你去医院，就医没烦恼",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/9fcc9d84-61e2-4b38-8b14-2f6a898e039a.png",
        "price": 288,
        "anchor": "SV1001",
        "type": 1,
        "url": "63b6e4a6e1a35c358cc49186"
      },
      {
        "_index": "kqwqdqexzpngjlg8yu4xp0we4",
        "name": "门诊绿通",
        "content": "指定专家协助约号，全程代办服务",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/c1e88cef-21ba-462f-b9c0-5d41a4d19752.png",
        "price": 1680,
        "anchor": "PK3002",
        "type": 2,
        "url": "656460a5862066d0704757e3"
      }
    ],
    "isPublic": true,
    "isHot": true,
    "_add_time": 1702293251971,
    "_add_time_str": "2023-12-11 19:14:11"
  },
  {
    "_id": "6576ef98f082105ea43c3eeb",
    "number": 4325,
    "city": "武汉",
    "logo": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/153e5f89-ff4e-4429-a940-7ae39b407114.png",
    "name": "武汉市妇女儿童医疗保健中心",
    "rank": "三甲",
    "type": "综合医院",
    "address": "湖北省武汉市江岸区香港路100号",
    "phone": "02782433350",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/fbaedc3d-fba6-424b-a2df-5fc5f18ad753.jpeg",
    "desc": "武汉儿童医院成立于1954年12月，2003年9月与武汉市妇幼保健院合并成立武汉市妇女儿童医疗保健中心。2016年10月，挂牌华中科技大学同济医学院附属武汉儿童医院/第六临床学院。2018年10月，获批湖北省儿童医疗中心。\n\n医院已形成“一院三区”的发展格局，编制床位2660张（主院区2000张，西院区660张），实际开放床位1539张，职工3000余人，其中医师892人，中高级职称占比61.43%，硕博士占比81.84%。医院最高门急诊量307万人次，出院病人10.3万人次，手术病人4.1万人次，分娩量10034人。\n\n医院综合实力稳居全国儿科第一方阵，是中国儿科发展联盟首届常务理事单位，中华医学会儿科学分会和小儿外科学分会全国委员单位，小儿放射影像专业为全国组长单位，小儿神经内科、小儿病理及放射介入为全国副组长单位。小儿内科位列复旦全国医院排行榜第17位，儿童专科医院第10位，专科声誉榜华中地区儿童专科医院第2位，综合实力榜位居武汉市属医院第1位。2021年度中国医院科学量值（STEM）,儿科学位列全国妇儿专科医院第12位，妇产科学位列全国妇儿专科医院第10位，变态反应学、传染病学、精神病学等5个学科全部进入全国百强。",
    "traffic": "1、地铁直达：3、6、7号线，香港路站B出口\n2、公交直达：香港路儿童医院站：534、553、706、726；澳门路、开明路站：7、533、598、608、610、711、716、801",
    "hotServe": [
      {
        "_index": "f6p9hkyu951417t2s10crsvh1",
        "name": "陪诊服务",
        "content": "陪你去医院/代你去医院，就医没烦恼",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/9fcc9d84-61e2-4b38-8b14-2f6a898e039a.png",
        "price": 288,
        "anchor": "SV1001",
        "type": 1,
        "url": "63b6e4a6e1a35c358cc49186"
      },
      {
        "_index": "kqwqdqexzpngjlg8yu4xp0we4",
        "name": "门诊绿通",
        "content": "指定专家协助约号，全程代办服务",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/c1e88cef-21ba-462f-b9c0-5d41a4d19752.png",
        "price": 1680,
        "anchor": "PK3002",
        "type": 2,
        "url": "656460a5862066d0704757e3"
      }
    ],
    "isPublic": true,
    "isHot": true,
    "_add_time": 1702293400106,
    "_add_time_str": "2023-12-11 19:16:40"
  },
  {
    "_id": "6576f075337a9f0756c959ba",
    "number": 4328,
    "city": "武汉",
    "logo": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/1a7652f6-419d-4fa9-a313-0616839c54e2.png",
    "name": "武汉地区-其他医院",
    "rank": "三甲",
    "type": "综合医院",
    "address": "萤火虫陪诊服务范围覆盖全市",
    "phone": "4001791580",
    "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/96e82710-e81a-4886-b3b1-bf82c857ad76.png",
    "desc": "暂无",
    "traffic": "暂无",
    "hotServe": [
      {
        "_index": "f6p9hkyu951417t2s10crsvh1",
        "name": "陪诊服务",
        "content": "陪你去医院/代你去医院，就医没烦恼",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/9fcc9d84-61e2-4b38-8b14-2f6a898e039a.png",
        "price": 288,
        "anchor": "SV1001",
        "type": 1,
        "url": "63b6e4a6e1a35c358cc49186"
      },
      {
        "_index": "kqwqdqexzpngjlg8yu4xp0we4",
        "name": "门诊绿通",
        "content": "指定专家协助约号，全程代办服务",
        "pic": "https://mp-a447586d-2654-4b5d-83b5-6facf8c755eb.cdn.bspapp.com/cloudstorage/c1e88cef-21ba-462f-b9c0-5d41a4d19752.png",
        "price": 1680,
        "anchor": "PK3002",
        "type": 2,
        "url": "656460a5862066d0704757e3"
      }
    ],
    "isPublic": true,
    "isHot": false,
    "_add_time": 1702293621240,
    "_add_time_str": "2023-12-11 19:20:21"
  }
]

// 定义接口
export interface MedicalChaperonItem {
  key: number;
  name: string;
}

// 生成模拟数据
export const medicalChaperonData: MedicalChaperonItem[] = [
  { key: 0, name: "都可以" },
  { key: 1, name: "男性陪诊师" },
  { key: 2, name: "女性陪诊师" }
];