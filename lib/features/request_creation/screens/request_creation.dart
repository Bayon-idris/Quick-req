import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:quick_req/widget/buttons/large_btn.dart';
import '../../../api/api_service.dart';
import '../../../core/localizations/app_localizations.dart';
import '../../../widget/container/dropdown_request.dart';
import '../../../widget/navbar/navbar.dart';
import 'package:file_picker/file_picker.dart';

class RequestCreation extends ConsumerStatefulWidget {
  const RequestCreation({super.key});

  @override
  RequestCreationState createState() => RequestCreationState();
}

class RequestCreationState extends ConsumerState<RequestCreation> {
  PlatformFile? _attachmentFile;
  PlatformFile? _handwrittenFile;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _controller = TextEditingController(
    text: "Monsieur (ou Madame),\n\nJ'ai l'honneur de venir très respectueusement auprès de votre haute bienveillance solliciter votre soutien dans le cadre de ma démarche académique.\n\nEn effet, je suis étudiant(e) en [nom de votre filière ou programme d'études] et je me permets de solliciter votre bienveillance pour [expliquer brièvement la nature de votre demande, que ce soit une demande d'information, d'assistance, ou autre].\n\nDans l'attente d'une suite favorable, veuillez agréer, Monsieur (ou Madame), mes expressions les plus chaleureuses !",
  );
  final ApiService apiService = ApiService();
  String? _selectedObject; // Champ pour stocker l'objet choisi

  Future<void> _pickFile(bool isHandwritten) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          if (isHandwritten) {
            _handwrittenFile = result.files.first;
          } else {
            _attachmentFile = result.files.first;
          }
        });
      }
    } catch (e) {
      print('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sélection du fichier')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset("assets/images/name.png"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.dp),
            child: CircleAvatar(
              radius: 25.dp,
              backgroundImage: AssetImage("assets/images/userProfil.JPG"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Titre de la demande
              Container(
                margin: EdgeInsets.only(top: 40.dp),
                padding: EdgeInsets.symmetric(horizontal: 110, vertical: 10.dp),
                color: Theme.of(context).colorScheme.onSurface,
                child: Text(
                  AppLocalizations.of(context)!.translate('request_creation')!,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.dp,
                  ),
                ),
              ),
              // Dropdown pour les options
              DropdownContainer(
                options: ['ICT300', 'ICT301', 'ICT303'],
                onChanged: (value) {
                  setState(() {
                    _selectedObject = value; // Mettez à jour l'objet choisi
                  });
                },
              ),
              DropdownContainer(
                options: [
                  AppLocalizations.of(context)!.translate('absence_of_grades')!,
                  AppLocalizations.of(context)!.translate('grade_error')!,
                  AppLocalizations.of(context)!.translate('exemption_request_for_evaluation')!
                ],
                title: AppLocalizations.of(context)!.translate('object')!,
                subtitle: AppLocalizations.of(context)!.translate('click_to_select_your_object')!,
              ),
              // Champ pour le titre
              Container(
                width: MediaQuery.of(context).size.width * 3 / 2,
                margin: EdgeInsets.only(top: 20.dp, left: 20.dp, right: 20.dp, bottom: 10.dp),
                padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 10.dp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.dp),
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5.dp,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Votre Titre',
                                style: TextStyle(color: Colors.black, fontSize: 20.dp),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red, fontSize: 20.dp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.dp),
                        TextField(
                          controller: _titleController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Entrez votre intitule ici',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Champ pour le contenu
              Container(
                width: MediaQuery.of(context).size.width * 3 / 2,
                margin: EdgeInsets.only(top: 20.dp, left: 20.dp, right: 20.dp, bottom: 20.dp),
                padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 10.dp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.dp),
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5.dp,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!.translate('content')!,
                                style: TextStyle(color: Colors.black, fontSize: 20.dp),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red, fontSize: 20.dp),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.dp),
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Champ pour la pièce jointe
              _buildFilePicker('Pièce jointe', _attachmentFile, false),
              // Champ pour la pièce manuscrite
              _buildFilePicker('Pièce manuscrite', _handwrittenFile, true),
              // Bouton pour soumettre la requête
              LargeBtn(
                onPressed: () async {
                  final title = _titleController.text; // Utilisé pour le champ title
                  final content = _controller.text;

                  if (title.isEmpty || content.isEmpty || _attachmentFile == null || _handwrittenFile == null || _selectedObject == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Veuillez remplir tous les champs')),
                    );
                    return;
                  }

                  final response = await apiService.submitRequest(
                    title: content, // Utilisez le contenu comme titre
                    content: title, // Utilisez le titre comme contenu
                    filePath: _attachmentFile?.path, // Chemin du fichier joint
                    handwrittenFilePath: _handwrittenFile?.path, // Chemin du fichier manuscrit
                    requestPatternId: '1', // Remplacez par l'ID numérique correspondant à l'objet sélectionné
                  );

                  if (response['success']) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Requête soumise avec succès !')),
                    );
                    // Rediriger ou effectuer d'autres actions
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur : ${response['message']}')),
                    );
                  }
                },
                titleText: AppLocalizations.of(context)!.translate('submit')!,
              ),
              SizedBox(height: 10.dp,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePicker(String label, PlatformFile? pickedFile, bool isHandwritten) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => _pickFile(isHandwritten),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.grey[300],
                    child: Text(AppLocalizations.of(context)!.translate('choose_file')!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    pickedFile != null
                        ? pickedFile.name
                        : AppLocalizations.of(context)!.translate('no_file_chosen')!,
                    style: TextStyle(
                      color: pickedFile != null ? Colors.black : Colors.grey,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}