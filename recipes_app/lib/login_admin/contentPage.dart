import 'package:recipes_app/widgets/home_page.dart';

abstract class Content {
  Future<HomePageRecipes> lista();
}

class ContentPage implements Content {

  Future<HomePageRecipes> lista() async {
    return HomePageRecipes();
  }
}
