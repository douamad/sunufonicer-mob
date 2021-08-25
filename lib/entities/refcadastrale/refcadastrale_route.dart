
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/refcadastrale_bloc.dart';
import 'refcadastrale_list_screen.dart';
import 'refcadastrale_repository.dart';
import 'refcadastrale_update_screen.dart';
import 'refcadastrale_view_screen.dart';

class RefcadastraleRoutes {
  static final list = '/entities/refcadastrale-list';
  static final create = '/entities/refcadastrale-create';
  static final edit = '/entities/refcadastrale-edit';
  static final view = '/entities/refcadastrale-view';

  static const listScreenKey = Key('__refcadastraleListScreen__');
  static const createScreenKey = Key('__refcadastraleCreateScreen__');
  static const editScreenKey = Key('__refcadastraleEditScreen__');
  static const viewScreenKey = Key('__refcadastraleViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<RefcadastraleBloc>(
          create: (context) => RefcadastraleBloc(refcadastraleRepository: RefcadastraleRepository())
            ..add(InitRefcadastraleList()),
          child: RefcadastraleListScreen());
    },
    create: (context) {
      return BlocProvider<RefcadastraleBloc>(
          create: (context) => RefcadastraleBloc(refcadastraleRepository: RefcadastraleRepository()),
          child: RefcadastraleUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<RefcadastraleBloc>(
          create: (context) => RefcadastraleBloc(refcadastraleRepository: RefcadastraleRepository())
            ..add(LoadRefcadastraleByIdForEdit(id: arguments.id)),
          child: RefcadastraleUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<RefcadastraleBloc>(
          create: (context) => RefcadastraleBloc(refcadastraleRepository: RefcadastraleRepository())
            ..add(LoadRefcadastraleByIdForView(id: arguments.id)),
          child: RefcadastraleViewScreen());
    },
  };
}
