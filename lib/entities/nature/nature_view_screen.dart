import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/nature/bloc/nature_bloc.dart';
import 'package:sunufoncier/entities/nature/nature_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'nature_route.dart';

class NatureViewScreen extends StatelessWidget {
  NatureViewScreen({Key? key}) : super(key: NatureRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Natures View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<NatureBloc, NatureState>(
              buildWhen: (previous, current) => previous.loadedNature != current.loadedNature,
              builder: (context, state) {
                return Visibility(
                  visible: state.natureStatusUI == NatureStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    natureCard(state.loadedNature, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, NatureRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget natureCard(Nature nature, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + nature.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + nature.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + nature.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
