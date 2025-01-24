import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:quick_req/widget/navigation/navigation.dart';

import '../../core/localizations/app_localizations.dart';
import '../../features/home/screen/quick_req_main.dart';
import '../../features/request_creation/screens/request_creation.dart';
import '../../test.dart';

class NavBar  extends ConsumerStatefulWidget{
  const NavBar({super.key});
  @override
  NavBarState createState() =>NavBarState();
}

class NavBarState extends ConsumerState<NavBar> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName:Text('Tsafack',style:TextStyle(fontWeight:FontWeight.w500,fontSize: 18.dp),),
            accountEmail:Text('tsafackjuniordauphin@icloud.com',style:TextStyle(fontWeight:FontWeight.w500,fontSize: 15.dp),),
            currentAccountPicture: CircleAvatar(
              radius: 40.dp,
              backgroundImage: AssetImage("assets/images/userProfil.JPG"),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fontProfil.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading:Icon(Icons.access_time_filled,color:Theme.of(context).colorScheme.onSurface),
            title:Text(AppLocalizations.of(context)!.translate('request_deadlines')!,style:TextStyle(color:Theme.of(context).colorScheme.onSurface,fontWeight:FontWeight.w500,fontSize: 18.dp),),
            onTap: (){
              setState(() {
                navigateToNextPage(context, QuickReqHome());
              });
            },
          ),
          ListTile(
            leading:Icon(Icons.track_changes_outlined,color:Theme.of(context).colorScheme.onSurface),
            title:Text(AppLocalizations.of(context)!.translate('request_tracking')!,style:TextStyle(color:Theme.of(context).colorScheme.onSurface,fontWeight:FontWeight.w500,fontSize: 18.dp),),
            onTap: (){
                setState(() {
                navigateToNextPage(context, StudentRequests());
                });
                },
          ),
          ListTile(
            leading:Icon(Icons.create_outlined,color:Theme.of(context).colorScheme.onSurface),
            title:Text(AppLocalizations.of(context)!.translate('request_creation')!,style:TextStyle(color:Theme.of(context).colorScheme.onSurface,fontWeight:FontWeight.w500,fontSize: 18.dp),),
            onTap: (){
              setState(() {
                navigateToNextPage(context, RequestCreation());
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top:100),
            child: Image.asset("assets/images/name.png"),
          ),
        ],
      ),
    );
  }
}