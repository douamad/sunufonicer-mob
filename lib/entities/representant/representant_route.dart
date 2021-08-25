
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/representant_bloc.dart';
import 'representant_list_screen.dart';
import 'representant_repository.dart';
import 'representant_update_screen.dart';
import 'representant_view_screen.dart';

class RepresentantRoutes {
  static final list = '/entities/representant-list';
  static final create = '/entities/representant-create';
  static final edit = '/entities/representant-edit';
  static final view = '/entities/representant-view';

  static const listScreenKey = Key('__representantListScreen__');
  static const createScreenKey = Key('__representantCreateScreen__');
  static const editScreenKey = Key('__representantEditScreen__');
  static const viewScreenKey = Key('__representantViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<RepresentantBloc>(
          create: (context) => RepresentantBloc(representantRepository: RepresentantRepository())
            ..add(InitRepresentantList()),
          child: RepresentantListScreen());
    },
    create: (context) {
      return BlocProvider<RepresentantBloc>(
          create: (context) => RepresentantBloc(representantRepository: RepresentantRepository()),
          child: RepresentantUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<RepresentantBloc>(
          create: (context) => RepresentantBloc(representantRepository: RepresentantRepository())
            ..add(LoadRepresentantByIdForEdit(id: arguments.id)),
          child: RepresentantUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<RepresentantBloc>(
          create: (context) => RepresentantBloc(representantRepository: RepresentantRepository())
            ..add(LoadRepresentantByIdForView(id: arguments.id)),
          child: RepresentantViewScreen());
    },
  };
}
