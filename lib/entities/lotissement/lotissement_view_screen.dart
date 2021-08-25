import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/lotissement/bloc/lotissement_bloc.dart';
import 'package:sunufoncier/entities/lotissement/lotissement_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'lotissement_route.dart';

class LotissementViewScreen extends StatelessWidget {
  LotissementViewScreen({Key? key}) : super(key: LotissementRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Lotissements View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<LotissementBloc, LotissementState>(
              buildWhen: (previous, current) => previous.loadedLotissement != current.loadedLotissement,
              builder: (context, state) {
                return Visibility(
                  visible: state.lotissementStatusUI == LotissementStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    lotissementCard(state.loadedLotissement, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, LotissementRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget lotissementCard(Lotissement lotissement, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + lotissement.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + lotissement.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + lotissement.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
