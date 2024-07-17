import 'package:bamboobard_frontend/screens/login.screen.dart';
import 'package:bamboobard_frontend/widgets/dialog.widget.dart';
import 'package:bamboobard_frontend/widgets/server_card.widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServerSelectionScreen extends StatefulWidget {
  @override
  _ServerSelectionScreenState createState() => _ServerSelectionScreenState();
}

class _ServerSelectionScreenState extends State<ServerSelectionScreen> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  List<Map<String, String>> _savedServers = [];

  @override
  void initState() {
    super.initState();
    _loadSavedServers();
  }

  Future<void> _loadSavedServers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String>? savedServerStrings = prefs.getStringList('savedServers');
      if (savedServerStrings != null) {
        _savedServers = savedServerStrings
            .map((serverString) {
              var parts = serverString.split(' - ');
              if (parts.length == 1) {
                return {'label': '', 'address': parts[0]};
              }
              return {'label': parts[0], 'address': parts[1]};
            })
            .toList();
      }
    });
  }

  Future<void> _saveServer(String label, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedServers.add({'label': label, 'address': address});
      List<String> savedServerStrings = _savedServers
          .map((server) => server['label']!.isEmpty ? server['address']! : '${server['label']} - ${server['address']}')
          .toList();
      prefs.setStringList('savedServers', savedServerStrings);
    });
  }

  Future<void> _editServer(int index, String label, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedServers[index] = {'label': label, 'address': address};
      List<String> savedServerStrings = _savedServers
          .map((server) => server['label']!.isEmpty ? server['address']! : '${server['label']} - ${server['address']}')
          .toList();
      prefs.setStringList('savedServers', savedServerStrings);
    });
  }

  Future<void> _deleteServer(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedServers.removeAt(index);
      List<String> savedServerStrings = _savedServers
          .map((server) => server['label']!.isEmpty ? server['address']! : '${server['label']} - ${server['address']}')
          .toList();
      prefs.setStringList('savedServers', savedServerStrings);
    });
  }

  String _ensureValidAddress(String address) {
    if (!address.startsWith('http://') && !address.startsWith('https://')) {
      address = 'http://$address';
    }
    final uri = Uri.parse(address);
    if (uri.hasPort) {
      return address;
    }
    return uri.replace(port: 8888).toString();
  }

  Future<void> _checkServerHealth(String address) async {
    final fullAddress = _ensureValidAddress(address);
    try {
      final response = await http.get(Uri.parse('$fullAddress/health'));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == 'healthy') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(serverAddress: fullAddress),
            ),
          );
        } else {
          _showErrorDialog('Server is not healthy. Please try again.');
        }
      } else {
        _showErrorDialog('Failed to connect to the server. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('Failed to connect to the server. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAddServerDialog({int? editIndex}) {
    if (editIndex != null) {
      _labelController.text = _savedServers[editIndex]['label']!;
      _addressController.text = _savedServers[editIndex]['address']!;
    } else {
      _labelController.clear();
      _addressController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          labelController: _labelController,
          addressController: _addressController,
          onSave: () {
            if (_addressController.text.isNotEmpty) {
              if (editIndex != null) {
                _editServer(editIndex, _labelController.text, _addressController.text);
              } else {
                _saveServer(_labelController.text, _addressController.text);
              }
              _labelController.clear();
              _addressController.clear();
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          // Background circles
          Positioned(
            left: -59,
            top: -66,
            child: CircleAvatar(
              radius: 130,
              colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.error],
            ),
          ),
          Positioned(
            right: 0,
            top: 91,
            child: CircleAvatar(
              radius: 130,
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary],
            ),
          ),
          // Title
          Positioned(
            top: 200,
            left: 100,
            right: 100,
            child: Center(
              child: Text(
                'select your server',
                style: TextStyle(
                  fontFamily: 'Maple Mono',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 70,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
          // Server cards
          Positioned(
            top: 300,
            left: 100,
            right: 100,
            child: Center(
              child: Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                alignment: WrapAlignment.center,
                children: _savedServers.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, String> server = entry.value;
                  return ServerCard(
                    server: server['label']!.isEmpty ? server['address']! : server['label']!,
                    onEdit: () {
                      _showAddServerDialog(editIndex: index);
                    },
                    onDelete: () {
                      _deleteServer(index);
                    },
                    onSelect: () {
                      _checkServerHealth(server['address']!);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          // Add server button
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 28.5,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.surface,
              onPressed: () {
                _showAddServerDialog();
              },
              child: Icon(
                Icons.add,
                size: 30,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleAvatar extends StatelessWidget {
  final double radius;
  final List<Color> colors;

  CircleAvatar({required this.radius, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
