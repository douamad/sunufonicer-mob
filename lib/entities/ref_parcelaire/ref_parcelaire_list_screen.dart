import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/ref_parcelaire/bloc/ref_parcelaire_bloc.dart';
import 'package:sunufoncier/entities/ref_parcelaire/ref_parcelaire_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'ref_parcelaire_route.dart';

class RefParcelaireListScreen extends StatelessWidget {
    RefParcelaireListScreen({Key? key}) : super(key: RefParcelaireRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<RefParcelaireBloc, RefParcelaireState>(
      listener: (context, state) {
        if(state.deleteStatus == RefParcelaireDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('RefParcelaire deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('RefParcelaires List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<RefParcelaireBloc, RefParcelaireState>(
              buildWhen: (previous, current) => previous.refParcelaires != current.refParcelaires,
              builder: (context, state) {
                return Visibility(
                  visible: state.refParcelaireStatusUI == RefParcelaireStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (RefParcelaire refParcelaire in state.refParcelaires) refParcelaireCard(refParcelaire, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RefParcelaireRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget refParcelaireCard(RefParcelaire refParcelaire, BuildContext context) {
    RefParcelaireBloc refParcelaireBloc = BlocProvider.of<RefParcelaireBloc>(context);
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
                  title: Text('Numero Parcelle : ${refParcelaire.numeroParcelle.toString()}'),
                  subtitle: Text('Nature Parcelle : ${refParcelaire.natureParcelle.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, RefParcelaireRoutes.edit,
                            arguments: EntityArguments(refParcelaire.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              refParcelaireBloc, context, refParcelaire.id);
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
                  context, RefParcelaireRoutes.view,
                  arguments: EntityArguments(refParcelaire.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(RefParcelaireBloc refParcelaireBloc, BuildContext context, int? id) {
    return BlocProvider<RefParcelaireBloc>.value(
      value: refParcelaireBloc,
      child: AlertDialog(
        title: new Text('Delete RefParcelaires'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              refParcelaireBloc.add(DeleteRefParcelaireById(id: id));
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
