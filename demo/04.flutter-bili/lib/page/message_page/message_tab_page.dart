import 'package:e_social_work/http/dao/ranking_dao.dart';
import 'package:e_social_work/model/ranking_mo.dart';
import 'package:e_social_work/model/video_model.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/hi_tab_state.dart';

class MessageTabPage extends StatefulWidget {
  final String sort;
  const MessageTabPage({Key key, @required this.sort}) : super(key: key);

  @override
  _MessageTabPageState createState() => _MessageTabPageState();
}

class _MessageTabPageState
    extends HiBaseTabState<RankingMo, VideoModel, MessageTabPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement contentChild
  get contentChild => Container(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 10),
          itemCount: dataList.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) => VideoLargeCard(
            videoModel: dataList[index],
          ),
        ),
      );

  @override
  Future<RankingMo> getData(int pageIndex) async {
    RankingMo result =
        await RankingDao.get(widget.sort, pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(RankingMo result) {
    return result.list;
  }
}
