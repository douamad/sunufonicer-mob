import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/dossier/bloc/dossier_bloc.dart';
import 'package:sunufoncier/entities/dossier/dossier_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'dossier_route.dart';

class DossierListScreen extends StatelessWidget {
    DossierListScreen({Key? key}) : super(key: DossierRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<DossierBloc, DossierState>(
      listener: (context, state) {
        if(state.deleteStatus == DossierDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Dossier deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Dossiers List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DossierBloc, DossierState>(
              buildWhen: (previous, current) => previous.dossiers != current.dossiers,
              builder: (context, state) {
                return Visibility(
                  visible: state.dossierStatusUI == DossierStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Dossier dossier in state.dossiers) dossierCard(dossier, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DossierRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget dossierCard(Dossier dossier, BuildContext context) {
    DossierBloc dossierBloc = BlocProvider.of<DossierBloc>(context);
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
                  title: Text('Numero : ${dossier.numero.toString()}'),
                  subtitle: Text('Montant Loyer : ${dossier.montantLoyer.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, DossierRoutes.edit,
                            arguments: EntityArguments(dossier.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              dossierBloc, context, dossier.id);
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
                  context, DossierRoutes.view,
                  arguments: EntityArguments(dossier.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(DossierBloc dossierBloc, BuildContext context, int? id) {
    return BlocProvider<DossierBloc>.value(
      value: dossierBloc,
      child: AlertDialog(
        title: new Text('Delete Dossiers'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              dossierBloc.add(DeleteDossierById(id: id));
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
