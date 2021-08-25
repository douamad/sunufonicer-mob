import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/representant/bloc/representant_bloc.dart';
import 'package:sunufoncier/entities/representant/representant_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'representant_route.dart';

class RepresentantViewScreen extends StatelessWidget {
  RepresentantViewScreen({Key? key}) : super(key: RepresentantRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Representants View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<RepresentantBloc, RepresentantState>(
              buildWhen: (previous, current) => previous.loadedRepresentant != current.loadedRepresentant,
              builder: (context, state) {
                return Visibility(
                  visible: state.representantStatusUI == RepresentantStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    representantCard(state.loadedRepresentant, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RepresentantRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget representantCard(Representant representant, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + representant.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Prenom : ' + representant.prenom.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Nom : ' + representant.nom.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Actif : ' + representant.actif.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Raison Social : ' + representant.raisonSocial.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Personne Morale : ' + representant.personneMorale.toString(), style: Theme.of(context).textTheme.bodyText1,),
              Text('Date Naiss : ' + (representant.dateNaiss != null ? DateFormat.yMMMMd('en').format(representant.dateNaiss!) : ''), style: Theme.of(context).textTheme.bodyText1,),
                Text('Lieu Naissance : ' + representant.lieuNaissance.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Num CNI : ' + representant.numCNI.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Ninea : ' + representant.ninea.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Adresse : ' + representant.adresse.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Email : ' + representant.email.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Telephone : ' + representant.telephone.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Telephone 2 : ' + representant.telephone2.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Telephone 3 : ' + representant.telephone3.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Aquisition : ' + representant.aquisition.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Statut Persone Structure : ' + representant.statutPersoneStructure.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Type Structure : ' + representant.typeStructure.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
