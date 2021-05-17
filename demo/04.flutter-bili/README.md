# e_social_work

本项目是杭州 e社工 --- 医务社工管理平台，一个医生，社工，用户及第三方服务整合平台

# 资料
| 资料说明          | 资料链接                                                      |
| ---------------- | ------------------------------------------------------------ |
| 我们的语雀文档记录 | https://www.yuque.com/docs/share/53ed458b-a231-4561-ab61-a011c3d083d0?# 《资料链接》|
| 社工平台产品文档   | https://www.yuque.com/books/share/a14876d0-5abc-47d1-8c08-48043d914539 |
| 页面 UI          | https://www.figma.com/file/w4Z3cGavsuQNFEkOXC8iCN/e%E7%A4%BE%E5%B7%A5_DRD%E6%96%87%E6%A1%A3?node-id=579%3A217 |
| 后端 API Swagger | http://3p9448f078.wicp.vip/index.html |
| 项目管理         | https://www.yuque.com/docs/share/b352b717-96a3-4bda-943c-d40197b4c59f#mvFH |
| EasyMock        | http://103.48.140.39:7300/ 账号密码都是 custer |
| E社工项目 前端---APP端文档地址：| https://www.yuque.com/docs/share/74f2b1f9-dd6f-474a-9d54-3eaec7c2eb23?# 《e社工（社工前端-APP）PRD文档》| 
| E社工项目 前端---小程序端文档地址：| https://www.yuque.com/docs/share/ab87d184-baa3-4f2b-96cd-646366ecc1be?# 《e社工（用户前端-小程序）PRD文档》| 
| E社工项目 前端---APP端UI/交互设计地址：| https://www.figma.com/file/w4Z3cGavsuQNFEkOXC8iCN/e%E7%A4%BE%E5%B7%A5_DRD%E6%96%87%E6%A1%A3?node-id=579%3A217| 
| E社工项目 后端UI/交互设计地址：| https://www.figma.com/file/xHI2swNb8jwHVgxS9zOjJu/e%E7%A4%BE%E5%B7%A5%E5%90%8E%E5%8F%B0-%E5%9B%A2%E9%98%9F%E7%89%88%E6%9C%AC?node-id=2%3A78899| 
| E社工项目 后端 —— 需求文档地址：| https://www.yuque.com/docs/share/d9e8b739-8fc7-4a47-8ba1-b13b8319e72e?# 《E社工-后端开发需求文档》|


filterType枚举介绍“
0：小于等于
1：大于等于
2：等于
3：到...结束
4：以...开始
5：小于
6: 大于
7: 包含
一般筛选条件为 IsDeleted 2 false
```json
{
 "numberPerPage": 10, // 每页 多少 条数据
 "currentPage": 1,    // 第 几 页
 "sortList": [
    {
      "columnName": "CreatedUTC", // 排序
      "sortOrder": 1  // 顺序：0 升序；1 降序
    }
  ],
  "filters": [
    {
      "key": "IsDeleted", // 查询字段
      "filterType": 2,    // 枚举方式
      "value": "false"    // 查询字段的值
    }
  ]
}
``` 