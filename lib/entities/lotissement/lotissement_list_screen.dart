import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/lotissement/bloc/lotissement_bloc.dart';
import 'package:sunufoncier/entities/lotissement/lotissement_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'lotissement_route.dart';

class LotissementListScreen extends StatelessWidget {
    LotissementListScreen({Key? key}) : super(key: LotissementRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<LotissementBloc, LotissementState>(
      listener: (context, state) {
        if(state.deleteStatus == LotissementDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Lotissement deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Lotissements List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<LotissementBloc, LotissementState>(
              buildWhen: (previous, current) => previous.lotissements != current.lotissements,
              builder: (context, state) {
                return Visibility(
                  visible: state.lotissementStatusUI == LotissementStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Lotissement lotissement in state.lotissements) lotissementCard(lotissement, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, LotissementRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget lotissementCard(Lotissement lotissement, BuildContext context) {
    LotissementBloc lotissementBloc = BlocProvider.of<LotissementBloc>(context);
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
                  title: Text('Code : ${lotissement.code.toString()}'),
                  subtitle: Text('Libelle : ${lotissement.libelle.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, LotissementRoutes.edit,
                            arguments: EntityArguments(lotissement.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              lotissementBloc, context, lotissement.id);
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
                  context, LotissementRoutes.view,
                  arguments: EntityArguments(lotissement.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(LotissementBloc lotissementBloc, BuildContext context, int? id) {
    return BlocProvider<LotissementBloc>.value(
      value: lotissementBloc,
      child: AlertDialog(
        title: new Text('Delete Lotissements'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              lotissementBloc.add(DeleteLotissementById(id: id));
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
