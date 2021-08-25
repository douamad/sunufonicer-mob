import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/categorie_cloture/bloc/categorie_cloture_bloc.dart';
import 'package:sunufoncier/entities/categorie_cloture/categorie_cloture_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'categorie_cloture_route.dart';

class CategorieClotureViewScreen extends StatelessWidget {
  CategorieClotureViewScreen({Key? key}) : super(key: CategorieClotureRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('CategorieClotures View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<CategorieClotureBloc, CategorieClotureState>(
              buildWhen: (previous, current) => previous.loadedCategorieCloture != current.loadedCategorieCloture,
              builder: (context, state) {
                return Visibility(
                  visible: state.categorieClotureStatusUI == CategorieClotureStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    categorieClotureCard(state.loadedCategorieCloture, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, CategorieClotureRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget categorieClotureCard(CategorieCloture categorieCloture, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + categorieCloture.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + categorieCloture.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Prix Metre Care : ' + categorieCloture.prixMetreCare.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
