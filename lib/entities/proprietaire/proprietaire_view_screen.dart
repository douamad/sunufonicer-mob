import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/proprietaire/bloc/proprietaire_bloc.dart';
import 'package:sunufoncier/entities/proprietaire/proprietaire_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'proprietaire_route.dart';

class ProprietaireViewScreen extends StatelessWidget {
  ProprietaireViewScreen({Key? key}) : super(key: ProprietaireRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Proprietaires View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ProprietaireBloc, ProprietaireState>(
              buildWhen: (previous, current) => previous.loadedProprietaire != current.loadedProprietaire,
              builder: (context, state) {
                return Visibility(
                  visible: state.proprietaireStatusUI == ProprietaireStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    proprietaireCard(state.loadedProprietaire, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ProprietaireRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget proprietaireCard(Proprietaire proprietaire, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + proprietaire.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Prenom : ' + proprietaire.prenom.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Nom : ' + proprietaire.nom.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Situation : ' + proprietaire.situation.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Raison Social : ' + proprietaire.raisonSocial.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Personne Morale : ' + proprietaire.personneMorale.toString(), style: Theme.of(context).textTheme.bodyText1,),
              Text('Date Naiss : ' + (proprietaire.dateNaiss != null ? DateFormat.yMMMMd('en').format(proprietaire.dateNaiss!) : ''), style: Theme.of(context).textTheme.bodyText1,),
                Text('Lieu Naissance : ' + proprietaire.lieuNaissance.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Num CNI : ' + proprietaire.numCNI.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Ninea : ' + proprietaire.ninea.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Adresse : ' + proprietaire.adresse.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Email : ' + proprietaire.email.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Telephone : ' + proprietaire.telephone.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Telephone 2 : ' + proprietaire.telephone2.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Telephone 3 : ' + proprietaire.telephone3.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Aquisition : ' + proprietaire.aquisition.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Statut Persone Structure : ' + proprietaire.statutPersoneStructure.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Type Structure : ' + proprietaire.typeStructure.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
