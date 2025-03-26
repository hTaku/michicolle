import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:michicolle/contents/pages/map_page.dart';

class MichicollePage extends StatefulWidget {
  final LatLng initialLocation;
  
  const MichicollePage({super.key, required this.initialLocation});

  @override
  State<MichicollePage> createState() => _MichicolleNavigationState();
}

class _MichicolleNavigationState extends State<MichicollePage> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.location_on),
            label: 'ちず',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'みちこれ！',
          ),
        ],
      ),
      body: <Widget>[
        // TODO: 以下のUIをどうするか？
        /// Notifications page

        /// 地図ページ
        MapPage(initialLocation: widget.initialLocation),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
