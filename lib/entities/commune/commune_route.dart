
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/commune_bloc.dart';
import 'commune_list_screen.dart';
import 'commune_repository.dart';
import 'commune_update_screen.dart';
import 'commune_view_screen.dart';

class CommuneRoutes {
  static final list = '/entities/commune-list';
  static final create = '/entities/commune-create';
  static final edit = '/entities/commune-edit';
  static final view = '/entities/commune-view';

  static const listScreenKey = Key('__communeListScreen__');
  static const createScreenKey = Key('__communeCreateScreen__');
  static const editScreenKey = Key('__communeEditScreen__');
  static const viewScreenKey = Key('__communeViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<CommuneBloc>(
          create: (context) => CommuneBloc(communeRepository: CommuneRepository())
            ..add(InitCommuneList()),
          child: CommuneListScreen());
    },
    create: (context) {
      return BlocProvider<CommuneBloc>(
          create: (context) => CommuneBloc(communeRepository: CommuneRepository()),
          child: CommuneUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<CommuneBloc>(
          create: (context) => CommuneBloc(communeRepository: CommuneRepository())
            ..add(LoadCommuneByIdForEdit(id: arguments.id)),
          child: CommuneUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<CommuneBloc>(
          create: (context) => CommuneBloc(communeRepository: CommuneRepository())
            ..add(LoadCommuneByIdForView(id: arguments.id)),
          child: CommuneViewScreen());
    },
  };
}
