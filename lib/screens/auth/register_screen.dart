import 'package:flutter/material.dart';
import 'package:woo_store/fetch_screen.dart';
import 'package:woo_store/firebase/register_user_firebase.dart';
import 'package:woo_store/woocommerce/models/customer_model.dart';
import 'package:woo_store/screens/bottom_bar_screen.dart';
import 'package:woo_store/services/global_methods.dart';

import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/auth_button_widget.dart';
import 'package:woo_store/widgets/loading_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _addressTextController = TextEditingController();

  final _passFocusNode = FocusNode();
  final _fullNameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  var _obscureText = true;

  bool _isLoading = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _fullNameController.dispose();
    _addressTextController.dispose();
    _passFocusNode.dispose();
    _fullNameFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils(context).getSizeScreen();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
      ),
      body: LoadingWidget(
        isLoading: _isLoading,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              color: Colors.pinkAccent,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenSize.height * 9 / 16,
                    width: screenSize.width * 6 / 8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          TextWidget(
                            text: '¡Registrate!',
                            color: Colors.black,
                            textSize: 30,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            text: 'Ingresa tus datos para crear una cuenta',
                            color: Colors.black,
                            textSize: 18,
                          ),
                          const SizedBox(
                            height: 38,
                          ),
                          registerForm(),
                          const SizedBox(
                            height: 18,
                          ),
                          AuthButtonWidget(
                            buttonText: 'Registrarse',
                            fct: _submitFormOnRegister,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await apiWoocommerce.createCustomer(
          CustomerModel(
            email: _emailTextController.text.toLowerCase(),
            password: _passTextController.text.trim(),
            firstName: _fullNameController.text,
            lastName: '',
          ),
        );

        // await RegisterUserFirebase(
        //   fullName: _fullNameController.text,
        //   email: _emailTextController.text.toLowerCase(),
        //   password: _passTextController.text.trim(),
        //   address: _addressTextController.text,
        // )
        // .registerToDatabase();

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (contex) => const FetchScreen(),
          ),
        );
      } catch (error) {
        GlobalMethods.errorDialog(
          subtitle: '$error',
          context: context,
        );
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget registerForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //Email
          TextFormField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(_passFocusNode),
            controller: _emailTextController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Porfavor ingresa un email válido';
              } else {
                return null;
              }
            },
            style: const TextStyle(color: Colors.grey),
            decoration: const InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(
                Icons.mail_outline_rounded,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
            ),
          ),
          //Password
          const SizedBox(
            height: 20,
          ),
          //Password
          TextFormField(
            focusNode: _passFocusNode,
            obscureText: _obscureText,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(_fullNameFocusNode),
            controller: _passTextController,
            validator: (value) {
              if (value!.isEmpty || value.length < 7) {
                return 'Porfavor ingresa una contraseña con mas de 7 digitos';
              } else {
                return null;
              }
            },
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  )),
              hintText: 'Password',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: Colors.grey,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Full Name
          TextFormField(
            focusNode: _fullNameFocusNode,
            textInputAction: TextInputAction.next,
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(_addressFocusNode),
            controller: _fullNameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Porfavor ingresa un nombre válido';
              } else {
                return null;
              }
            },
            style: const TextStyle(color: Colors.grey),
            decoration: const InputDecoration(
              hintText: 'Nombre completo',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Address
          TextFormField(
            focusNode: _addressFocusNode,
            textInputAction: TextInputAction.done,
            controller: _addressTextController,
            validator: (value) {
              if (value!.isEmpty || value.length < 10) {
                return 'Porfavor ingresa una direccion válida';
              } else {
                return null;
              }
            },
            style: const TextStyle(color: Colors.grey),
            maxLines: 1,
            textAlign: TextAlign.start,
            decoration: const InputDecoration(
              hintText: 'Dirección de envio',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(
                Icons.home_outlined,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.lightBlue,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
