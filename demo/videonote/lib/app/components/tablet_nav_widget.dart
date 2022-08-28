import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../flutter_flow/index.dart';

class TabletNavWidget extends StatefulWidget {
  const TabletNavWidget({
    Key? key,
    this.navBgOne,
    this.navColorOne,
    this.navBgTwo,
    this.navColorTwo,
    this.navBgThree,
    this.navColorThree,
    this.navBgFour,
    this.navColorFour,
    this.navBgFive,
    this.navColorFive,
  }) : super(key: key);

  final Color? navBgOne;
  final Color? navColorOne;
  final Color? navBgTwo;
  final Color? navColorTwo;
  final Color? navBgThree;
  final Color? navColorThree;
  final Color? navBgFour;
  final Color? navColorFour;
  final Color? navBgFive;
  final Color? navColorFive;

  @override
  _TabletNavWidgetState createState() => _TabletNavWidgetState();
}

class _TabletNavWidgetState extends State<TabletNavWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      duration: 600,
      delay: 200,
      hideBeforeAnimating: false,
      initialState: AnimationState(
        offset: Offset(-60, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    setupTriggerAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onActionTrigger),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 32),
              child: Image.asset(
                'assets/images/app_varilyIcon@1x.png',
                width: 50,
                height: 50,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: InkWell(
                onTap: () async {
                  context.pushNamed(
                    'HomePage',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.navBgOne,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                    child: Icon(
                      Icons.dashboard_rounded,
                      color: widget.navColorOne,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.navBgTwo,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Icon(
                    Icons.receipt_outlined,
                    color: widget.navColorTwo,
                    size: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.navBgThree,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Icon(
                    Icons.bar_chart_rounded,
                    color: widget.navColorThree,
                    size: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.navBgFour,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Icon(
                    Icons.credit_card,
                    color: widget.navColorFour,
                    size: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.navBgFive,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                  child: Icon(
                    Icons.group_outlined,
                    color: widget.navColorFive,
                    size: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1624561172888-ac93c696e10c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NjJ8fHVzZXJzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animated([animationsMap['containerOnActionTriggerAnimation']!]);
  }
}
