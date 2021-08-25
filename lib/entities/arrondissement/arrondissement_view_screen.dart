import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/arrondissement/bloc/arrondissement_bloc.dart';
import 'package:sunufoncier/entities/arrondissement/arrondissement_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'arrondissement_route.dart';

class ArrondissementViewScreen extends StatelessWidget {
  ArrondissementViewScreen({Key? key}) : super(key: ArrondissementRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Arrondissements View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ArrondissementBloc, ArrondissementState>(
              buildWhen: (previous, current) => previous.loadedArrondissement != current.loadedArrondissement,
              builder: (context, state) {
                return Visibility(
                  visible: state.arrondissementStatusUI == ArrondissementStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    arrondissementCard(state.loadedArrondissement, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ArrondissementRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget arrondissementCard(Arrondissement arrondissement, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + arrondissement.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + arrondissement.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + arrondissement.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
