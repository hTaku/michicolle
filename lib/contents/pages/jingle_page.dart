import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:michicolle/contents/pages/michicolle_page.dart';
import 'package:michicolle/utils/permission/location_permission_request.dart';

class JinglePage extends StatefulWidget {
  @override
  _JinglePageState createState() => _JinglePageState();
}

class _JinglePageState extends State<JinglePage> {
  final location = Location();  
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // アニメーションを開始
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    _requestLocationPermission();
    GetLocation.getPosition(location).then((location) {
      setState(() {
        final currentLocation = LatLng(location.latitude!, location.longitude!);
        // 3秒後に次の画面へ遷移
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MichicollePage(initialLocation: currentLocation)),
          );
        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 2),
          child: BorderedText(
            strokeWidth: 2.0, //縁の太さ
            strokeColor: Colors.yellow, //縁の色
            child: Text(
              'みちこれ！',
              style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  fontFamily: "keifont",
                  color: Colors.red),
            )
          ),
        ),
      ),
    );
  }

  void _requestLocationPermission() async {
    await LocationPermissionRequest.request(location);
  }

}
