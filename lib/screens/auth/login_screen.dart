import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:woo_store/fetch_screen.dart';
import 'package:woo_store/screens/bottom_bar_screen.dart';
import 'package:woo_store/services/shared_services.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/auth_button_widget.dart';
import 'package:woo_store/widgets/loading_widget.dart';
import 'package:woo_store/widgets/social_login_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

import '../../services/global_methods.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  var _obscureText = true;

  bool _isLoading = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils(context).getScreenSize;
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
                            text: '¡Bienvendio!',
                            color: Colors.black,
                            textSize: 30,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            text: 'Inicia sesion con tu cuenta',
                            color: Colors.black,
                            textSize: 18,
                          ),
                          const SizedBox(
                            height: 38,
                          ),
                          const SocialLoginWidget(),
                          const SizedBox(
                            height: 18,
                          ),
                          loginDivider(),
                          const SizedBox(
                            height: 18,
                          ),
                          loginForm(),
                          const SizedBox(
                            height: 18,
                          ),
                          AuthButtonWidget(
                            buttonText: 'Iniciar sesión',
                            fct: _submitFormOnLogin,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          forgetPassword(),
                          const SizedBox(
                            height: 10,
                          ),
                          registerButton(context),
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

  Future<void> _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await apiWoocommerce.loginCustomer(
          username: _emailTextController.text.toLowerCase().trim(),
          password: _passTextController.text.trim(),
        );

        if (response.success) {
          SharedService.setLoginDetails(response);
          //SharedService.setCutomerDetails()
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBarScreen.routeName,
            (route) => false,
          );
        }

        // await authInstance.signInWithEmailAndPassword(
        //   email: _emailTextController.text.toLowerCase().trim(),
        //   password: _passTextController.text.trim(),
        // );

        // ignore: use_build_context_synchronously

        // } on FirebaseException catch (error) {
        //   GlobalMethods.errorDialog(
        //       subtitle: '${error.message}', context: context);
        //   setState(() {
        //     _isLoading = false;
        //   });
      } catch (error) {
        GlobalMethods.errorDialog(
          subtitle: '$error',
          context: context,
        );
        setState(
          () {
            _isLoading = false;
          },
        );
      } finally {
        setState(
          () {
            _isLoading = false;
          },
        );
      }
    }
  }

  Widget loginDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        TextWidget(
          text: 'o',
          color: Colors.grey,
          textSize: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
              )),
          //Password
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              //_submitFormOnLogin();
            },
            controller: _passTextController,
            focusNode: _passFocusNode,
            obscureText: _obscureText,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty || value.length < 7) {
                return 'Porfavor ingresa una contraseña válida';
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
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
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
          )
        ],
      ),
    );
  }

  Widget forgetPassword() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          // GlobalMethods.navigateTo(
          //     ctx: context,
          //     routeName: ForgetPasswordScreen.routeName);
        },
        child: const Text(
          '¿Olvidaste tu contraseña?',
          maxLines: 1,
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: '¿No tienes una cuenta? ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            children: [
          TextSpan(
              text: ' Registrate',
              style: const TextStyle(
                color: Colors.lightBlue,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                }),
        ]));
  }
}
