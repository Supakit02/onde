import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class HomeMenu {
//   final String title;
//   final IconData icon;

//   const HomeMenu({required this.title, required this.icon});

//   static Widget buildMenu(
//       {required HomeMenu item, required VoidCallback onTap}) {
//     return ListTile(
//       minLeadingWidth: 20,
//       leading: Icon(item.icon),
//       title: Text(item.title),
//       onTap: onTap,
//     );
//   }
// }

// List<HomeMenu> homeMenu = [
//   HomeMenu(title: "History", icon: Icons.history),
//   HomeMenu(title: "About Us", icon: Icons.error_outline)
// ];

// class MenuBuilder extends StatefulWidget {
//   MenuBuilder({Key? key}) : super(key: key);

//   @override
//   _MenuBuilderState createState() => _MenuBuilderState();
// }

// class _MenuBuilderState extends State<MenuBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class BuildMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const BuildMenu(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 20,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(title,
          style: GoogleFonts.nunito(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400)),
      onTap: onTap,
    );
  }
}
