import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearby_place/core/providers/home_provider.dart';
import 'package:nearby_place/views/widgets/loading_circular.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeProvider? prov;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => prov?.refresh(),
                icon: const Icon(Icons.person_pin_circle_sharp))
          ],
          title: const Text("Search Nearby Place"),
        ),
        body: Consumer<HomeProvider>(builder: (context, prov, _) {
          this.prov = prov;
          return Column(
            children: [
              SizedBox(
                height: 200,
                child: prov.isLoading
                    ? const LoadingCircular()
                    : GoogleMap(
                        markers: prov.marker,
                        mapType: MapType.normal,
                        onMapCreated: prov.onMapCreated,
                        onCameraMove: (position) => prov.oncameraMove(position),
                        initialCameraPosition: prov.initialMapLocation),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Cari tempat terdekat",
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16))),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
