import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaz_test/presentation/cubit/auth/auth_cubit.dart';
import 'package:gaz_test/presentation/pages/forecast_page.dart';
import 'package:gaz_test/presentation/widgets/loading_widget.dart';
import 'package:gaz_test/units/pj_icons.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (BuildContext context, state) {
        if (state is! AuthLoading) {
          Navigator.pop(context);
        }

        if (state is AuthLoaded) {
          if (state.isAuth) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ForecastPage()));
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message ?? '')));
        }

        if (state is AuthLoading) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return const LoadingWidget();
              });
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 48.h),
                  const Text(
                    'Вход',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(43, 45, 51, 1),
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const Text(
                    'Введите данные для входа',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color.fromRGBO(135, 153, 165, 1)),
                  ),
                  SizedBox(height: 16.h),
                  _AuthForm(
                    emailTextController: emailTextController,
                    passwordTextController: passwordTextController,
                    formKey: formKey,
                  ),
                  SizedBox(height: 48.h),
                  FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        context.read<AuthCubit>().logIn(email: emailTextController.text, password: passwordTextController.text);
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(7, 0, 255, 1),
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                      minimumSize: Size.fromHeight(48.h),
                    ),
                    child: Text('Войти'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AuthForm extends StatelessWidget {
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final GlobalKey<FormState> formKey;

  const _AuthForm({
    Key? key,
    required this.emailTextController,
    required this.passwordTextController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(children: [
        TextFormField(
          controller: emailTextController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Введите email';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        SizedBox(height: 32.h),
        _PasswordField(passwordTextController: passwordTextController),
      ]),
    );
  }
}

class _PasswordField extends StatefulWidget {
  final TextEditingController passwordTextController;

  const _PasswordField({Key? key, required this.passwordTextController}) : super(key: key);

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: widget.passwordTextController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите пароль';
        }
        return null;
      },
      obscureText: !obscure,
      decoration: InputDecoration(
          labelText: 'Пароль',
          suffixIcon: IconButton(
            icon: !obscure ? SvgPicture.asset(PjIcons.eye) : SvgPicture.asset(PjIcons.eyeOff),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => setState(() {
              obscure = !obscure;
            }),
          )),
    );
  }
}
