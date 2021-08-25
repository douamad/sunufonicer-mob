import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/departement/bloc/departement_bloc.dart';
import 'package:sunufoncier/entities/departement/departement_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'departement_route.dart';

class DepartementViewScreen extends StatelessWidget {
  DepartementViewScreen({Key? key}) : super(key: DepartementRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Departements View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DepartementBloc, DepartementState>(
              buildWhen: (previous, current) => previous.loadedDepartement != current.loadedDepartement,
              builder: (context, state) {
                return Visibility(
                  visible: state.departementStatusUI == DepartementStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    departementCard(state.loadedDepartement, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DepartementRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget departementCard(Departement departement, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + departement.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + departement.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + departement.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
