import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = Modular.get<LoginController>();

  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 100;
    final double height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, state, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0XFF6400B2),
                  const Color(0XFF8D34D2).withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'WaitApp',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: height * 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'e-pagers',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: height * 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 7.5),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width * 34,
                        child: TextFormField(
                          key: const Key('email'),
                          controller: _emailController,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: height * 3,
                            fontWeight: FontWeight.w500,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return 'Campo obrigatório';
                            if (value.length < 3)
                              return 'Mínimo de 6 caracteres';
                            return null;
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            fillColor: Colors.black.withOpacity(0.2),
                            filled: true,
                            errorStyle: GoogleFonts.inter(
                              color: const Color(0XFFFF6F65),
                              fontWeight: FontWeight.bold,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 24.0,
                              top: 20.0,
                              bottom: 20.0,
                            ),
                          ),
                          autocorrect: false,
                          enableSuggestions: false,
                        ),
                      ),
                      SizedBox(height: height * 1.5),
                      SizedBox(
                        width: width * 34,
                        child: TextFormField(
                          key: const Key('password'),
                          controller: _passwordController,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: height * 3,
                            fontWeight: FontWeight.w500,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return 'Campo obrigatório';
                            if (value.length < 3)
                              return 'Mínimo de 6 caracteres';
                            return null;
                          },
                          obscureText: !state.visibility,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            errorStyle: GoogleFonts.inter(
                              color: const Color(0XFFFF6F65),
                              fontWeight: FontWeight.bold,
                            ),
                            fillColor: Colors.black.withOpacity(0.2),
                            filled: true,
                            contentPadding: const EdgeInsets.only(
                              left: 24.0,
                              top: 20.0,
                              bottom: 20.0,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: InkWell(
                                onTap: () => controller.changeVisibility(),
                                child: Icon(
                                  state.visibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                  size: height * 4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 1.5),
                      SizedBox(
                        height: height * 7,
                        width: width * 34,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            backgroundColor: const Color(0XFF5DBCFD),
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: login,
                          child:
                              state.loading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    'Entrar',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: height * 3,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;
    await controller.login(_emailController.text, _passwordController.text);

    if (controller.value.error.isNotEmpty) {
      showError();
      return;
    }

    if (controller.value.success) {
      goToPanel();
    }
  }

  Future<void> goToPanel() async {
    await Modular.to.pushNamed<bool>('/order_control');
  }

  void showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          controller.value.error,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0XFFff6f65),
      ),
    );
  }
}
