import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_req/core/themes/standard_color.dart';
import 'package:quick_req/utils/sizers_helpers.dart';
import 'package:quick_req/widget/buttons/large_btn.dart';
import 'package:quick_req/widget/navigation/navigation.dart';
import '../../../api/api_service.dart';
import '../../../core/localizations/app_localizations.dart';
import '../../home/screen/quick_req_main.dart';
import '../UserModel.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  bool _emailTouched = false;
  bool _passwordTouched = false;

  User? _user;

  Future<void> _login() async {
    final token = await apiService.getToken();
    if (token != null) {
      print('Utilisateur déjà connecté, token trouvé : $token');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vous êtes déjà connecté.')),
      );

      // Optionnel : Redirigez vers la page d'accueil ou affichez le token
      navigateToNextPage(context, QuickReqHome());
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;

    print("Tentative de connexion avec l'email : $email");

    final response = await apiService.loginUser(
      email: email,
      password: password,
    );

    print("Réponse de la connexion : $response");

    if (response == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : réponse de l\'API nulle')),
      );
      return;
    }

    if (!response.containsKey('success')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : réponse de l\'API invalide')),
      );
      return;
    }

    if (response['success']) {
      setState(() {
        _user = User.fromJson(response['user']);
      });

      // Récupérer le token maintenant que l'utilisateur est connecté
      final tokenAfterLogin = await apiService.getToken();
      print('Token récupéré après connexion : $tokenAfterLogin');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bienvenue ${_user!.name}!')),
      );

      // Redirigez vers la page d'accueil
      navigateToNextPage(context, QuickReqHome());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connexion : ${response['message']}')),
      );
    }
  }


  void _validateEmail() {
    setState(() {
      _emailErrorMessage = _emailTouched
          ? validateEmail(_emailController.text)
          : null;
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordErrorMessage = _passwordTouched
          ? validatePassword(_passwordController.text)
          : null;
    });
  }

  bool _isFormValid() {
    _validateEmail();
    _validatePassword();
    return _emailErrorMessage == null &&
        _passwordErrorMessage == null &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/svgs/lock.svg',
                height: getHeight(25, context),
                width: getWidth(25, context),
              ),
              Text(
                AppLocalizations.of(context)!.translate('login')!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 32.dp,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                AppLocalizations.of(context)!.translate('please_login')!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.dp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.dp, horizontal: 40.dp),
                padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 10.dp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.dp),
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 10.dp,
                      bottom: 10.dp,
                      child: Icon(Icons.mail_outline_outlined, size: 24.dp, color: StandardColor.blackColor,),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('email')!,
                          style: TextStyle(
                            fontSize: 16.dp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: getHeight(5, context)),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'account@gmail.com',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _emailTouched = true;
                            });
                            _validateEmail();
                          },
                          onTap: () {
                            setState(() {
                              _emailTouched = true;
                            });
                          },
                        ),
                        if (_emailTouched && _emailErrorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              _emailErrorMessage!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.dp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.dp, horizontal: 40.dp),
                padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 10.dp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.dp),
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                        right: 10.dp,
                        bottom: 10.dp,
                        child: Icon(Icons.lock_outline, size: 24.dp, color: StandardColor.blackColor,)
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('password')!,
                          style: TextStyle(
                            fontSize: 16.dp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: getHeight(5, context)),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '**********',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _passwordTouched = true;
                            });
                            _validatePassword();
                          },
                          onTap: () {
                            setState(() {
                              _passwordTouched = true;
                            });
                          },
                        ),
                        if (_passwordTouched && _passwordErrorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              _passwordErrorMessage!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.dp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: getWidth(10, context)),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 0.6,
                      ),
                    ),
                    SizedBox(width: getWidth(5, context)),
                    Text(
                      AppLocalizations.of(context)!.translate('or_continue_with')!,
                      style: TextStyle(
                        fontSize: 14.dp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(width: getWidth(5, context)),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        thickness: 0.6,
                      ),
                    ),
                    SizedBox(width: getWidth(10, context)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: getWidth(80, context),
                          height: getHeight(70, context),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 0.2),
                            borderRadius: BorderRadius.circular(16.dp),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/svgs/google.svg',
                              width: getWidth(24, context),
                              height: getHeight(24, context),
                            ),
                            onPressed: (){},
                          ),
                        ),
                        SizedBox(width: getWidth(20, context)),
                        Container(
                          width: getWidth(80, context),
                          height: getHeight(70, context),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 0.2),
                            borderRadius: BorderRadius.circular(16.dp),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/svgs/apple.svg',
                              width: getWidth(24, context),
                              height: getHeight(24, context),
                            ),
                            onPressed: (){},
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _isFormValid(),
                child: LargeBtn(
                    onPressed: () async {
                      print("Button pressed");

                      if (_isFormValid()) {
                        print("Form is valid, proceeding to login");
                        navigateToNextPage(context, QuickReqHome());
                        await _login();
                      }
                    },
                    titleText: AppLocalizations.of(context)!.translate('login_now')!
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}