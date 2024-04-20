import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebView Event Example'),
        ),
        body: WebViewEventExample(),
      ),
    );
  }
}

class WebViewEventExample extends StatefulWidget {
  @override
  _WebViewEventExampleState createState() => _WebViewEventExampleState();
}

class _WebViewEventExampleState extends State<WebViewEventExample> {
  late WebViewController _webViewController;
   String message = 'default';

  @override
  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse('https://select-ticket.echipta.uz/'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'eventSector',
        onMessageReceived: (JavaScriptMessage jsMessage) {
          print("message from the web view=\"${jsMessage.message}\"");
          setState(() {
            message = jsMessage.message;
          });
        },
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: WebViewWidget(
            controller: _webViewController,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Example: Send event from Flutter to JavaScript
            _webViewController.runJavaScript('receive message');
          },
          child: Text('Send Event from Flutter'),
        ),

      ],
    );
  }
}
