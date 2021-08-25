
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/arrondissement_bloc.dart';
import 'arrondissement_list_screen.dart';
import 'arrondissement_repository.dart';
import 'arrondissement_update_screen.dart';
import 'arrondissement_view_screen.dart';

class ArrondissementRoutes {
  static final list = '/entities/arrondissement-list';
  static final create = '/entities/arrondissement-create';
  static final edit = '/entities/arrondissement-edit';
  static final view = '/entities/arrondissement-view';

  static const listScreenKey = Key('__arrondissementListScreen__');
  static const createScreenKey = Key('__arrondissementCreateScreen__');
  static const editScreenKey = Key('__arrondissementEditScreen__');
  static const viewScreenKey = Key('__arrondissementViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<ArrondissementBloc>(
          create: (context) => ArrondissementBloc(arrondissementRepository: ArrondissementRepository())
            ..add(InitArrondissementList()),
          child: ArrondissementListScreen());
    },
    create: (context) {
      return BlocProvider<ArrondissementBloc>(
          create: (context) => ArrondissementBloc(arrondissementRepository: ArrondissementRepository()),
          child: ArrondissementUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ArrondissementBloc>(
          create: (context) => ArrondissementBloc(arrondissementRepository: ArrondissementRepository())
            ..add(LoadArrondissementByIdForEdit(id: arguments.id)),
          child: ArrondissementUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ArrondissementBloc>(
          create: (context) => ArrondissementBloc(arrondissementRepository: ArrondissementRepository())
            ..add(LoadArrondissementByIdForView(id: arguments.id)),
          child: ArrondissementViewScreen());
    },
  };
}
