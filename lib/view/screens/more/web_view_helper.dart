import 'package:codecoy/utilis/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utilis/app_colors.dart';
import '../../widgets/custom_appbar.dart';

class WebViewHelper extends StatefulWidget{
  final String url,title;
  const WebViewHelper(this.url,this.title, {super.key});
  @override
  State<WebViewHelper> createState() => _WebViewHelperState();
}

class _WebViewHelperState extends State<WebViewHelper> {
  WebViewController ? controller;

  @override
  void initState() {
    super.initState();
    webViewControllerInitialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: const Size.fromHeight(59.0),
          child: myAppBar(title:widget.title,context:context)),
      body: WebViewWidget(controller: controller!,
      ),
    );
  }

  webViewControllerInitialization(){
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.white)
      ..loadRequest(Uri.parse(widget.url));
  }
}