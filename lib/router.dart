import 'package:flutter/material.dart';
import 'package:hck_locat_test1/data_models/post.dart';
import 'package:hck_locat_test1/shared/route_names.dart';
import 'package:hck_locat_test1/views/createEviden_view.dart';
import 'package:hck_locat_test1/views/createPost_view.dart';
import 'package:hck_locat_test1/views/evidencija_view.dart';
import 'package:hck_locat_test1/views/home_view.dart';
import 'package:hck_locat_test1/views/home_voditelj_view.dart';
import 'package:hck_locat_test1/views/izvjestaj_view.dart';
import 'package:hck_locat_test1/views/kontakti_view.dart';
import 'package:hck_locat_test1/views/sign_in.dart';
import 'package:hck_locat_test1/views/sign_up.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case VoditeljHomeRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeVoditelj(),
      );
    case CreatePostViewRoute:
      var postToEdit = settings.arguments as Post;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreatePostView(
          edittingPost: postToEdit,
        ),
      );
    case IzvjestajViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: IzvjestajView(),
      );
    case EvidencijaViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: EvidencijaView(),
      );

    case KontaktiViewROute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: KontaktiView(),
      );
    /*
    case CreateEvidenViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateEvidenView(),
      ); */

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
