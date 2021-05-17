import 'package:flutter/material.dart';

import 'color.dart';
import 'hi_state.dart';
import 'toast.dart';

// 通用底层带分页和刷新的页面框架
// M 为 Dao 返回的数据模型，L 为列表数据模型，T 为具体的 Widget
abstract class HiBaseTabState<M, L, T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pageIndex = 1;
  bool loading = false;
  ScrollController scrollController = ScrollController();

  get contentChild;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      print('dis:$dis');
      // 当距离底部不足 300 时加载更多
      if (dis < 300 &&
          !loading &&
          // fix 当列表高度不满足屏幕高度时不执行加载更多的解决方法
          scrollController.position.maxScrollExtent != 0) {
        print('---------_loadData---------');
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        onRefresh: loadData,
        color: primary,
        child: MediaQuery.removePadding(
            removeTop: true, context: context, child: contentChild));
  }

  // 获取对应页面的数据
  Future<M> getData(int pageIndex);

  // 从 Model 中解析出 list 数据
  List<L> parseList(M result);

  Future<void> loadData({loadMore = false}) async {
    if (loading) {
      print('上次加载还没有完成...');
      return;
    }
    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print('loading:currentIndex:$currentIndex');
    try {
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          // 合成一个新数组
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            pageIndex++; // 页面页码加1，方便下次直接获取下一页数据
          }
        } else {
          dataList = parseList(result);
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        loading = false;
      });
    } catch (e) {
      loading = false;
      print(e);
      showWarnToast(e.message);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
