
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/dossier_bloc.dart';
import 'dossier_list_screen.dart';
import 'dossier_repository.dart';
import 'dossier_update_screen.dart';
import 'dossier_view_screen.dart';

class DossierRoutes {
  static final list = '/entities/dossier-list';
  static final create = '/entities/dossier-create';
  static final edit = '/entities/dossier-edit';
  static final view = '/entities/dossier-view';

  static const listScreenKey = Key('__dossierListScreen__');
  static const createScreenKey = Key('__dossierCreateScreen__');
  static const editScreenKey = Key('__dossierEditScreen__');
  static const viewScreenKey = Key('__dossierViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<DossierBloc>(
          create: (context) => DossierBloc(dossierRepository: DossierRepository())
            ..add(InitDossierList()),
          child: DossierListScreen());
    },
    create: (context) {
      return BlocProvider<DossierBloc>(
          create: (context) => DossierBloc(dossierRepository: DossierRepository()),
          child: DossierUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DossierBloc>(
          create: (context) => DossierBloc(dossierRepository: DossierRepository())
            ..add(LoadDossierByIdForEdit(id: arguments.id)),
          child: DossierUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DossierBloc>(
          create: (context) => DossierBloc(dossierRepository: DossierRepository())
            ..add(LoadDossierByIdForView(id: arguments.id)),
          child: DossierViewScreen());
    },
  };
}
