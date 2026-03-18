import 'package:flutter/material.dart'; 

void main() {
  runApp(const SwitchDemoApp());
}

class SwitchDemoApp extends StatefulWidget {
  const SwitchDemoApp({super.key});

  @override
  State<SwitchDemoApp> createState() => _SwitchDemoAppState();
}

class _SwitchDemoAppState extends State<SwitchDemoApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: ListTileSwitchDemo(
        isDarkMode: _isDark,
        onDarkModeChanged: (value) {
          setState(() {
            _isDark = value;
          });
        },
      ),
    );
  }
}

class ListTileSwitchDemo extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeChanged;

  const ListTileSwitchDemo({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<ListTileSwitchDemo> createState() => _ListTileSwitchDemoState();
}

class _ListTileSwitchDemoState extends State<ListTileSwitchDemo> {
  bool wifi = false;
  bool bluetooth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListTile & Switch Demo"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          /// WIFI
          ListTile(
            leading: const Icon(Icons.wifi),
            title: const Text("Wi-Fi"),
            subtitle: const Text("Enable or disable Wi-Fi"),
            trailing: Switch(
              value: wifi,
              onChanged: (value) {
                setState(() {
                  wifi = value;
                });
              },
            ),
          ),

          /// BLUETOOTH
          ListTile(
            leading: const Icon(Icons.bluetooth),
            title: const Text("Bluetooth"),
            subtitle: const Text("Enable or disable Bluetooth"),
            trailing: Switch(
              value: bluetooth,
              onChanged: (value) {
                setState(() {
                  bluetooth = value;
                });
              },
            ),
          ),

          /// DARK MODE
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            subtitle: const Text("Enable Dark Theme"),
            trailing: Switch(
              value: widget.isDarkMode,
              onChanged: widget.onDarkModeChanged,
            ),
          ),
        ],
      ),
    );
  }
}

