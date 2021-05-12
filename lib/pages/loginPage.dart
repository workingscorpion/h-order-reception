import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/components/spin.dart';
import 'package:h_order_reception/store/userInfoStore.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  TextEditingController _idController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _idController = TextEditingController();
    _passwordController = TextEditingController();

    _idController.text = 'djdj159';
    _passwordController.text = '123123';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3,
                vertical: MediaQuery.of(context).size.height * 0.2,
              ),
              child: Column(
                children: [
                  _logo(),
                  _idField(),
                  _passwordField(),
                  _loginButton(),
                ],
              ),
            ),
          ),
        ));
  }

  _logo() => Container(
      height: 200,
      width: 200,
      margin: EdgeInsets.only(bottom: 100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SvgPicture.asset(
          'assets/logo.svg',
          fit: BoxFit.fill,
        ),
      ));

  _idField() => Container(
        height: 48,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 18, color: _accentColor()),
          decoration: _fieldDecoration(
            assetName: 'assets/icons/auth/id.svg',
            hint: '아이디',
          ),
          controller: _idController,
          textInputAction: TextInputAction.next,
        ),
        margin: EdgeInsets.only(
          bottom: 20,
        ),
      );

  _passwordField() => Container(
        height: 48,
        child: TextField(
          obscureText: true,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 18, color: _accentColor()),
          controller: _passwordController,
          decoration: _fieldDecoration(
            assetName: 'assets/icons/auth/password.svg',
            hint: '패스워드',
          ),
          onEditingComplete: () {
            _login();
          },
        ),
        margin: EdgeInsets.only(
          bottom: 20,
        ),
      );

  InputDecoration _fieldDecoration({String assetName, String hint}) =>
      InputDecoration(
        prefixIcon: _prefixIcon(assetName),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        filled: true,
        fillColor: _primaryColor(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _accentColor(),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _accentColor(),
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: _accentColor(),
        ),
      );

  Widget _prefixIcon(String assetName) => Padding(
        padding: EdgeInsets.all(13),
        child: SvgPicture.asset(
          assetName,
          color: _accentColor(),
        ),
      );

  _loginButton() => Container(
        child: FlatButton(
          height: 48,
          color: _accentColor(),
          child: _loading
              ? Spin()
              : Text(
                  '로그인',
                  style: TextStyle(
                    color: _primaryColor(),
                    fontSize: 18,
                  ),
                ),
          onPressed: () {
            _login();
          },
        ),
        margin: EdgeInsets.only(
          bottom: 10,
        ),
      );

  _login() async {
    if ((_idController.text?.isEmpty ?? true)) {
      showToast('아이디를 입력해주세요.');
      return;
    }

    if (_passwordController.text?.isEmpty ?? true) {
      showToast('비밀번호를 입력해주세요.');
      return;
    }

    _loading = true;
    setState(() {});

    try {
      await UserInfoStore.instance.login(
        id: _idController.text,
        password: _passwordController.text,
      );

      AppRouter.toHomePage();
    } catch (ex) {
      if (ex.type == DioErrorType.RESPONSE) {
        final response = ex.response as Response;

        if (response.statusCode == 404) {
          showToast('잘못된 아이디 또는 비밀번호 입니다.');
        }
      } else {
        showToast('로그인에 실패하였습니다. 네트워크 상태를 확인해주세요.');
      }
    } finally {
      _loading = false;
      setState(() {});
    }
  }

  showToast(String message) async => await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.66),
        textColor: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 17,
      );

  Color _primaryColor() => Theme.of(context).primaryColor;

  Color _accentColor() => Theme.of(context).accentColor;
}
