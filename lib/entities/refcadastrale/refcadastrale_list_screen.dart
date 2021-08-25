import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/refcadastrale/bloc/refcadastrale_bloc.dart';
import 'package:sunufoncier/entities/refcadastrale/refcadastrale_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'refcadastrale_route.dart';

class RefcadastraleListScreen extends StatelessWidget {
    RefcadastraleListScreen({Key? key}) : super(key: RefcadastraleRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<RefcadastraleBloc, RefcadastraleState>(
      listener: (context, state) {
        if(state.deleteStatus == RefcadastraleDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Refcadastrale deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Refcadastrales List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
              buildWhen: (previous, current) => previous.refcadastrales != current.refcadastrales,
              builder: (context, state) {
                return Visibility(
                  visible: state.refcadastraleStatusUI == RefcadastraleStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Refcadastrale refcadastrale in state.refcadastrales) refcadastraleCard(refcadastrale, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RefcadastraleRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget refcadastraleCard(Refcadastrale refcadastrale, BuildContext context) {
    RefcadastraleBloc refcadastraleBloc = BlocProvider.of<RefcadastraleBloc>(context);
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
                  title: Text('Code Section : ${refcadastrale.codeSection.toString()}'),
                  subtitle: Text('Code Parcelle : ${refcadastrale.codeParcelle.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, RefcadastraleRoutes.edit,
                            arguments: EntityArguments(refcadastrale.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              refcadastraleBloc, context, refcadastrale.id);
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
                  context, RefcadastraleRoutes.view,
                  arguments: EntityArguments(refcadastrale.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(RefcadastraleBloc refcadastraleBloc, BuildContext context, int? id) {
    return BlocProvider<RefcadastraleBloc>.value(
      value: refcadastraleBloc,
      child: AlertDialog(
        title: new Text('Delete Refcadastrales'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              refcadastraleBloc.add(DeleteRefcadastraleById(id: id));
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
