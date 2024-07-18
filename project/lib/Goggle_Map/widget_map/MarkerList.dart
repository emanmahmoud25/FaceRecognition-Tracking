import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Goggle_Map/widget_map/customInfowDesign.dart';

// ignore: deprecated_colon_for_default_value, non_constant_identifier_names
CustomInfoWindowController customInfoWindowController =
    CustomInfoWindowController();
final List<Marker> markerList = [
  Marker(
    // visible:true,
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    markerId: const MarkerId('First'),
    position: LatLng(31.209250609231958, 29.945609893149115),
    onTap: () {
      customInfoWindowController.addInfoWindow!(
          const CustomInfoMarker(
            imagePath: "assets/Markers_Photos/مدرسه.jpg",
            locationName: 'مدرسه الشهيد الرائد محمود سامي عبدالرحمن فتحي',
            description:
                'عزبة سعد، قسم سيدى جابر،، 33 إسماعيل حلمي، St، قسم سيدى جابر، محافظة الإسكندرية 5432054',
          ),
          LatLng(31.209250609231958, 29.945609893149115));
    },
  ),
  //Latitude: 31.165875380558603
// Longitude: 29.87280720916553
  Marker(
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    markerId: const MarkerId('Second'),
    position: const LatLng(31.210808722513583, 29.938581276130805),
    onTap: () {
      customInfoWindowController.addInfoWindow!(
          const CustomInfoMarker(
            imagePath: "assets/Markers_Photos/شهيد.jpg",
            locationName: 'الشهيد كمال الدين صلاح',
            description:
                'الشهيد كمال الدين صلاح، عزبة سعد، قسم سيدى جابر، محافظة الإسكندرية 5432015',
          ),
          LatLng(31.210808722513583, 29.938581276130805));
    },

    // infoWindow: const InfoWindow(title: "فلمنج")
  ),
//31.22233747606669, 29.93330111421033
  Marker(
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    markerId: const MarkerId('Third'),
    position: LatLng(31.20370170798445, 29.940230123535784),
    onTap: () {
      customInfoWindowController.addInfoWindow!(
          const CustomInfoMarker(
            imagePath: "assets/Markers_Photos/المدينة الجامعية بنين.jpg",
            locationName: "المدينه الجامعية",
            description:
                'Izbat Saed, Qesm Sidi Gaber، محافظة الإسكندرية 5432034',
          ),
          LatLng(31.20370170798445, 29.940230123535784));
    },
  ),
  Marker(
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    markerId: const MarkerId('Fourth'),
    position: LatLng(31.207144159972405, 29.94695154234286),
    onTap: () {
      customInfoWindowController.addInfoWindow!(
          const CustomInfoMarker(
            imagePath: "assets/Markers_Photos/photo1.jpg",
            locationName: "الحضره",
            description: 'Al-Wardian in Khafaja area \n next to .........',
          ),
          LatLng(31.207144159972405, 29.94695154234286));
    },
  ),

  Marker(
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    markerId: const MarkerId('Sixth'),
    position: LatLng(31.207144159972405, 29.94695154234286),
    onTap: () {
      customInfoWindowController.addInfoWindow!(
          const CustomInfoMarker(
            imagePath: "assets/Markers_Photos/مستشفى.jpg",
            locationName: "مستشفى الجامعة الجديدة",
            description: '6W4W+XV قسم سيدى جابر',
          ),
          LatLng(31.207144159972405, 29.94695154234286));
    },
    ////////////////////
  ),
  Marker(
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    markerId: const MarkerId('Siven'),
    position: LatLng(31.2087159533486, 29.9433548524489),
    onTap: () {
      customInfoWindowController.addInfoWindow!(
          const CustomInfoMarker(
            imagePath: "assets/Markers_Photos/lapoire.jpg",
            locationName: "حلواني لابوار",
            description:
                '6W7V+RX, 35 Victor Emanuel Sq, سيدي جابر، قسم سيدى جابر، محافظة الإسكندرية 5432063',
          ),
          LatLng(31.2087159533486, 29.9433548524489));
    },
  ),
  // Marker(
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
  //   markerId: const MarkerId('eight'),
  //   position: LatLng(31.20766363970322, 29.94366038892485),
  //   onTap: () {
  //     customInfoWindowController.addInfoWindow!(
  //         const CustomInfoMarker(
  //           imagePath: "assets/Markers_Photos/noplace.png",
  //           locationName: "-----------------------",
  //           description: '---------------------------------',
  //         ),
  //         LatLng(31.20766363970322, 29.94366038892485));
  //   },
  // ),
  // Marker(
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  //   markerId: const MarkerId('nine'),
  //   position: LatLng(31.203078686647324, 29.946119767573375),
  //   onTap: () {
  //     customInfoWindowController.addInfoWindow!(
  //         const CustomInfoMarker(
  //           imagePath: "assets/Markers_Photos/noplace.png",
  //           locationName: "-----------------------",
  //           description: '------------------------------------------',
  //         ),
  //         LatLng(31.203078686647324, 29.946119767573375));
  //   },
  // ),
  // Marker(
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  //   markerId: const MarkerId('ten'),
  //   position: LatLng(31.20325142253254, 29.946180205070586),
  //   onTap: () {
  //     customInfoWindowController.addInfoWindow!(
  //         const CustomInfoMarker(
  //             imagePath: "assets/Markers_Photos/noplace.png",
  //             locationName: "--------------------------",
  //             description: '------------------------------------'),
  //         LatLng(31.20325142253254, 29.946180205070586));
  //   },
  // ),
  // Marker(
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  //   markerId: const MarkerId('eleven'),
  //   position: LatLng(31.198192380472808, 29.929810404774884),
  //   onTap: () {
  //     customInfoWindowController.addInfoWindow!(
  //         const CustomInfoMarker(
  //           imagePath: "assets/Markers_Photos/noplace.png",
  //           locationName: "  ---------------------------",
  //           description: '-------------------------------------------',
  //         ),
  //         LatLng(31.198192380472808, 29.929810404774884));
  //   },
  // ),
];
