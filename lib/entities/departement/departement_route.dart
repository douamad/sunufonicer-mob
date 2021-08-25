
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/departement_bloc.dart';
import 'departement_list_screen.dart';
import 'departement_repository.dart';
import 'departement_update_screen.dart';
import 'departement_view_screen.dart';

class DepartementRoutes {
  static final list = '/entities/departement-list';
  static final create = '/entities/departement-create';
  static final edit = '/entities/departement-edit';
  static final view = '/entities/departement-view';

  static const listScreenKey = Key('__departementListScreen__');
  static const createScreenKey = Key('__departementCreateScreen__');
  static const editScreenKey = Key('__departementEditScreen__');
  static const viewScreenKey = Key('__departementViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<DepartementBloc>(
          create: (context) => DepartementBloc(departementRepository: DepartementRepository())
            ..add(InitDepartementList()),
          child: DepartementListScreen());
    },
    create: (context) {
      return BlocProvider<DepartementBloc>(
          create: (context) => DepartementBloc(departementRepository: DepartementRepository()),
          child: DepartementUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DepartementBloc>(
          create: (context) => DepartementBloc(departementRepository: DepartementRepository())
            ..add(LoadDepartementByIdForEdit(id: arguments.id)),
          child: DepartementUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DepartementBloc>(
          create: (context) => DepartementBloc(departementRepository: DepartementRepository())
            ..add(LoadDepartementByIdForView(id: arguments.id)),
          child: DepartementViewScreen());
    },
  };
}
