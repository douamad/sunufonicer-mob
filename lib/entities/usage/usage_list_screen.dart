import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/usage/bloc/usage_bloc.dart';
import 'package:sunufoncier/entities/usage/usage_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'usage_route.dart';

class UsageListScreen extends StatelessWidget {
    UsageListScreen({Key? key}) : super(key: UsageRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<UsageBloc, UsageState>(
      listener: (context, state) {
        if(state.deleteStatus == UsageDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Usage deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Usages List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<UsageBloc, UsageState>(
              buildWhen: (previous, current) => previous.usages != current.usages,
              builder: (context, state) {
                return Visibility(
                  visible: state.usageStatusUI == UsageStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Usage usage in state.usages) usageCard(usage, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, UsageRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget usageCard(Usage usage, BuildContext context) {
    UsageBloc usageBloc = BlocProvider.of<UsageBloc>(context);
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 60.0,
                color: Theme.of(context).primaryColor,
              ),
                  title: Text('Code : ${usage.code.toString()}'),
                  subtitle: Text('Libelle : ${usage.libelle.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, UsageRoutes.edit,
                            arguments: EntityArguments(usage.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              usageBloc, context, usage.id);
                          },
                        );
                    }
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    DropdownMenuItem<String>(
                        value: 'Delete', child: Text('Delete'))
                  ]),
              selected: false,
              onTap: () => Navigator.pushNamed(
                  context, UsageRoutes.view,
                  arguments: EntityArguments(usage.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(UsageBloc usageBloc, BuildContext context, int? id) {
    return BlocProvider<UsageBloc>.value(
      value: usageBloc,
      child: AlertDialog(
        title: new Text('Delete Usages'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              usageBloc.add(DeleteUsageById(id: id));
            },
          ),
          new TextButton(
            child: new Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

}
