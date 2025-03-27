import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Initialize the channel
const _channel = MethodChannel('com.example.flutterIosExtension/my_channel');

@pragma('vm:entry-point')
void mainHeadless() {
  print('XXXX Headless mode starting...');
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize method channel
  _channel.setMethodCallHandler((call) async {
    switch (call.method) {
      case 'getData':
        return "Hello from Headless Flutter!";
      default:
        throw PlatformException(code: 'UNSUPPORTED_METHOD');
    }
  });

  runApp(const SizedBox.shrink());
}
