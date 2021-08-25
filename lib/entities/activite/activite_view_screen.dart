import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/activite/bloc/activite_bloc.dart';
import 'package:sunufoncier/entities/activite/activite_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'activite_route.dart';

class ActiviteViewScreen extends StatelessWidget {
  ActiviteViewScreen({Key? key}) : super(key: ActiviteRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Activites View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ActiviteBloc, ActiviteState>(
              buildWhen: (previous, current) => previous.loadedActivite != current.loadedActivite,
              builder: (context, state) {
                return Visibility(
                  visible: state.activiteStatusUI == ActiviteStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    activiteCard(state.loadedActivite, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ActiviteRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget activiteCard(Activite activite, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + activite.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + activite.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + activite.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
