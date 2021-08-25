
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/quartier_bloc.dart';
import 'quartier_list_screen.dart';
import 'quartier_repository.dart';
import 'quartier_update_screen.dart';
import 'quartier_view_screen.dart';

class QuartierRoutes {
  static final list = '/entities/quartier-list';
  static final create = '/entities/quartier-create';
  static final edit = '/entities/quartier-edit';
  static final view = '/entities/quartier-view';

  static const listScreenKey = Key('__quartierListScreen__');
  static const createScreenKey = Key('__quartierCreateScreen__');
  static const editScreenKey = Key('__quartierEditScreen__');
  static const viewScreenKey = Key('__quartierViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<QuartierBloc>(
          create: (context) => QuartierBloc(quartierRepository: QuartierRepository())
            ..add(InitQuartierList()),
          child: QuartierListScreen());
    },
    create: (context) {
      return BlocProvider<QuartierBloc>(
          create: (context) => QuartierBloc(quartierRepository: QuartierRepository()),
          child: QuartierUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<QuartierBloc>(
          create: (context) => QuartierBloc(quartierRepository: QuartierRepository())
            ..add(LoadQuartierByIdForEdit(id: arguments.id)),
          child: QuartierUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<QuartierBloc>(
          create: (context) => QuartierBloc(quartierRepository: QuartierRepository())
            ..add(LoadQuartierByIdForView(id: arguments.id)),
          child: QuartierViewScreen());
    },
  };
}
