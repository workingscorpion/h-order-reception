import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_order_reception/appRouter.dart';
import 'package:h_order_reception/components/spin.dart';
import 'package:h_order_reception/constants/customColors.dart';
import 'package:h_order_reception/store/userInfoStore.dart';
import 'package:package_info/package_info.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String versionNumber = '';
  bool _loading = false;

  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _getVersion();
    super.initState();
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionNumber = packageInfo.version;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3,
                vertical: MediaQuery.of(context).size.height * 0.27,
              ),
              child: SingleChildScrollView(
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
            Positioned(
              bottom: 0,
              left: 0,
              child: Text('Version: $versionNumber'),
            ),
          ],
        ),
      ),
    );
  }

  _logo() => SvgPicture.asset(
        'assets/icons/auth/logo_green.svg',
        height: 100,
      );

  _idField() => Container(
        height: 48,
        width: 350,
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
          top: 50,
          bottom: 30,
        ),
      );

  _passwordField() => Container(
        height: 48,
        width: 350,
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
          bottom: 70,
        ),
      );

  InputDecoration _fieldDecoration({String assetName, String hint}) =>
      InputDecoration(
        prefixIcon: _prefixIcon(assetName),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        filled: true,
        fillColor: CustomColors.evenColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
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
        child: InkWell(
          onTap: () {
            _login();
          },
          child: Container(
            height: 48,
            width: 150,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: _accentColor(),
            ),
            child: _loading
                ? Spin()
                : Text(
                    '로그인',
                    style: TextStyle(
                      color: _primaryColor(),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
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
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.RESPONSE) {
        final response = ex.response;

        if (response.statusCode == 500 || response.statusCode == 404) {
          showToast('잘못된 아이디 또는 비밀번호 입니다.');
        }
      } else {
        showToast('로그인에 실패하였습니다. 네트워크 상태를 확인해주세요.');
      }
    } catch (ex) {
      print(ex);
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
