import 'package:flutter/material.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:practiacflutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};
  RegisterProvider registerProvider = RegisterProvider();

  @override
  Widget build(BuildContext context) {
    registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Colors.indigo,
      child: Column(
        children: [
          const SizedBox(height: 45),
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
                      const AppTitle('Registrar usuario'),
                      const SizedBox(height: 25),
                      AppFormField('email', 'Correo electronico',
                          formData: formData,
                          icon: Icons.email_outlined, validator: (value) {
                        if (value!.length < 6) {
                          return "correo electronico no valido";
                        }
                        return null;
                      }),
                      AppFormField('password', 'Clave',
                          obscureText: true,
                          formData: formData,
                          icon: Icons.lock_outline_rounded, validator: (value) {
                        if (value!.length < 3) {
                          return "clave incorrecta";
                        }
                        return null;
                      }),
                      ElevatedButton(
                          onPressed: formRegister,
                          child: const Text('Registrar')),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    ));
  }

  formRegister() async {
    if (formKey.currentState!.validate()) {
      bool respuesta = await registerProvider.registrarUsuario(formData);
      if (respuesta) {
        AppDialogs.showDialog1(context, 'Usuario registrado');
      } else {
        AppDialogs.showDialog1(context, 'No se pudo registrar');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se pudo validar');
    }
  }
}
