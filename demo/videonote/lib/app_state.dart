import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _rowLayout = prefs.getBool('ff_rowLayout') ?? _rowLayout;
    _layout = prefs.getString('ff_layout') ?? _layout;
  }

  late SharedPreferences prefs;

  String videoPath =
      'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4';

  bool showIsWarp = true;

  bool _rowLayout = true;
  bool get rowLayout => _rowLayout;
  set rowLayout(bool _value) {
    _rowLayout = _value;
    prefs.setBool('ff_rowLayout', _value);
  }

  String _layout = 'webLeft';
  String get layout => _layout;
  set layout(String _value) {
    _layout = _value;
    prefs.setString('ff_layout', _value);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
