import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../components/index.dart';
import 'home_controller.dart';
import '../../../flutter_flow/index.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
                desktop: false,
              ))
                TabletNavWidget(
                  navBgOne: FlutterFlowTheme.of(context).primaryColor,
                  navColorOne: FlutterFlowTheme.of(context).primaryBtnText,
                  navBgTwo: FlutterFlowTheme.of(context).secondaryColor,
                  navColorTwo: FlutterFlowTheme.of(context).secondaryText,
                  navBgThree: FlutterFlowTheme.of(context).secondaryColor,
                  navColorThree: FlutterFlowTheme.of(context).secondaryText,
                  navBgFour: FlutterFlowTheme.of(context).secondaryColor,
                  navColorFour: FlutterFlowTheme.of(context).secondaryText,
                  navBgFive: FlutterFlowTheme.of(context).secondaryColor,
                  navColorFive: FlutterFlowTheme.of(context).secondaryText,
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
                tabletLandscape: false,
              ))
                WebNavWidget(
                  navBgOne: FlutterFlowTheme.of(context).primaryColor,
                  navColorOne: FlutterFlowTheme.of(context).primaryBtnText,
                  navBgTwo: FlutterFlowTheme.of(context).secondaryColor,
                  navColorTwo: FlutterFlowTheme.of(context).secondaryText,
                  navBgThree: FlutterFlowTheme.of(context).secondaryColor,
                  navColorThree: FlutterFlowTheme.of(context).secondaryText,
                  navBgFour: FlutterFlowTheme.of(context).secondaryColor,
                  navColorFour: FlutterFlowTheme.of(context).secondaryText,
                  navBgFive: FlutterFlowTheme.of(context).secondaryColor,
                  navColorFive: FlutterFlowTheme.of(context).secondaryText,
                ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '导入',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        '文件夹：',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                      ),
                                      FlutterFlowDropDown(
                                        initialOption: controller.dropDownValue.value,
                                        options: const ['根目录', '文件夹1', '文件夹2'],
                                        onChanged: (val) => controller.setDropDownValue(val),
                                        width: 100,
                                        height: 50,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyText2,
                                        hintText: 'Please select...',
                                        elevation: 2,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0,
                                        borderRadius: 0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '选择',
                                    style:
                                    FlutterFlowTheme.of(context).bodyText2,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 2,
                              thickness: 1,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    buttonSize: 30,
                                    icon: Icon(
                                      Icons.folder,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 14,
                                    ),
                                    onPressed: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: MediaQuery.of(context)
                                                .viewInsets,
                                            child: CreateFolderWidget(),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(3),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(3),
                                            topRight: Radius.circular(0),
                                          ),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            '最近',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryBackground,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(3),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(3),
                                          ),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            '名称',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    buttonSize: 30,
                                    icon: Icon(
                                      Icons.format_list_bulleted_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 15,
                                    ),
                                    onPressed: () async {
                                      controller.setShowIsWarp(!controller.showIsWarp.value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (FFAppState().showIsWarp == true)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 0),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 0,
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  direction: Axis.horizontal,
                                  runAlignment: WrapAlignment.start,
                                  verticalDirection: VerticalDirection.down,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 12, 12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.folder,
                                              color: Color(0xFF101213),
                                              size: 60,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 12, 0, 4),
                                              child: Text(
                                                '..',
                                                textAlign: TextAlign.center,
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .keyboard_control_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryText,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 12, 12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.folder,
                                              color: Color(0xFF101213),
                                              size: 60,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 12, 0, 4),
                                              child: Text(
                                                '文件夹',
                                                textAlign: TextAlign.center,
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .subtitle2,
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .keyboard_control_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryText,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 12, 12),
                                        child: InkWell(
                                          onTap: () async {
                                            await Get.toNamed('/note');
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.perm_media_outlined,
                                                color: Color(0xFF101213),
                                                size: 60,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 12, 0, 4),
                                                child: Text(
                                                  '学习视频',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .subtitle2,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      AutoSizeText(
                                                        '12:04',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .lineColor,
                                                        ),
                                                      ),
                                                      AutoSizeText(
                                                        '/',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .lineColor,
                                                        ),
                                                      ),
                                                      AutoSizeText(
                                                        '29:00',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyText2
                                                            .override(
                                                          fontFamily:
                                                          'Poppins',
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .lineColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .keyboard_control_rounded,
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (FFAppState().showIsWarp == false)
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 0),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 0, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.folder,
                                                color: Color(0xFF101213),
                                                size: 60,
                                              ),
                                              Container(
                                                width: 16,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 12, 0, 4),
                                                child: Text(
                                                  '..',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .subtitle2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.keyboard_control_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 0, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.perm_media_outlined,
                                                color: Color(0xFF101213),
                                                size: 60,
                                              ),
                                              Container(
                                                width: 16,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 12, 0, 4),
                                                child: Text(
                                                  '学习视频',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .subtitle2,
                                                ),
                                              ),
                                              Container(
                                                width: 16,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  AutoSizeText(
                                                    '12:04',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .lineColor,
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    '/',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .lineColor,
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    '29:00',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Poppins',
                                                      color: FlutterFlowTheme
                                                          .of(context)
                                                          .lineColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.keyboard_control_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    BottomNavWidget(
                      navOneIcon: Icon(
                        Icons.home_rounded,
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                      navTwoIcon: Icon(
                        Icons.receipt_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      navThreeIcon: Icon(
                        Icons.credit_card_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      navFourIcon: Icon(
                        Icons.bar_chart_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      navFiveIcon: Icon(
                        Icons.group_sharp,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
