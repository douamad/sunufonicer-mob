import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/categorie_batie/bloc/categorie_batie_bloc.dart';
import 'package:sunufoncier/entities/categorie_batie/categorie_batie_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'categorie_batie_route.dart';

class CategorieBatieListScreen extends StatelessWidget {
    CategorieBatieListScreen({Key? key}) : super(key: CategorieBatieRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<CategorieBatieBloc, CategorieBatieState>(
      listener: (context, state) {
        if(state.deleteStatus == CategorieBatieDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('CategorieBatie deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('CategorieBaties List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<CategorieBatieBloc, CategorieBatieState>(
              buildWhen: (previous, current) => previous.categorieBaties != current.categorieBaties,
              builder: (context, state) {
                return Visibility(
                  visible: state.categorieBatieStatusUI == CategorieBatieStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (CategorieBatie categorieBatie in state.categorieBaties) categorieBatieCard(categorieBatie, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, CategorieBatieRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget categorieBatieCard(CategorieBatie categorieBatie, BuildContext context) {
    CategorieBatieBloc categorieBatieBloc = BlocProvider.of<CategorieBatieBloc>(context);
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
                  title: Text('Libelle : ${categorieBatie.libelle.toString()}'),
                  subtitle: Text('Prix Metre Care : ${categorieBatie.prixMetreCare.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, CategorieBatieRoutes.edit,
                            arguments: EntityArguments(categorieBatie.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              categorieBatieBloc, context, categorieBatie.id);
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
                  context, CategorieBatieRoutes.view,
                  arguments: EntityArguments(categorieBatie.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(CategorieBatieBloc categorieBatieBloc, BuildContext context, int? id) {
    return BlocProvider<CategorieBatieBloc>.value(
      value: categorieBatieBloc,
      child: AlertDialog(
        title: new Text('Delete CategorieBaties'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              categorieBatieBloc.add(DeleteCategorieBatieById(id: id));
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
