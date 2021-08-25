import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/entities/categorie_cloture/bloc/categorie_cloture_bloc.dart';
import 'package:sunufoncier/entities/categorie_cloture/categorie_cloture_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:sunufoncier/shared/widgets/drawer/drawer_widget.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'package:sunufoncier/shared/models/entity_arguments.dart';
import 'categorie_cloture_route.dart';

class CategorieClotureListScreen extends StatelessWidget {
    CategorieClotureListScreen({Key? key}) : super(key: CategorieClotureRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<CategorieClotureBloc, CategorieClotureState>(
      listener: (context, state) {
        if(state.deleteStatus == CategorieClotureDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('CategorieCloture deleted successfuly')
          ));
        }
      },
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('CategorieClotures List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<CategorieClotureBloc, CategorieClotureState>(
              buildWhen: (previous, current) => previous.categorieClotures != current.categorieClotures,
              builder: (context, state) {
                return Visibility(
                  visible: state.categorieClotureStatusUI == CategorieClotureStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (CategorieCloture categorieCloture in state.categorieClotures) categorieClotureCard(categorieCloture, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: SunufoncierDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, CategorieClotureRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      ),
    );
  }

  Widget categorieClotureCard(CategorieCloture categorieCloture, BuildContext context) {
    CategorieClotureBloc categorieClotureBloc = BlocProvider.of<CategorieClotureBloc>(context);
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
                  title: Text('Libelle : ${categorieCloture.libelle.toString()}'),
                  subtitle: Text('Prix Metre Care : ${categorieCloture.prixMetreCare.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, CategorieClotureRoutes.edit,
                            arguments: EntityArguments(categorieCloture.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              categorieClotureBloc, context, categorieCloture.id);
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
                  context, CategorieClotureRoutes.view,
                  arguments: EntityArguments(categorieCloture.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(CategorieClotureBloc categorieClotureBloc, BuildContext context, int? id) {
    return BlocProvider<CategorieClotureBloc>.value(
      value: categorieClotureBloc,
      child: AlertDialog(
        title: new Text('Delete CategorieClotures'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              categorieClotureBloc.add(DeleteCategorieClotureById(id: id));
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
