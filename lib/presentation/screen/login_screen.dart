import 'package:clean_sample/data/datasource/auth_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../bloc/loginbloc/login_bloc.dart';
import '../bloc/loginbloc/login_event.dart';
import '../bloc/loginbloc/login_state.dart';
import 'package:clean_sample/domain/usecases/auth_usecase.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(AuthUsecase(AuthRepositoryImpl(AuthDatasource()))),
      child: Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome, ${state.user.name}!")),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: "Email"),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              LoginSubmitted(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}