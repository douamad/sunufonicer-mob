
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/categorie_cloture_bloc.dart';
import 'categorie_cloture_list_screen.dart';
import 'categorie_cloture_repository.dart';
import 'categorie_cloture_update_screen.dart';
import 'categorie_cloture_view_screen.dart';

class CategorieClotureRoutes {
  static final list = '/entities/categorieCloture-list';
  static final create = '/entities/categorieCloture-create';
  static final edit = '/entities/categorieCloture-edit';
  static final view = '/entities/categorieCloture-view';

  static const listScreenKey = Key('__categorieClotureListScreen__');
  static const createScreenKey = Key('__categorieClotureCreateScreen__');
  static const editScreenKey = Key('__categorieClotureEditScreen__');
  static const viewScreenKey = Key('__categorieClotureViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<CategorieClotureBloc>(
          create: (context) => CategorieClotureBloc(categorieClotureRepository: CategorieClotureRepository())
            ..add(InitCategorieClotureList()),
          child: CategorieClotureListScreen());
    },
    create: (context) {
      return BlocProvider<CategorieClotureBloc>(
          create: (context) => CategorieClotureBloc(categorieClotureRepository: CategorieClotureRepository()),
          child: CategorieClotureUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<CategorieClotureBloc>(
          create: (context) => CategorieClotureBloc(categorieClotureRepository: CategorieClotureRepository())
            ..add(LoadCategorieClotureByIdForEdit(id: arguments.id)),
          child: CategorieClotureUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<CategorieClotureBloc>(
          create: (context) => CategorieClotureBloc(categorieClotureRepository: CategorieClotureRepository())
            ..add(LoadCategorieClotureByIdForView(id: arguments.id)),
          child: CategorieClotureViewScreen());
    },
  };
}
