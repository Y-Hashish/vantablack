// import 'dart:js';

// import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frist_pages/features/onboarding/model/onboarding_model.dart';
//import 'package:frist_pages/features/registration/view/page/regisration_page.dart';
import 'package:frist_pages/signUp.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:meta/meta.dart';

part 'onboarding_cotroller_state.dart';

class OnboardingCotrollerCubit extends Cubit<OnboardingCotrollerState> {
  OnboardingCotrollerCubit() : super(OnboardingCotrollerInitial());
  int pageindex = 0;
  PageController pageController = PageController();

  void onChangeToNext(BuildContext context) {
    if (theLastPage) {
      onCallSkip(context);
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
    }
  }

  void onCallSkip(BuildContext context) async {
//  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    await sharedPreferences.setBool('onboarding',true);

    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Signup(),
      ),
    );
  }

  List data = [
    OnboardingModel(
      image: 'assets/images/logo.jpg',
      title: 'First',
      subtitle: 'this is Mob_proj',
      color: Colors.green,
    ),
    OnboardingModel(
      image: "assets/images/logo.jpg",
      title: 'Second',
      subtitle: 'We are :\n Yousef Hashish\n Yousef Hesham\n Norhan Nabile',
      color: Colors.blue,
    ),
    OnboardingModel(
      image: 'assets/images/logo.jpg',
      title: 'Third',
      subtitle: 'Supedvised by: \n (Eng: Mohamed Hamed)',
      color: Colors.red,
    ),
  ];
  bool theLastPage = false;
  void onChangePage(int value) {
    theLastPage = value == data.length - 1;
    // if (value == data.length - 1) {
    //   theLastPage = true;
    // }
  }
}
