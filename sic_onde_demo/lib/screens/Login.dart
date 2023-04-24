part of lib.screens;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  bool isRemember = false;
  bool loading = false;
  bool check_email = false;
  bool view_pass = false;
  var userTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var firstNameTextController = TextEditingController();
  var lastNameTextController = TextEditingController();
  var groupTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF98D2FC),
                Color(0xFF72C2FB),
                Color(0xFF41acfa),
                Color(0xFF078BEA)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 20),
                  // height: 100,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.0),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.0),
                          blurRadius: 15,
                          spreadRadius: 5)
                    ],
                  ),
                  child: GetBuilder<LoginController>(builder: (value) {
                    return Text(
                      !value.isSignUp ? "ONDE Project\nLogin" : "Register",
                      style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    );
                  })),
              GetBuilder<LoginController>(builder: (value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.bounceInOut,
                    padding: EdgeInsets.all(20),
                    height: value.isSignUp ? 600 : 450,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5)
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _loginController.setIsSignUp(false);
                                    // setState(() {
                                    //     userTextController.text = "";
                                    //     passwordTextController.text = "";
                                    //   });
                                  },
                                  child: Column(
                                    children: [
                                      Text('LOGIN',
                                          style: GoogleFonts.nunito(
                                              color: value.isSignUp
                                                  ? Color(0xFFb6dffd)
                                                  : Color(0xFF73C2FB),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      if (!value.isSignUp)
                                        Container(
                                          margin: EdgeInsets.only(top: 3),
                                          height: 2,
                                          width: 55,
                                          color: Color(0xFF73C2FB),
                                        )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _loginController.setIsSignUp(true);

                                    print("win");
                                    // setState(() {
                                    //   isSignup = true;
                                    //   setState(() {
                                    //     userTextController.text = "";
                                    //     passwordTextController.text = "";
                                    //   });
                                    // });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'SIGN UP',
                                        style: GoogleFonts.nunito(
                                            color: value.isSignUp
                                                ? Color(0xFF73C2FB)
                                                : Color(0xFFb6dffd),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      if (value.isSignUp)
                                        Container(
                                          margin: EdgeInsets.only(top: 3),
                                          height: 2,
                                          width: 55,
                                          color: Color(0xFF73C2FB),
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!value.isSignUp)
                            Container(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      textfield_login(Entypo.user, "Username",
                                          userTextController, false, false),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      textfield_login(
                                          Entypo.lock_open,
                                          "Password",
                                          passwordTextController,
                                          true,
                                          true),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  value.setIsRemember(
                                                      !value.isRemember);
                                                },
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  margin: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: value.isRemember
                                                          ? Color(0xFF73C2FB)
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xFF73C2FB)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Icon(
                                                    Icons.check,
                                                    color: value.isRemember
                                                        ? Colors.white
                                                        : Color(0xFF73C2FB),
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Text("Remember me",
                                                  style: GoogleFonts.nunito(
                                                    color: Color(0xFF73C2FB),
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Forget Password?",
                                                style: GoogleFonts.nunito(
                                                  color: Color(0xFF73C2FB),
                                                  fontSize: 12,
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            color: Color(0xFF73C2FB)
                                                .withOpacity(0.8),
                                            border: Border.all(
                                                color: Color(0xFF73C2FB)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                  offset: Offset(0, 1))
                                            ]),
                                        child: TextButton(
                                          onPressed: () async {
                                            _loginController.setAuth(
                                                username:
                                                    userTextController.text,
                                                password: passwordTextController
                                                    .text);
                                            final _connecting =
                                                await _loginController
                                                    .ConnectingNetwork();
                                            if (_connecting) {
                                              await _loginController
                                                  .authLogin();
                                            }

                                            // Get.to(() => HomeScreen());
                                          },
                                          child: Text('Login',
                                              style: GoogleFonts.nunito(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Color(0xFF73C2FB)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                  offset: Offset(0, 1))
                                            ]),
                                        child: TextButton(
                                          onPressed: () {
                                            Get.off(() => HomeScreen(),
                                                transition: Transition.fadeIn);
                                          },
                                          child: Text('Guest',
                                              style: GoogleFonts.nunito(
                                                  color: Color(0xFF73C2FB),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          if (value.isSignUp)
                            Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  textfield_login(Entypo.vcard, "First Name",
                                      firstNameTextController, false, false),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textfield_login(Entypo.vcard, "Last Name",
                                      lastNameTextController, false, false),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textfield_login(Entypo.mail, "Email",
                                      emailTextController, false, false),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textfield_login(Entypo.users, "Group",
                                      groupTextController, false, false),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textfield_login(Entypo.user, "Username",
                                      userTextController, false, false),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textfield_login(Entypo.lock, "Password",
                                      passwordTextController, true, false),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        color:
                                            Color(0xFF73C2FB).withOpacity(0.8),
                                        border: Border.all(
                                            color: Color(0xFF73C2FB)),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                              offset: Offset(0, 1))
                                        ]),
                                    child: TextButton(
                                      onPressed: () async {
                                        final _connecting =
                                            await _loginController
                                                .ConnectingNetwork();
                                        if (_connecting) {
                                          await _loginController.setNewUser(
                                              firstName:
                                                  firstNameTextController.text,
                                              lastName:
                                                  lastNameTextController.text,
                                              email: emailTextController.text,
                                              group: groupTextController.text,
                                              username: userTextController.text,
                                              password:
                                                  passwordTextController.text);
                                        }
                                      },
                                      child: Text('Sign Up',
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  TextField textfield_login(IconData icon, String hinttext, var controller,
      bool hint_pass, bool ispass) {
    return TextField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      obscureText: view_pass ? false : hint_pass,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Color(0xFF73C2FB),
          ),
          suffixIcon: ispass
              ? IconButton(
                  icon: view_pass
                      ? Icon(
                          FontAwesome5.eye,
                          color: Color(0xFF73C2FB).withOpacity(0.8),
                          size: 12,
                        )
                      : Icon(
                          FontAwesome5.eye_slash,
                          color: Color(0xFF73C2FB).withOpacity(0.8),
                          size: 12,
                        ),
                  onPressed: () {
                    print(view_pass);
                    setState(() {
                      hint_pass = !hint_pass;
                      view_pass = !view_pass;
                    });
                  })
              : null,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF73C2FB), width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF73C2FB), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          hintText: hinttext,
          hintStyle: GoogleFonts.nunito(
            color: Color(0xFF73C2FB),
            fontSize: 16,
          )),
    );
  }
}
