part of '../index.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = Get.put(MapController());

  @override
  void initState() {
    super.initState();
    var location = Get.arguments as LocationModel;
    mapController.setTargetLocation(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Property Location",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Obx(() => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: mapController.targetLocation.value,
              zoom: 15.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('property_location'),
                position: mapController.targetLocation.value,
              ),
            },
            onMapCreated: mapController.onMapCreated,
          )),
    );
  }
}
