import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:quick_req/core/themes/standard_color.dart';
import 'package:quick_req/widget/navbar/navbar.dart';

import '../../../core/localizations/app_localizations.dart';


class QuickReqHome extends ConsumerStatefulWidget{
  const QuickReqHome({super.key});


  @override
  QuickReqHomeState  createState()=>QuickReqHomeState();
}

class QuickReqHomeState extends ConsumerState<QuickReqHome>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:NavBar(),
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:Theme.of(context).primaryColor,
        title:Image.asset("assets/images/name.png"),
        actions: [
          Padding(
            padding:EdgeInsets.only(right: 16.dp),
            child: CircleAvatar(
              radius: 25.dp,
              backgroundImage: AssetImage("assets/images/userProfil.JPG"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin:EdgeInsets.only(top: 40.dp,left:10.dp,right:10.dp),
            padding: EdgeInsets.symmetric(horizontal:110.dp,vertical: 10.dp),
            color:Theme.of(context).colorScheme.onSurface,
            child: Text(AppLocalizations.of(context)!.translate('request_deadlines')!,style:TextStyle(color:Theme.of(context).scaffoldBackgroundColor,fontWeight:FontWeight.w500,fontSize: 18.dp),),
          ),
          Container(
            margin:EdgeInsets.only(bottom:10.dp,left:10.dp,right:10.dp),
            decoration:BoxDecoration(
              border:Border.all(width:2.dp,color:Theme.of(context).colorScheme.onSurface)
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns:  [
                    DataColumn(label: Text("NUMERO",style:TextStyle(fontWeight:FontWeight.w500,fontSize: 15.dp,color:Theme.of(context).colorScheme.onSurface,))),
                    DataColumn(label: Text("UE",style:TextStyle(fontWeight:FontWeight.w500,fontSize: 15.dp,color: Theme.of(context).colorScheme.onSurface,))),
                    DataColumn(label: Text("ENSEIGNANT",style:TextStyle(fontWeight:FontWeight.w500,fontSize: 15.dp,color: Theme.of(context).colorScheme.onSurface,))),
                    DataColumn(label: Text("DELAI",style:TextStyle(fontWeight:FontWeight.w500,fontSize: 15.dp,color: Theme.of(context).colorScheme.onSurface,))),
                    DataColumn(label: Text("ETAT",style:TextStyle(fontWeight:FontWeight.w500,fontSize: 15.dp,color:Theme.of(context).colorScheme.onSurface,))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text("1")),
                      DataCell(Text("ICT300")),
                      DataCell(Text("Dr Messi")),
                      DataCell(Text("NON DEFINI")),
                      DataCell(
                          Container(
                            padding:EdgeInsets.all(5.dp),
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10.dp),
                              color:StandardColor.yellowColor,
                            ),
                            child: Text("NON DEFINI",style:TextStyle(fontWeight:FontWeight.w500,fontSize: 15.dp,color:StandardColor.whiteColor)),
                          )
                      ),
                    ]),
                  ],
                  headingRowHeight: 60,
                  border: TableBorder(
                  horizontalInside: BorderSide(color:Theme.of(context).colorScheme.onSurface, width:2.dp,),
                  verticalInside: BorderSide(color: Theme.of(context).colorScheme.onSurface, width:2.dp,),
                  ),
              ),
            ),
          ),),
        ],
      ),
    );
  }
}