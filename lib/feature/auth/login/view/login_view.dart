import 'package:a_pos_flutter/feature/auth/login/cubit/login_cubit.dart';
import 'package:a_pos_flutter/feature/auth/login/view/widget/login_body_widget.dart';
import 'package:a_pos_flutter/feature/auth/token/cubit/token_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (_) {
            final cubit = TokenCubit();
            cubit.init();
            return cubit;
          },
        ),
      ],
      child: const Scaffold(
        body: SafeArea(child: LoginBodyWidget()),
      ),
    );
  }
}
