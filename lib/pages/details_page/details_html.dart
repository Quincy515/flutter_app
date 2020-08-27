import 'package:flutter/material.dart';
import 'package:flutter_app/provider/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class DetailsHTML extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provider.of<DetailsInfoProvide>(context, listen: false)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;
    return Container(
      child: Html(
        data: goodsDetails,
      ),
    );
  }
}
