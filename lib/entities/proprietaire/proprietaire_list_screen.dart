import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/proprietaire/bloc/proprietaire_bloc.dart';
import 'package:sunufoncier/entities/proprietaire/proprietaire_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'proprietaire_route.dart';

class ProprietaireListScreen extends StatelessWidget {
    ProprietaireListScreen({Key? key}) : super(key: ProprietaireRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<ProprietaireBloc, ProprietaireState>(
      listener: (context, state) {
        if(state.deleteStatus == ProprietaireDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Proprietaire deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Proprietaires List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ProprietaireBloc, ProprietaireState>(
              buildWhen: (previous, current) => previous.proprietaires != current.proprietaires,
              builder: (context, state) {
                return Visibility(
                  visible: state.proprietaireStatusUI == ProprietaireStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Proprietaire proprietaire in state.proprietaires) proprietaireCard(proprietaire, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ProprietaireRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget proprietaireCard(Proprietaire proprietaire, BuildContext context) {
    ProprietaireBloc proprietaireBloc = BlocProvider.of<ProprietaireBloc>(context);
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
                  title: Text('Prenom : ${proprietaire.prenom.toString()}'),
                  subtitle: Text('Nom : ${proprietaire.nom.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, ProprietaireRoutes.edit,
                            arguments: EntityArguments(proprietaire.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              proprietaireBloc, context, proprietaire.id);
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
                  context, ProprietaireRoutes.view,
                  arguments: EntityArguments(proprietaire.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(ProprietaireBloc proprietaireBloc, BuildContext context, int? id) {
    return BlocProvider<ProprietaireBloc>.value(
      value: proprietaireBloc,
      child: AlertDialog(
        title: new Text('Delete Proprietaires'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              proprietaireBloc.add(DeleteProprietaireById(id: id));
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
