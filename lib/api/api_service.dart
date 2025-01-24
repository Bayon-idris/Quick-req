import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';  // Import nécessaire
import '../features/authentification/UserModel.dart';

class ApiService {
  static const String baseUrl = "http://172.20.10.6:8000/api";

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData.containsKey('data')) {
          final token = responseData['data']['token'];
          print('Token de connexion : $token');
          await _saveToken(token);
          final user = User.fromJson(responseData['data']['user']);
          return {
            'success': true,
            'user': user,
          };
        } else {
          return {
            'success': false,
            'message': responseData['message'] ?? 'Erreur inconnue',
          };
        }
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Erreur inconnue',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur inconnue : $e',
      };
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Map<String, dynamic>> submitRequest({
    required String title, // Ce sera le titre de la demande
    required String content,
    required String? filePath, // Fichier joint
    required String? handwrittenFilePath, // Pièce manuscrite
    required String requestPatternId, // ID numérique de l'UE
  }) async {
    final url = Uri.parse('$baseUrl/request/');
    final token = await getToken(); // Récupérer le token
    print('Token récupéré : $token');

    if (token == null) {
      print('Token non trouvé.');
      return {
        'success': false,
        'message': 'Token non trouvé. Veuillez vous connecter.',
      };
    }

    try {
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['title'] = content // Utilisez le contenu comme titre
        ..fields['requestPatternId'] = requestPatternId // ID numérique de l'UE
        ..fields['content'] = title; // Utilisez le titre comme contenu

      if (filePath != null) {
        request.files.add(await http.MultipartFile.fromPath('attachment', filePath));
      }

      if (handwrittenFilePath != null) {
        request.files.add(await http.MultipartFile.fromPath('fileHandWritten', handwrittenFilePath));
      }

      print('Envoi de la requête à l\'URL : $url');
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Afficher le corps de la réponse
      print('Corps de la réponse : ${response.body}');

      if (response.statusCode != 200) {
        print('Erreur : ${response.statusCode}');
        return {
          'success': false,
          'message': 'Erreur du serveur : ${response.statusCode}',
        };
      }

      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 201) {
        print('Requête soumise avec succès.');
        return {
          'success': true,
          'requestId': responseData['requestId'],
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Erreur inconnue',
        };
      }
    } catch (e) {
      print('Erreur lors de la soumission : $e');
      return {
        'success': false,
        'message': 'Erreur inconnue : $e',
      };
    }
  }


  Future<Map<String, dynamic>> getStudentRequests(String? studentId) async {
    // Utilisez un ID fixe si l'ID d'étudiant est null
    if (studentId == null) {
      studentId = '1'; // ID fixe
      print('Aucun ID d\'étudiant trouvé, utilisation de l\'ID fixe : $studentId');
    }

    final url = Uri.parse('$baseUrl/student/$studentId/requests');
    final token = await getToken(); // Récupérer le token

    if (token == null) {
      return {
        'success': false,
        'message': 'Token non trouvé. Veuillez vous connecter.',
      };
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'requests': responseData['requests'],
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': 'Erreur du serveur : ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erreur inconnue : $e',
      };
    }
  }
}