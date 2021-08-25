
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/ref_parcelaire_bloc.dart';
import 'ref_parcelaire_list_screen.dart';
import 'ref_parcelaire_repository.dart';
import 'ref_parcelaire_update_screen.dart';
import 'ref_parcelaire_view_screen.dart';

class RefParcelaireRoutes {
  static final list = '/entities/refParcelaire-list';
  static final create = '/entities/refParcelaire-create';
  static final edit = '/entities/refParcelaire-edit';
  static final view = '/entities/refParcelaire-view';

  static const listScreenKey = Key('__refParcelaireListScreen__');
  static const createScreenKey = Key('__refParcelaireCreateScreen__');
  static const editScreenKey = Key('__refParcelaireEditScreen__');
  static const viewScreenKey = Key('__refParcelaireViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<RefParcelaireBloc>(
          create: (context) => RefParcelaireBloc(refParcelaireRepository: RefParcelaireRepository())
            ..add(InitRefParcelaireList()),
          child: RefParcelaireListScreen());
    },
    create: (context) {
      return BlocProvider<RefParcelaireBloc>(
          create: (context) => RefParcelaireBloc(refParcelaireRepository: RefParcelaireRepository()),
          child: RefParcelaireUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<RefParcelaireBloc>(
          create: (context) => RefParcelaireBloc(refParcelaireRepository: RefParcelaireRepository())
            ..add(LoadRefParcelaireByIdForEdit(id: arguments.id)),
          child: RefParcelaireUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<RefParcelaireBloc>(
          create: (context) => RefParcelaireBloc(refParcelaireRepository: RefParcelaireRepository())
            ..add(LoadRefParcelaireByIdForView(id: arguments.id)),
          child: RefParcelaireViewScreen());
    },
  };
}
