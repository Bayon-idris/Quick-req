import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:quick_req/core/themes/standard_color.dart';
import 'package:quick_req/widget/navigation/navigation.dart';
import '../../../api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/localizations/app_localizations.dart';
import 'features/home/screen/quick_req_main.dart';

class StudentRequests extends ConsumerStatefulWidget {
  const StudentRequests({super.key});

  @override
  StudentRequestsState createState() => StudentRequestsState();
}

class StudentRequestsState extends ConsumerState<StudentRequests> {
  final ApiService apiService = ApiService();
  List<dynamic> _requests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStudentRequests();
  }

  Future<void> _fetchStudentRequests() async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final studentId = prefs.getString('user_id');

    print('ID d\'étudiant récupéré : $studentId');

    final response = await apiService.getStudentRequests(studentId);

    if (response['success']) {
      print('Requêtes récupérées avec succès.');
      setState(() {
        _requests = response['requests'];
        _isLoading = false;
      });
    } else {
      print('Erreur lors de la récupération des requêtes : ${response['message']}');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ${response['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () { navigateToNextPage(context, QuickReqHome());},
          icon: Icon(Icons.arrow_back,color: StandardColor.blackColor),),
        title: Image.asset("assets/images/name.png"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
          : _requests.isEmpty
          ? Center(child: Text('Aucune requête trouvée.'))
          : Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.dp),
            padding: EdgeInsets.symmetric(horizontal: 110.dp, vertical: 10.dp),
            color: Theme.of(context).colorScheme.onSurface,
            child: Text(
              AppLocalizations.of(context)!.translate('request_tracking')!,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.w500,
                fontSize: 18.dp,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Bordure noire autour du tableau
              ),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Unité')),
                  DataColumn(label: Text('Motif')),
                  DataColumn(label: Text('État')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Action')),
                ],
                rows: _requests.map<DataRow>((request) {
                  String formattedDate = "";
                  if (request['created_at'] != null) {
                    DateTime dateTime = DateTime.parse(request['created_at']);
                    formattedDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                  }

                  return DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                        }
                        return null; // Use default color for other states
                      },
                    ),
                    cells: [
                      DataCell(Text(request['request_code'] ?? 'N/A')),
                      DataCell(Text(request['title'] ?? 'N/A')),
                      DataCell(Text(request['statut'] ?? 'N/A')),
                      DataCell(Text(formattedDate)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}