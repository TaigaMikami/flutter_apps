import 'package:recipes_app/widgets/home_page.dart';
import 'package:recipes_app/pages/myrecipes/list_my_recipe.dart';
import 'package:recipes_app/pages/admin/show_recipe.dart';
import 'package:recipes_app/pages/maps_page.dart';

abstract class Content {
  Future<HomePageRecipes> lista();
  Future<ListMyRecipe> myrecipe(String id);
  Future<InicioPage> admin();
  Future<MapsPage> maps();
}

class ContentPage implements Content {

  Future<HomePageRecipes> lista() async {
    return HomePageRecipes();
  }

  Future<ListMyRecipe> myrecipe(String id) async {
    print('my list recipe $id');
    return ListMyRecipe(id: id,);
  }

  Future<InicioPage> admin() async {
    return InicioPage();
  }

  Future<MapsPage> maps() async {
    return MapsPage();
  }
}
