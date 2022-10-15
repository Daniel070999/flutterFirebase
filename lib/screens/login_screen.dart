import 'package:flutter/material.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:practiacflutter/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};
  LoginProvider loginProvider = LoginProvider();
  UserProvider userProvider = UserProvider();
  bool chechSaveData = false;
  SharedPreferences? pref;
  //controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    if (pref != null) {
      emailController.text = pref!.getString("email").toString();
      passwordController.text = pref!.getString("password").toString();
      formData['email'] = emailController.text;
      formData['password'] = passwordController.text;
      setState(() {});
    }

    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Colors.indigo,
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Icon(Icons.supervised_user_circle,
              size: 200, color: Colors.white),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const AppTitle('Iniciar Sesion'),
                      const SizedBox(height: 25),
                      AppFormField(
                        'email',
                        'Correo electronico',
                        controller: emailController,
                        formData: formData,
                        icon: Icons.email_outlined,
                        validator: (value) {
                          if (value!.length < 6) {
                            return "correo electronico no valido";
                          }
                          return null;
                        },
                      ),
                      AppFormField('password', 'Clave',
                          controller: passwordController,
                          obscureText: true,
                          formData: formData,
                          icon: Icons.lock_outline_rounded, validator: (value) {
                        if (value!.length < 3) {
                          return "clave incorrecta";
                        }
                        return null;
                      }),
                      CheckboxListTile(
                          value: chechSaveData,
                          title: const Text(
                            "¿Desea mantener activa la sesion?",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontStyle: FontStyle.italic),
                          ),
                          onChanged: (value) {
                            setState(() {
                              chechSaveData = value!;
                            });
                          }),
                      ElevatedButton(
                          onPressed: formLogin, child: const Text('Ingresar')),
                    ],
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'register');
              },
              child: const Text('Registrar nueva cuenta',
                  style: TextStyle(color: Colors.white))),
        ],
      ),
    ));
  }

  formLogin() async {
    if (formKey.currentState!.validate()) {
      var usuario = await loginProvider.loginUsuario(formData);
      if (usuario != null) {
        userProvider.setUser(usuario);
        //guardar preferencia (sesion iniciada)
        if (chechSaveData && pref != null) {
          pref!.setString("email", usuario.email!);
          pref!.setString("password", formData['password']!);
        }
        AppDialogs.showDialog2(context, 'Usuario autenticado', [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'home');
              },
              child: const Text("OK"))
        ]);
      } else {
        AppDialogs.showDialog1(context, 'No se pudo iniciar sesion');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se pudo validar');
    }
  }
}
