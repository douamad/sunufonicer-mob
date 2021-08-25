import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/quartier/bloc/quartier_bloc.dart';
import 'package:sunufoncier/entities/quartier/quartier_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'quartier_route.dart';

class QuartierViewScreen extends StatelessWidget {
  QuartierViewScreen({Key? key}) : super(key: QuartierRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Quartiers View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<QuartierBloc, QuartierState>(
              buildWhen: (previous, current) => previous.loadedQuartier != current.loadedQuartier,
              builder: (context, state) {
                return Visibility(
                  visible: state.quartierStatusUI == QuartierStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    quartierCard(state.loadedQuartier, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, QuartierRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget quartierCard(Quartier quartier, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + quartier.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + quartier.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + quartier.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
