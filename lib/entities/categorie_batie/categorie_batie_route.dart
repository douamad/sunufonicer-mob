
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/categorie_batie_bloc.dart';
import 'categorie_batie_list_screen.dart';
import 'categorie_batie_repository.dart';
import 'categorie_batie_update_screen.dart';
import 'categorie_batie_view_screen.dart';

class CategorieBatieRoutes {
  static final list = '/entities/categorieBatie-list';
  static final create = '/entities/categorieBatie-create';
  static final edit = '/entities/categorieBatie-edit';
  static final view = '/entities/categorieBatie-view';

  static const listScreenKey = Key('__categorieBatieListScreen__');
  static const createScreenKey = Key('__categorieBatieCreateScreen__');
  static const editScreenKey = Key('__categorieBatieEditScreen__');
  static const viewScreenKey = Key('__categorieBatieViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<CategorieBatieBloc>(
          create: (context) => CategorieBatieBloc(categorieBatieRepository: CategorieBatieRepository())
            ..add(InitCategorieBatieList()),
          child: CategorieBatieListScreen());
    },
    create: (context) {
      return BlocProvider<CategorieBatieBloc>(
          create: (context) => CategorieBatieBloc(categorieBatieRepository: CategorieBatieRepository()),
          child: CategorieBatieUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<CategorieBatieBloc>(
          create: (context) => CategorieBatieBloc(categorieBatieRepository: CategorieBatieRepository())
            ..add(LoadCategorieBatieByIdForEdit(id: arguments.id)),
          child: CategorieBatieUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<CategorieBatieBloc>(
          create: (context) => CategorieBatieBloc(categorieBatieRepository: CategorieBatieRepository())
            ..add(LoadCategorieBatieByIdForView(id: arguments.id)),
          child: CategorieBatieViewScreen());
    },
  };
}
