import 'package:news_app/model/category_model.dart';

List<Category_model> getCategories(){
  List<Category_model> Category = [];

  Category_model category_model = Category_model();

  category_model.categoryName = "Business";
  category_model.image = 'assets/business.jpg';
  Category.add(category_model);
  category_model = Category_model();

    category_model.categoryName = "Entertainment";
  category_model.image = 'assets/entertainment.png';
  Category.add(category_model);
  category_model = Category_model();


    category_model.categoryName = "General";
  category_model.image = 'assets/general.jpg';
  Category.add(category_model);
  category_model = Category_model();

    category_model.categoryName = "health";
  category_model.image = 'assets/health.jpg';
  Category.add(category_model);
  category_model = Category_model();

    category_model.categoryName = "Sports";
  category_model.image ='assets/sports.jpg';
  Category.add(category_model);
  category_model = Category_model();
  return Category;
} 