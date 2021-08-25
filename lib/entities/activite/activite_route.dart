
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/activite_bloc.dart';
import 'activite_list_screen.dart';
import 'activite_repository.dart';
import 'activite_update_screen.dart';
import 'activite_view_screen.dart';

class ActiviteRoutes {
  static final list = '/entities/activite-list';
  static final create = '/entities/activite-create';
  static final edit = '/entities/activite-edit';
  static final view = '/entities/activite-view';

  static const listScreenKey = Key('__activiteListScreen__');
  static const createScreenKey = Key('__activiteCreateScreen__');
  static const editScreenKey = Key('__activiteEditScreen__');
  static const viewScreenKey = Key('__activiteViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<ActiviteBloc>(
          create: (context) => ActiviteBloc(activiteRepository: ActiviteRepository())
            ..add(InitActiviteList()),
          child: ActiviteListScreen());
    },
    create: (context) {
      return BlocProvider<ActiviteBloc>(
          create: (context) => ActiviteBloc(activiteRepository: ActiviteRepository()),
          child: ActiviteUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ActiviteBloc>(
          create: (context) => ActiviteBloc(activiteRepository: ActiviteRepository())
            ..add(LoadActiviteByIdForEdit(id: arguments.id)),
          child: ActiviteUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ActiviteBloc>(
          create: (context) => ActiviteBloc(activiteRepository: ActiviteRepository())
            ..add(LoadActiviteByIdForView(id: arguments.id)),
          child: ActiviteViewScreen());
    },
  };
}
