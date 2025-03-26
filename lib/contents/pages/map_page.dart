import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:michicolle/contents/pages/routes_dialog.dart';
import 'package:michicolle/utils/permission/location_permission_request.dart';


class MapPage extends StatefulWidget{
  final LatLng initialLocation;

  const MapPage({super.key, required this.initialLocation});

  
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  Timer? _timer;
  LatLng? _currentLocation;
  final location = Location();
  final MapController _mapController = MapController();
  
  @override
  void initState() {
    super.initState();
    _startGetCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: widget.initialLocation,
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: dotenv.get('MAP_TILE_URL'),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.fan,
        fanAngle: 90,
        children: [
          // 国道一覧ダイアログ表示
          FloatingActionButton(
            onPressed: _showRoutesDialog,
            child: Icon(Icons.map),
          ),
          // 現在地表示
          FloatingActionButton(
            onPressed: _showRoutesDialog,
            child: Icon(Icons.near_me),
          ),
        ],
      ),
    );
  }

  void _showRoutesDialog() {
    showDialog(
      context: context,
      builder:(context) => RoutesDialog(),
    );
  }

    // _getLocationの処理を変更
  void _startGetCurrentLocation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      final currentLocation = await GetLocation.getPosition(location);
      setState(() {
        _currentLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        _mapController.move(LatLng(_currentLocation!.latitude, _currentLocation!.longitude), 15.0);
      });
    });
  }
}