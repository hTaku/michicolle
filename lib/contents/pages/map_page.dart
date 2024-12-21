import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
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
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: widget.initialLocation,
            initialZoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
          ]
        )
      ],
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