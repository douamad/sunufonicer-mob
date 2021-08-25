
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';

import 'bloc/usage_bloc.dart';
import 'usage_list_screen.dart';
import 'usage_repository.dart';
import 'usage_update_screen.dart';
import 'usage_view_screen.dart';

class UsageRoutes {
  static final list = '/entities/usage-list';
  static final create = '/entities/usage-create';
  static final edit = '/entities/usage-edit';
  static final view = '/entities/usage-view';

  static const listScreenKey = Key('__usageListScreen__');
  static const createScreenKey = Key('__usageCreateScreen__');
  static const editScreenKey = Key('__usageEditScreen__');
  static const viewScreenKey = Key('__usageViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<UsageBloc>(
          create: (context) => UsageBloc(usageRepository: UsageRepository())
            ..add(InitUsageList()),
          child: UsageListScreen());
    },
    create: (context) {
      return BlocProvider<UsageBloc>(
          create: (context) => UsageBloc(usageRepository: UsageRepository()),
          child: UsageUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<UsageBloc>(
          create: (context) => UsageBloc(usageRepository: UsageRepository())
            ..add(LoadUsageByIdForEdit(id: arguments.id)),
          child: UsageUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<UsageBloc>(
          create: (context) => UsageBloc(usageRepository: UsageRepository())
            ..add(LoadUsageByIdForView(id: arguments.id)),
          child: UsageViewScreen());
    },
  };
}
