import 'package:bloc_login/keys.dart';
import 'package:bloc_login/logic/blocs/auth/bloc/auth_bloc.dart';
import 'package:bloc_login/logic/blocs/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.50;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: const Color(0xFFfcfcfc),
        appBar:  AppBar(
        title: const Text("Auric", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'UniNeue'),),
        backgroundColor: const Color(0xFF53C1E9),
        elevation: 0,
      ),
        body:BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
    if (state is AuthDenied) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(state.errors[0],style: const TextStyle(color: Colors.red),),
    duration: const Duration(milliseconds: 300),
    ));
    }

    if (state is AuthGeneral) {
      Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Logged out successful",style: TextStyle(color: Colors.green),),
        duration: Duration(seconds: 3),
      ));
    }


    },
    builder: (context, state) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Auric Home"),

            ElevatedButton(
                key: const ValueKey(Keys.logoutKey),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(width * 0.65, height * 0.12),
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => {

                  BlocProvider.of<AuthBloc>(context).add(
                      const AuthLogoutRequested("BlocLogin"))
                },
                child: (state is AuthLoading)
                    ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white,))
                    : const Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'UniNeue',
                      fontSize: 20),
                )
            ),

          ],
        ),
      );
    }));
  }
}