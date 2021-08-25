import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/dossier/bloc/dossier_bloc.dart';
import 'package:sunufoncier/entities/dossier/dossier_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'dossier_route.dart';

class DossierViewScreen extends StatelessWidget {
  DossierViewScreen({Key? key}) : super(key: DossierRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Dossiers View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DossierBloc, DossierState>(
              buildWhen: (previous, current) => previous.loadedDossier != current.loadedDossier,
              builder: (context, state) {
                return Visibility(
                  visible: state.dossierStatusUI == DossierStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    dossierCard(state.loadedDossier, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DossierRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget dossierCard(Dossier dossier, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + dossier.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Numero : ' + dossier.numero.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Montant Loyer : ' + dossier.montantLoyer.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Superficie Batie : ' + dossier.superficieBatie.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Coeff Correctif Batie : ' + dossier.coeffCorrectifBatie.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valeur Batie : ' + dossier.valeurBatie.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Lineaire Cloture : ' + dossier.lineaireCloture.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Coeff Cloture : ' + dossier.coeffCloture.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valeur Cloture : ' + dossier.valeurCloture.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Amenagement Spaciaux : ' + dossier.amenagementSpaciaux.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valeur Amenagement : ' + dossier.valeurAmenagement.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valeur Venale : ' + dossier.valeurVenale.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valeur Locativ : ' + dossier.valeurLocativ.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
