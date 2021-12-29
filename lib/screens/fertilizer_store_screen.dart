import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sampah_aja/components/commons/appbar.dart';
import 'package:sampah_aja/components/commons/button.dart';

class FertilizerStoreScreen extends StatelessWidget {
  const FertilizerStoreScreen({Key? key}) : super(key: key);
  static const LatLng _kMapCenter = LatLng(19.018255973653343, 72.84793849278007);
  static const CameraPosition _kInitialPosition = CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
              child: TransparentAppbar(
                child: AppBarButton(
                  onTap: () => Navigator.pop(context),
                  icon: Icons.arrow_back,
                ),
              )
          ),
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kInitialPosition,
          )
        ],
      ),
    );
  }
}
