import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:michicolle/service/http/http_service.dart';
import 'package:michicolle/service/model/http/route.dart' as michicolle;

class RoutesDialog extends StatefulWidget {
  const RoutesDialog({super.key});

  @override
  State<RoutesDialog> createState() => _RoutesDialog();
}

class _RoutesDialog extends State<RoutesDialog> {
  List<michicolle.Route> routeList = [];

  @override
  void initState() {
    super.initState();

    // 全国道の一覧を取得するAPIを実行
    HttpStore.getRouteList().then(
      (routes) {
        setState(() {
          routeList = routes;  // routeList を更新
        });
      },
    ).catchError((error) {
      if (kDebugMode) {
        print("error: $error");
      }
      throw error;
    });
  }


  @override
  Widget build(BuildContext context) {
    var shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0));

    return Dialog(
      shape: shape,
      child: Card(
        shape: shape,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "国道の一覧",
                  style: TextStyle(fontSize: 24)
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close))
              ],
            ),
            routeList.isEmpty
              ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'データがありません。',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount: routeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                      leading: Icon(Icons.route),
                      title: Text(routeList[index].name),
                      onTap: () => Navigator.pop(context, routeList[index].id),
                    );
                    }
                  ),
                )
          ],
        )
      )
    );
  }

}
