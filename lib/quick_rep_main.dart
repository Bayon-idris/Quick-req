import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuickReq extends ConsumerStatefulWidget{

  QuickReqState  createState()=>QuickReqState();
}

class QuickReqState extends ConsumerState<QuickReq>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: Text('Bonjour'),
      ),
    );
  }
}