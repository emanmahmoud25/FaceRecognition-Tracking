import 'package:rive/rive.dart';

//constructre to make icons animations in bottmnavigator
class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;
  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

//list to make it easy  it connected with constructre
List<RiveAsset> bottomNavs = [
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Chat"),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: "Search"),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "Timer"),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
      title: "Favorites"),
  // RiveAsset("assets/RiveAssets/icons.riv",
  //     artboard: "BELL",
  //     stateMachineName: "BELL_Interactivity",
  //     title: "Notifications"),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
];
List<RiveAsset> sideMenus = [
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "HOME", stateMachineName: "HOME_interactivity", title: "Home"),
  RiveAsset("assets/RiveAssets/iconss.riv",
      artboard: "map", stateMachineName: "map_interactivity", title: "Map"),
  RiveAsset("assets/RiveAssets/iconss.riv",
      artboard: "GPS", stateMachineName: "gps_interactivity", title: "GPS"),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Help")
];
List<RiveAsset> sideMenu2 = [
  RiveAsset("assets/RiveAssets/iconsss.riv",
      artboard: "SIGNOUT", stateMachineName: "state_machine", title: "SignOut"),
  RiveAsset("assets/RiveAssets/iconsss.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Delete"),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notifications"),
];
