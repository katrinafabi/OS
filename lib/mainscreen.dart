import 'package:campus_map/admininfo.dart';
import 'package:campus_map/mapscreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isMenuExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  // Checkbox states
  bool _isParkingChecked = false;
  bool _isClassroomChecked = false;
  bool _isBathroomChecked = false;
  bool _isCafeteriaChecked = false;
  bool _isGymnasiumChecked = false;
  bool _isLibraryChecked = false;
  bool _isFacultyChecked = false;
  bool _isLaboratoryChecked = false;

  static const TextStyle _filterTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    color: Colors.black,
  );

  static const Color _menuColor = Color.fromARGB(230, 160, 35, 52);
  static const Color _backgroundColor = Color.fromARGB(255, 214, 214, 214);

  void _toggleMenu() {
    setState(() {
      _isMenuExpanded = !_isMenuExpanded;
    });
  }

  void _showDirectionsDialog() {
    final TextEditingController startController = TextEditingController();
    final TextEditingController destinationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Directions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: startController,
                decoration: const InputDecoration(labelText: 'Starting Point'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: destinationController,
                decoration: const InputDecoration(labelText: 'Destination'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Access startController.text and destinationController.text here
                Navigator.of(context).pop();
              },
              child: const Text('Get Directions'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListTile(
      String title, IconData icon, bool isChecked, Function(bool?) onChanged) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: _filterTextStyle),
      trailing: Checkbox(
        value: isChecked,
        onChanged: onChanged,
      ),
      onTap: () {
        setState(() {
          onChanged(!isChecked);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _toggleMenu,
        ),
      ),
      body: Stack(
        children: [
          // Fullscreen map with InteractiveViewer

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search Location',
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 109, 109, 109),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.directions,
                              color: Color.fromARGB(255, 109, 109, 109)),
                          onPressed: _showDirectionsDialog,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Zoom buttons in the bottom right corner

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isMenuExpanded ? 0 : -300,
            top: 0,
            bottom: 0,
            width: 300,
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      color: _menuColor,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    bottom: -13,
                                    child: Image(
                                      image:
                                          AssetImage('assets/image/shadow.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  Image(
                                    image:
                                        AssetImage('assets/image/pinpoint.png'),
                                    width: 60,
                                    height: 60,
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GabayEARIST',
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arquitectura',
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Nagtahan St, Sampaloc, Manila, 1008',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Metro Manila',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.account_circle, color: Colors.black),
                      title:
                          const Text('Account Info', style: _filterTextStyle),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminInfoScreen()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.admin_panel_settings,
                          color: Colors.black),
                      title: const Text('Admin Info', style: _filterTextStyle),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminInfoScreen()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.map, color: Colors.black),
                      title: const Text('Map', style: _filterTextStyle),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapScreen()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help, color: Colors.black),
                      title: const Text('Help', style: _filterTextStyle),
                      onTap: () {
                        // Handle Help tap
                      },
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Tools',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    _buildListTile(
                      'Parking',
                      Icons.local_parking,
                      _isParkingChecked,
                      (bool? value) {
                        setState(() {
                          _isParkingChecked = value ?? false;
                        });
                      },
                    ),
                    _buildListTile(
                      'Classroom',
                      Icons.class_,
                      _isClassroomChecked,
                      (bool? value) {
                        setState(() {
                          _isClassroomChecked = value ?? false;
                        });
                      },
                    ),
                    _buildListTile(
                      'Bathroom',
                      Icons.wc,
                      _isBathroomChecked,
                      (bool? value) {
                        setState(() {
                          _isBathroomChecked = value ?? false;
                        });
                      },
                    ),
                    _buildListTile(
                      'Cafeteria',
                      Icons.local_cafe,
                      _isCafeteriaChecked,
                      (bool? value) {
                        setState(() {
                          _isCafeteriaChecked = value ?? false;
                        });
                      },
                    ),
                    _buildListTile(
                      'Gymnasium',
                      Icons.sports_gymnastics,
                      _isGymnasiumChecked,
                      (bool? value) {
                        setState(() {
                          _isGymnasiumChecked = value ?? false;
                        });
                      },
                    ),
                    _buildListTile(
                      'Library',
                      Icons.library_books,
                      _isLibraryChecked,
                      (bool? value) {
                        setState(() {
                          _isLibraryChecked = value ?? false;
                        });
                      },
                    ),
                    _buildListTile(
                      'Faculty Room',
                      Icons.person,
                      _isFacultyChecked,
                      (bool? value) {
                        setState(() {
                          _isFacultyChecked = value ?? false;
                        });
                      },
                    ),
                    _buildListTile(
                      'Laboratory',
                      Icons.science,
                      _isLaboratoryChecked,
                      (bool? value) {
                        setState(() {
                          _isLaboratoryChecked = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
