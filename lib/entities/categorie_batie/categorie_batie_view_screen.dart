import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/categorie_batie/bloc/categorie_batie_bloc.dart';
import 'package:sunufoncier/entities/categorie_batie/categorie_batie_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'categorie_batie_route.dart';

class CategorieBatieViewScreen extends StatelessWidget {
  CategorieBatieViewScreen({Key? key}) : super(key: CategorieBatieRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('CategorieBaties View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<CategorieBatieBloc, CategorieBatieState>(
              buildWhen: (previous, current) => previous.loadedCategorieBatie != current.loadedCategorieBatie,
              builder: (context, state) {
                return Visibility(
                  visible: state.categorieBatieStatusUI == CategorieBatieStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    categorieBatieCard(state.loadedCategorieBatie, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, CategorieBatieRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget categorieBatieCard(CategorieBatie categorieBatie, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + categorieBatie.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + categorieBatie.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Prix Metre Care : ' + categorieBatie.prixMetreCare.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
