import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/arrondissement/bloc/arrondissement_bloc.dart';
import 'package:sunufoncier/entities/arrondissement/arrondissement_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'arrondissement_route.dart';

class ArrondissementListScreen extends StatelessWidget {
    ArrondissementListScreen({Key? key}) : super(key: ArrondissementRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<ArrondissementBloc, ArrondissementState>(
      listener: (context, state) {
        if(state.deleteStatus == ArrondissementDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Arrondissement deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Arrondissements List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ArrondissementBloc, ArrondissementState>(
              buildWhen: (previous, current) => previous.arrondissements != current.arrondissements,
              builder: (context, state) {
                return Visibility(
                  visible: state.arrondissementStatusUI == ArrondissementStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Arrondissement arrondissement in state.arrondissements) arrondissementCard(arrondissement, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ArrondissementRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget arrondissementCard(Arrondissement arrondissement, BuildContext context) {
    ArrondissementBloc arrondissementBloc = BlocProvider.of<ArrondissementBloc>(context);
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
                  title: Text('Code : ${arrondissement.code.toString()}'),
                  subtitle: Text('Libelle : ${arrondissement.libelle.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, ArrondissementRoutes.edit,
                            arguments: EntityArguments(arrondissement.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              arrondissementBloc, context, arrondissement.id);
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
                  context, ArrondissementRoutes.view,
                  arguments: EntityArguments(arrondissement.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(ArrondissementBloc arrondissementBloc, BuildContext context, int? id) {
    return BlocProvider<ArrondissementBloc>.value(
      value: arrondissementBloc,
      child: AlertDialog(
        title: new Text('Delete Arrondissements'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              arrondissementBloc.add(DeleteArrondissementById(id: id));
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
