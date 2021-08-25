
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/proprietaire_bloc.dart';
import 'proprietaire_list_screen.dart';
import 'proprietaire_repository.dart';
import 'proprietaire_update_screen.dart';
import 'proprietaire_view_screen.dart';

class ProprietaireRoutes {
  static final list = '/entities/proprietaire-list';
  static final create = '/entities/proprietaire-create';
  static final edit = '/entities/proprietaire-edit';
  static final view = '/entities/proprietaire-view';

  static const listScreenKey = Key('__proprietaireListScreen__');
  static const createScreenKey = Key('__proprietaireCreateScreen__');
  static const editScreenKey = Key('__proprietaireEditScreen__');
  static const viewScreenKey = Key('__proprietaireViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<ProprietaireBloc>(
          create: (context) => ProprietaireBloc(proprietaireRepository: ProprietaireRepository())
            ..add(InitProprietaireList()),
          child: ProprietaireListScreen());
    },
    create: (context) {
      return BlocProvider<ProprietaireBloc>(
          create: (context) => ProprietaireBloc(proprietaireRepository: ProprietaireRepository()),
          child: ProprietaireUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ProprietaireBloc>(
          create: (context) => ProprietaireBloc(proprietaireRepository: ProprietaireRepository())
            ..add(LoadProprietaireByIdForEdit(id: arguments.id)),
          child: ProprietaireUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ProprietaireBloc>(
          create: (context) => ProprietaireBloc(proprietaireRepository: ProprietaireRepository())
            ..add(LoadProprietaireByIdForView(id: arguments.id)),
          child: ProprietaireViewScreen());
    },
  };
}
