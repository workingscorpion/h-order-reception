import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:h_order_reception/components/spin.dart';
import 'package:h_order_reception/utils/snackBarHelper.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SnackBarHelper {
  bool _loading = false;

  FocusNode _idFocusNode;
  FocusNode _passwordFocusNode;

  TextEditingController _idController;
  TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  _logo(),
                  _idField(),
                  _passwordField(),
                ],
              ),
            ),
          ),
        ));
  }

  _logo() => Container(
        child: SvgPicture.asset(
          'assets/logo.svg',
          color: _accentColor(),
          height: 53,
        ),
      );

  _idField() => Container(
        height: 48,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          focusNode: _idFocusNode,
          style: TextStyle(fontSize: 18, color: _accentColor()),
          decoration: _fieldDecoration(
            assetName: 'assets/icons/auth/id.svg',
            hint: '아이디',
          ),
          controller: _idController,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        ),
        margin: EdgeInsets.only(
          bottom: 10,
        ),
      );

  _passwordField() => Container(
        height: 48,
        child: TextField(
          obscureText: true,
          keyboardType: TextInputType.text,
          focusNode: _passwordFocusNode,
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
          bottom: 10,
        ),
      );

  InputDecoration _fieldDecoration({String assetName, String hint}) =>
      InputDecoration(
        prefixIcon: _prefixIcon(assetName),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        filled: true,
        fillColor: Colors.white,
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
          color: Colors.blue,
          child: _loading
              ? Spin()
              : Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
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
      showSnackBar('아이디를 입력해주세요.');
      return;
    }

    if (_passwordController.text?.isEmpty ?? true) {
      showSnackBar('비밀번호를 입력해주세요.');
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      // await UserInfoStore.instance.login(
      //   id: _idController.text,
      //   password: _passwordController.text,
      // );

      // await _loadHotels();
    } catch (ex) {
      // if (ex.type == DioErrorType.RESPONSE) {
      //   final response = ex.response as Response;

      //   if (response.statusCode == 404) {
      //     showSnackBar('잘못된 아이디 또는 비밀번호 입니다.');
      //   }
      // } else {
      //   showSnackBar('로그인에 실패하였습니다. 네트워크 상태를 확인해주세요.');
      // }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Color _primaryColor() => Theme.of(context).primaryColor;

  Color _accentColor() => Theme.of(context).accentColor;
}
