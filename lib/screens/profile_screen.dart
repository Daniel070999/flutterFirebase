import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practiacflutter/providers/providers.dart';
import 'package:practiacflutter/widgets/app_bar.dart';
import 'package:practiacflutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider userProvider = UserProvider();
  Map<String, String> formData = {
    'localID': '',
    'email': '',
    'password': '',
    'name': '',
    'lastname': '',
    'image': ''
  };

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  XFile? image;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    nameController.text = userProvider.user.name!;
    lastnameController.text = userProvider.user.lastname!;

    if (formData['name'] == "") {
      formData['name'] = nameController.text;
      formData['lastname'] = lastnameController.text;
      formData['localID'] = userProvider.user.localId!;
      formData['image'] = userProvider.user.image!;
    }
    return Scaffold(
      appBar: getAppBar(context, 'perfil', userProvider.user),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              GestureDetector(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      final byte = File(image!.path).readAsBytesSync();
                      formData['image'] = base64Encode(byte);
                    }
                    setState(() {});
                  },
                  child: userProvider.user.image == ""
                      ? const Image(
                          image: AssetImage('assets/profile.png'), height: 250)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(250),
                          child: Image.memory(
                            base64Decode(formData['image']!),
                            fit: BoxFit.cover,
                            height: 350,
                            width: 250,
                          ))),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              AppFormField('name', 'Ingrese su nombre',
                  controller: nameController,
                  formData: formData,
                  icon: Icons.textsms_outlined, validator: (value) {
                if (value!.length < 4) {
                  return "Nombre no valido";
                }
                return null;
              }),
              AppFormField('lastname', 'Ingrese su apellido',
                  controller: lastnameController,
                  formData: formData,
                  icon: Icons.textsms_outlined, validator: (value) {
                if (value!.length < 4) {
                  return "Apellido no valido";
                }
                return null;
              }),
              SizedBox(height: 20),
              (loading == false)
                  ? ElevatedButton(
                      onPressed: formUpdate,
                      child: const Text('Actualizar'),
                    )
                  : Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }

  formUpdate() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      bool respuesta = await userProvider.updateUsuario(formData);
      loading = false;
      setState(() {});
      if (respuesta) {
        AppDialogs.showDialog1(context, 'Datos actualizados');
      } else {
        AppDialogs.showDialog1(context, 'No se pudo actualizar');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se pudo validar');
    }
  }
}
