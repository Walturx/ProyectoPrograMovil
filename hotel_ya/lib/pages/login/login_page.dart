import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ya/cubits/login_cubit.dart';
import 'package:hotel_ya/cubits/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isLogin = true;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    birthdateController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _clearFields() {
    nameController.clear();
    phoneController.clear();
    birthdateController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedIn) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('¡Bienvenido!')));
          context.go('/home');
        } else if (state is AuthRegistered) {
          setState(() => isLogin = true);
          _clearFields();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cuenta creada. Inicia sesión para continuar.'),
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(centerTitle: true, elevation: 0),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: size.height * 0.03),
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: size.height * 0.25,
                    height: size.height * 0.25,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                if (!isLogin)
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre Completo',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                if (!isLogin) const SizedBox(height: 16),
                if (!isLogin)
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Número de Teléfono',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                if (!isLogin) const SizedBox(height: 16),
                if (!isLogin)
                  TextField(
                    controller: birthdateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        birthdateController.text =
                            "${picked.day}/${picked.month}/${picked.year}";
                      }
                    },
                  ),
                if (!isLogin) const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'tu@email.com',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                const SizedBox(height: 16),
                if (!isLogin)
                  TextField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Repetir Contraseña',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    obscureText: _obscureConfirmPassword,
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (isLogin) {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Completa email y contraseña'),
                          ),
                        );
                        return;
                      }
                      context.read<AuthCubit>().login(
                        emailController.text,
                        passwordController.text,
                      );
                    } else {
                      if (nameController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          birthdateController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Completa todos los campos'),
                          ),
                        );
                        return;
                      }

                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Las contraseñas no coinciden'),
                          ),
                        );
                        return;
                      }

                      context.read<AuthCubit>().register(
                        nameController.text,
                        phoneController.text,
                        birthdateController.text,
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isLogin ? 'Iniciar Sesión' : 'Registrarse',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                if (isLogin)
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.mail),
                    label: const Text('Continuar con Gmail'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                    _clearFields();
                  },
                  child: Text(
                    isLogin
                        ? '¿No tienes cuenta? Regístrate aquí'
                        : '¿Ya tienes cuenta? Inicia sesión',
                  ),
                ),
                const SizedBox(height: 12),
                if (isLogin)
                  TextButton(
                    onPressed: () {
                      context.go('/forgot_password');
                    },
                    child: const Text('¿Olvidaste tu contraseña?'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
