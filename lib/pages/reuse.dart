import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techxcel11/pages/AdminProfilePage.dart';
import 'package:techxcel11/pages/Admin_home.dart';
import 'package:techxcel11/pages/ChatPage.dart';
import 'package:techxcel11/pages/Fhome.dart';
import 'package:techxcel11/pages/FreelancerPage.dart';
import 'package:techxcel11/pages/UserCoursesAndEventsPage.dart';
import 'package:techxcel11/pages/UserProfilePage.dart';
import 'package:techxcel11/pages/aboutus.dart';
import 'package:techxcel11/pages/bookmark.dart';
import 'package:techxcel11/pages/CalendarPage.dart';
import 'package:techxcel11/pages/user_posts_page.dart'; //m
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techxcel11/pages/start.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NavBarUser extends StatefulWidget {
  const NavBarUser({super.key});

  @override
  _NavBarUserState createState() => _NavBarUserState();
}

class _NavBarUserState extends State<NavBarUser> {
  String loggedInUsername = '';
  String loggedInEmail = '';
  String loggedImage = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('loggedInEmail') ?? '';
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs[0].data();

      final username = userData['userName'] ?? '';
      final imageUrl = userData['imageUrl'] ?? '';

      setState(() {
        loggedInUsername = username;
        loggedInEmail = email;
        loggedImage = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              loggedInUsername,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            accountEmail: Text(
              loggedInEmail,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            currentAccountPicture: loggedImage.isNotEmpty
                ? CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        loggedImage,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox(),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  255, 62, 0, 61), // Set the desired background color here

              image: DecorationImage(
                image: AssetImage('assets/Backgrounds/bg11.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, size: 27),
            iconColor: Colors.black,
            title: const Text('Profile'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfilePage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.post_add, size: 27),
            iconColor: Colors.black,
            title: const Text('My Interactions'),
            onTap: () async {
              await fetchUserData(); // Fetch user data and assign the value to 'loggedInEmail'
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPostsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark, size: 27),
            iconColor: Colors.black,
            title: const Text('Bookmark'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookmarkPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month, size: 27),
            iconColor: Colors.black,
            title: const Text('Calendar'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CalendarPage()),
            ),
          ),
          ListTile(
            leading: Container(
              width: 30, // Adjust the width as needed
              height: 100, // Adjust the height as needed
              child: Image.asset(
                  'assets/Backgrounds/Xlogo.png'), // Replace 'image_name.png' with the actual image file name and extension
            ),
            title: const Text('About Us'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutUsPage()),
            ),
          ),
          SizedBox(height: 260),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, size: 30),
            iconColor: Colors.black,
            title: const Text('Logout'),
            onTap: () {
              showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

class NavBarAdmin extends StatefulWidget {
  const NavBarAdmin({super.key});

  @override
  _NavBarAdminState createState() => _NavBarAdminState();
}

class _NavBarAdminState extends State<NavBarAdmin> {
  String loggedInUsername = '';
  String loggedInEmail = '';
  String loggedImage = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('loggedInEmail') ?? '';
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final userData = snapshot.docs[0].data();
      final username = userData['userName'] ?? '';
      final imageUrl = userData['imageUrl'] ?? '';

      setState(() {
        loggedInUsername = username;
        loggedInEmail = email;
        loggedImage = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(loggedInUsername),
            accountEmail: Text(
              loggedInEmail,
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/Backgrounds/defaultUserPic.png',
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 39, 0, 73),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            iconColor: Colors.black,
            title: const Text('Profile'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminProfile()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.groups_2_rounded),
            iconColor: Colors.black,
            title: const Text('Dashboard'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminHome()),
            ),
          ),
          SizedBox(height: 430),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            iconColor: Colors.black,
            title: const Text('Logout'),
            onTap: () {
              showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, bool modifiable,
    {int? maxLines}) {
  Color boxColor = modifiable
      ? const Color.fromARGB(255, 200, 176, 185).withOpacity(0.3)
      : const Color.fromARGB(255, 165, 165, 165);

  return TextField(
    enabled: modifiable,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: const Color.fromARGB(255, 43, 3, 101),
    style: TextStyle(
      color: const Color.fromARGB(255, 1, 9, 111).withOpacity(0.9),
      fontSize: 14,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 63, 12, 118)),
      labelText: text,
      labelStyle: const TextStyle(
        color: Colors.black54,
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromARGB(255, 228, 228, 228).withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        //borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    maxLines: isPasswordType ? 1 : maxLines,
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

AppBar buildAppBar(String titleText) {
  return AppBar(
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
    backgroundColor: const Color.fromRGBO(37, 6, 81, 0.898),
    toolbarHeight: 100, // Adjust the height of the AppBar
    elevation: 0, // Adjust the position of the AppBar
    shape: const ContinuousRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(130),
        bottomRight: Radius.circular(130),
      ),
    ),
    title: Text(
      titleText,
      style: const TextStyle(
        fontSize: 18, // Adjust the font size
        fontFamily: "Poppins",
        color: Colors.white,
      ),
    ),
  );
}

void showSnackBar(String message, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 80,
        right: 20,
        left: 20,
      ),
      backgroundColor: Color.fromARGB(255, 63, 12, 118),
    ),
  );
}

void toastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: Color.fromRGBO(37, 6, 81, 0.898),
    textColor: Color(0xffffffff),
    gravity: ToastGravity.TOP,
  );
}

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentTappedIndex = -1;

  void _navigateToPage(BuildContext context, int index) {
    setState(() {
      _currentTappedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FreelancerPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FHomePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const UserCoursesAndEventsPage()),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FHomePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => _navigateToPage(context, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.solidMessage,
                  size: 18.5,
                  color: _currentTappedIndex == 0 ? Colors.blue : Colors.black,
                ),
                Text(
                  'Chat',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _navigateToPage(context, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.handshakeSimple,
                  size: 20,
                  color: _currentTappedIndex == 1 ? Colors.blue : Colors.black,
                ),
                Text(
                  'Freelancer',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _navigateToPage(context, 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.home,
                  size: 20,
                  color: _currentTappedIndex == 2 ? Colors.blue : Colors.black,
                ),
                Text(
                  ' Home',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _navigateToPage(context, 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.explore,
                  size: 22.5,
                  color: _currentTappedIndex == 3 ? Colors.blue : Colors.black,
                ),
                Text(
                  'Explore',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              logUserOut(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}

void logUserOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInEmail');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  } catch (e) {
    print('$e');
    _showSnackBar(context, "Logout failed");
  }
}

void _showSnackBar(BuildContext context, String message) {
  final SnackBar snackBar = SnackBar(
    content: Text(message),
    //behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: Color.fromARGB(255, 63, 12, 118),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

///

class DropDownWidget extends StatefulWidget {
  DropDownWidget({
    Key? key,
    required this.selectedItem,
    required this.list,
    required this.onItemSelected,
    this.fontSize = 16,
  }) : super(key: key);

  late final String selectedItem;
  final void Function(String?) onItemSelected;
  final List<String> list;
  final double fontSize;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class DropDownMenu extends StatelessWidget {
  const DropDownMenu({
    Key? key,
    required this.option,
    required this.onTap,
    required this.items,
    required this.isMenuOpen, // Add isMenuOpen parameter
    this.fontSize = 12,
  }) : super(key: key);

  final String option;
  final List<String> items;
  final double fontSize;
  final ValueChanged<String?> onTap;
  final bool isMenuOpen; // Declare isMenuOpen property

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: option,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                width: 120, // Adjust the width of the dropdown list
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: onTap,
          onTap: () {
            if (isMenuOpen) {
              onTap(null); // Close the menu when tapped outside the options
            }
          },
        ),
      ),
    );
  }
}

class _DropDownWidgetState extends State<DropDownWidget> {
  bool isMenuOpen = false; // Track the menu open/closed state

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMenuOpen ? 90 : 58, // Adjust the height based on the menu state
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isMenuOpen = !isMenuOpen; // Toggle the menu state
                });
              },
              child: DropDownMenu(
                option: widget.selectedItem,
                onTap: widget.onItemSelected,
                fontSize: widget.fontSize,
                items: widget.list,
                isMenuOpen: isMenuOpen, // Pass the menu state to DropDownMenu
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//////Pop to show in Events Post Screen
showAlertDialog(context, Widget child,
    {okButtonText = 'Ok',
    onPress = null,
    showCancelButton = true,
    dismissible = true}) {
  showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 0),
      transitionBuilder: (_, anim, __, child) {
        var begin = 1.0;
        var end = 1.0;
        var curve = Curves.easeIn;
        if (anim.status == AnimationStatus.reverse) {
          curve = Curves.easeOut;
        }
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: anim.drive(tween),
          child: child,
        );
      },
      pageBuilder: (BuildContext alertContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Padding(
          padding: const EdgeInsets.only(top: 80.0, bottom: 40),
          child: StatefulBuilder(
            builder: (context, setState) {
              return WillPopScope(
                onWillPop: () {
                  return Future.value(dismissible);
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    child: SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Material(
                          child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(5),
                              child: child),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
}
