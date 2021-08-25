import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/ref_parcelaire/bloc/ref_parcelaire_bloc.dart';
import 'package:sunufoncier/entities/ref_parcelaire/ref_parcelaire_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'ref_parcelaire_route.dart';

class RefParcelaireViewScreen extends StatelessWidget {
  RefParcelaireViewScreen({Key? key}) : super(key: RefParcelaireRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('RefParcelaires View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<RefParcelaireBloc, RefParcelaireState>(
              buildWhen: (previous, current) => previous.loadedRefParcelaire != current.loadedRefParcelaire,
              builder: (context, state) {
                return Visibility(
                  visible: state.refParcelaireStatusUI == RefParcelaireStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    refParcelaireCard(state.loadedRefParcelaire, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RefParcelaireRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget refParcelaireCard(RefParcelaire refParcelaire, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + refParcelaire.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Numero Parcelle : ' + refParcelaire.numeroParcelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Nature Parcelle : ' + refParcelaire.natureParcelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
