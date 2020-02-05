import 'package:flutter/cupertino.dart';
import 'package:flutter_app/bloc/splash_bloc/splash_bloc_export.dart';
import 'package:flutter_app/const.dart';
import 'package:flutter_app/router_util/navigator_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget
{

  static const String className = "SplashPage";
  @override
  State createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage>
{
  SplashBloc _splashBloc;

  @override
  void initState() {
    _splashBloc = SplashBloc();
    _splashBloc.add(SplashBlocInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashBlocState>(
      bloc: _splashBloc,
      builder: (context, state){
        if (state is SplashBlocInitializedState) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            NavigatorUtil.goHomePage(context);
          });
        }
        return Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Image.asset(LOCAL_IMAGE + 'logo_splash.png'),
                )
              ],
            )
        );
      },
    );

  }
}