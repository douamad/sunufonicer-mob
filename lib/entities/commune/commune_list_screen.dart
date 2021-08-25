import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/commune/bloc/commune_bloc.dart';
import 'package:sunufoncier/entities/commune/commune_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'commune_route.dart';

class CommuneListScreen extends StatelessWidget {
    CommuneListScreen({Key? key}) : super(key: CommuneRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<CommuneBloc, CommuneState>(
      listener: (context, state) {
        if(state.deleteStatus == CommuneDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Commune deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Communes List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<CommuneBloc, CommuneState>(
              buildWhen: (previous, current) => previous.communes != current.communes,
              builder: (context, state) {
                return Visibility(
                  visible: state.communeStatusUI == CommuneStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Commune commune in state.communes) communeCard(commune, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, CommuneRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget communeCard(Commune commune, BuildContext context) {
    CommuneBloc communeBloc = BlocProvider.of<CommuneBloc>(context);
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
                  title: Text('Code : ${commune.code.toString()}'),
                  subtitle: Text('Libelle : ${commune.libelle.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, CommuneRoutes.edit,
                            arguments: EntityArguments(commune.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              communeBloc, context, commune.id);
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
                  context, CommuneRoutes.view,
                  arguments: EntityArguments(commune.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(CommuneBloc communeBloc, BuildContext context, int? id) {
    return BlocProvider<CommuneBloc>.value(
      value: communeBloc,
      child: AlertDialog(
        title: new Text('Delete Communes'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              communeBloc.add(DeleteCommuneById(id: id));
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
