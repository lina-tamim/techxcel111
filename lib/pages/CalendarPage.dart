import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techxcel11/pages/reuse.dart';


class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarUser(),
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display application name in big font
                   Text(
                'TechXcel',
                style: GoogleFonts.orbitron ( // chakraPetch blackOpsOne orbitron
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  ),
              ),

              // Display application logo
              Image.asset('assets/Backgrounds/XlogoSmall.png'),
              SizedBox(height: 30),

              // Brief description of the platform
            ],
          ),
        ),
      ),
    //  bottomNavigationBar:NavBarBottom2(),
    );
  }
}
