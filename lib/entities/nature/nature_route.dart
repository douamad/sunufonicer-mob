
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/nature_bloc.dart';
import 'nature_list_screen.dart';
import 'nature_repository.dart';
import 'nature_update_screen.dart';
import 'nature_view_screen.dart';

class NatureRoutes {
  static final list = '/entities/nature-list';
  static final create = '/entities/nature-create';
  static final edit = '/entities/nature-edit';
  static final view = '/entities/nature-view';

  static const listScreenKey = Key('__natureListScreen__');
  static const createScreenKey = Key('__natureCreateScreen__');
  static const editScreenKey = Key('__natureEditScreen__');
  static const viewScreenKey = Key('__natureViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<NatureBloc>(
          create: (context) => NatureBloc(natureRepository: NatureRepository())
            ..add(InitNatureList()),
          child: NatureListScreen());
    },
    create: (context) {
      return BlocProvider<NatureBloc>(
          create: (context) => NatureBloc(natureRepository: NatureRepository()),
          child: NatureUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<NatureBloc>(
          create: (context) => NatureBloc(natureRepository: NatureRepository())
            ..add(LoadNatureByIdForEdit(id: arguments.id)),
          child: NatureUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<NatureBloc>(
          create: (context) => NatureBloc(natureRepository: NatureRepository())
            ..add(LoadNatureByIdForView(id: arguments.id)),
          child: NatureViewScreen());
    },
  };
}
