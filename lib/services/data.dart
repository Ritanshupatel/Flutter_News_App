import 'package:newser/models/category_model.dart';

    List<CategoryModel> getCategories(){
  List <CategoryModel> category=[];

  CategoryModel categoryModel  = new CategoryModel();

  categoryModel.categoryName='bussiness';
  categoryModel.image="images/business.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName='Entertainment';
  categoryModel.image="images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName='General';
  categoryModel.image="images/general.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName='Helth';
  categoryModel.image="images/health.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName='sports';
  categoryModel.image="images/sport.jpg";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;



    }