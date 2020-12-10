import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shopping_mall/provider/bottom_navigator.dart';

List<SingleChildStatelessWidget> providers = [
  ChangeNotifierProvider.value(value: BottomNaviProvider()),
  // ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
];
