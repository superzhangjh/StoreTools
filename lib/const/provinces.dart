///省份
enum Province {
  Anhui('安徽省'),
  Bejing('北京市 '),
  Chongqing('重庆市'),
  Fujian('福建省'),
  Gansu('甘肃省'),
  Guangdong('广东省'),
  Guangxi('广西壮族自治区'),
  Guizhou('贵州省'),
  Hainan('海南省'),
  Hebei('河北省'),
  Henan('河南省'),
  Heilongjiang('黑龙江省'),
  Hubei('湖北省'),
  Hunan('湖南省'),
  Jiangsu('江苏省'),
  Jiangxi('江西省'),
  Jilin('吉林省'),
  Liaoning('辽宁省'),
  InnerMongolia('内蒙古自治区'),
  Ningxia('宁夏回族自治区'),
  Qinghai('青海省'),
  Shandong('山东省'),
  Shanxi('山西省'),
  Shaanxi('陕西省'),
  Shanghai('上海市'),
  Sichuan('四川省'),
  Tianjin('天津市'),
  Tibet('西藏自治区'),
  Xinjiang('新疆维吾尔自治区'),
  Yunnan('云南省'),
  Zhejiang('浙江省'),
  Hongkong('香港特别行政区'),
  Macau('澳门特别行政区');

  final String cnName;

  const Province(this.cnName);
}