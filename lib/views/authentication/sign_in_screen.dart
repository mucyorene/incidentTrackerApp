import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_tracker_app/ita_providers/authentication/providers.dart';
import 'package:incident_tracker_app/theme/styles.dart';
import 'package:incident_tracker_app/utils/form_validations.dart';
import 'package:incident_tracker_app/models/core_res.dart';
import 'package:incident_tracker_app/utils/ita_api_utils.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final pinVisibilityProvider = StateProvider<bool>((ref) => false);

  validate() async {
    if (_formKey.currentState!.validate()) {
      var email = _emailController.text;
      var password = _passwordController.text;
      var signInInfo = await ref
          .read(signInProvider.notifier)
          .signIn(email: email, password: password);
      if (signInInfo.status == ResponseStatus.success) {
        context.go("/homepage");
      } else {
        showSnackBar(
          context,
          signInInfo.errorMessage,
          status: signInInfo.status,
          statusCode: signInInfo.statusCode,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var visibility = ref.watch(pinVisibilityProvider);
    var signInState = ref.watch(signInProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Login to your account.",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Please sign in to your account",
                        style: TextStyle(
                          color: Color(0xFF878787),
                          fontSize: 15,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email address",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (s) {
                                      var isEmailValid =
                                          FormValidations.isValidEmail(s ?? "");
                                      if (s == null || s.isEmpty) {
                                        return "Email is required";
                                      } else if (!isEmailValid) {
                                        return "Write valid email";
                                      }
                                      return null;
                                    },
                                    controller: _emailController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: "Enter Email",
                                      suffixIcon: const Icon(Icons.email),
                                      border: StyleUtils.commonInputBorder,
                                      enabledBorder:
                                          StyleUtils.commonEnabledInputBorder,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Password",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      validator: (s) {
                                        if (s == null || s.isEmpty) {
                                          return "Password is required";
                                        } else if (s.length < 6) {
                                          return "Password should be at least 6 characters";
                                        }
                                        return null;
                                      },
                                      obscureText: !visibility,
                                      controller: _passwordController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: "Password",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            ref
                                                .read(
                                                  pinVisibilityProvider
                                                      .notifier,
                                                )
                                                .state = !visibility;
                                          },
                                          splashRadius: 5,
                                          icon:
                                              visibility
                                                  ? const Icon(
                                                    Icons
                                                        .visibility_off_rounded,
                                                  )
                                                  : const Icon(
                                                    Icons.visibility_rounded,
                                                  ),
                                        ),
                                        border: StyleUtils.commonInputBorder,
                                        enabledBorder:
                                            StyleUtils.commonEnabledInputBorder,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: validate,
                                    style: StyleUtils.commonButtonStyle,
                                    child:
                                        signInState.status ==
                                                ResponseStatus.saving
                                            ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              ),
                                            )
                                            : const Text(
                                              "Login",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 15,
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
