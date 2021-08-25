
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/lotissement_bloc.dart';
import 'lotissement_list_screen.dart';
import 'lotissement_repository.dart';
import 'lotissement_update_screen.dart';
import 'lotissement_view_screen.dart';

class LotissementRoutes {
  static final list = '/entities/lotissement-list';
  static final create = '/entities/lotissement-create';
  static final edit = '/entities/lotissement-edit';
  static final view = '/entities/lotissement-view';

  static const listScreenKey = Key('__lotissementListScreen__');
  static const createScreenKey = Key('__lotissementCreateScreen__');
  static const editScreenKey = Key('__lotissementEditScreen__');
  static const viewScreenKey = Key('__lotissementViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<LotissementBloc>(
          create: (context) => LotissementBloc(lotissementRepository: LotissementRepository())
            ..add(InitLotissementList()),
          child: LotissementListScreen());
    },
    create: (context) {
      return BlocProvider<LotissementBloc>(
          create: (context) => LotissementBloc(lotissementRepository: LotissementRepository()),
          child: LotissementUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<LotissementBloc>(
          create: (context) => LotissementBloc(lotissementRepository: LotissementRepository())
            ..add(LoadLotissementByIdForEdit(id: arguments.id)),
          child: LotissementUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<LotissementBloc>(
          create: (context) => LotissementBloc(lotissementRepository: LotissementRepository())
            ..add(LoadLotissementByIdForView(id: arguments.id)),
          child: LotissementViewScreen());
    },
  };
}
