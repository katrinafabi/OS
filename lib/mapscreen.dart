import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<String> _floorImages = [
    'assets/image/MISFL5.png',
    'assets/image/MISFL4.png',
    'assets/image/MISFL3.png',
    'assets/image/MISFL2.png',
    'assets/image/MISFL1.png',
  ];

  final List<String> _floorNames = [
    'MIS Building Floor 5',
    'MIS Building Floor 4',
    'MIS Building Floor 3',
    'MIS Building Floor 2',
    'MIS Building Floor 1',
  ];

  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < _floorImages.length - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Map'),
      ),
      body: Stack(
        children: [
          // Stack of floor images
          ...List.generate(_floorImages.length, (index) {
            return AnimatedOpacity(
              opacity: _currentPage == index ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Center(
                child: Image.asset(
                  _floorImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            );
          }),
          // Positioned title for current floor
          Positioned(
            left: 16,
            top: 50, // Adjust the top position as needed
            child: Text(
              _floorNames[_currentPage],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 4.0,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 100, // Adjust top position as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: _previousPage,
                  child: const Icon(Icons.arrow_upward),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: const Icon(Icons.arrow_downward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
