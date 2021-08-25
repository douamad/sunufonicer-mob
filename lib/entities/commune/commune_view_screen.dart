import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/commune/bloc/commune_bloc.dart';
import 'package:sunufoncier/entities/commune/commune_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'commune_route.dart';

class CommuneViewScreen extends StatelessWidget {
  CommuneViewScreen({Key? key}) : super(key: CommuneRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Communes View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<CommuneBloc, CommuneState>(
              buildWhen: (previous, current) => previous.loadedCommune != current.loadedCommune,
              builder: (context, state) {
                return Visibility(
                  visible: state.communeStatusUI == CommuneStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    communeCard(state.loadedCommune, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, CommuneRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget communeCard(Commune commune, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + commune.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + commune.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + commune.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
