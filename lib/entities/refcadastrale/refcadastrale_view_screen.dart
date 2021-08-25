import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/refcadastrale/bloc/refcadastrale_bloc.dart';
import 'package:sunufoncier/entities/refcadastrale/refcadastrale_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'refcadastrale_route.dart';

class RefcadastraleViewScreen extends StatelessWidget {
  RefcadastraleViewScreen({Key? key}) : super(key: RefcadastraleRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Refcadastrales View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<RefcadastraleBloc, RefcadastraleState>(
              buildWhen: (previous, current) => previous.loadedRefcadastrale != current.loadedRefcadastrale,
              builder: (context, state) {
                return Visibility(
                  visible: state.refcadastraleStatusUI == RefcadastraleStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    refcadastraleCard(state.loadedRefcadastrale, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RefcadastraleRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget refcadastraleCard(Refcadastrale refcadastrale, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + refcadastrale.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code Section : ' + refcadastrale.codeSection.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code Parcelle : ' + refcadastrale.codeParcelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Nicad : ' + refcadastrale.nicad.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Superfici : ' + refcadastrale.superfici.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Titre Mere : ' + refcadastrale.titreMere.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Titre Cree : ' + refcadastrale.titreCree.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Numero Requisition : ' + refcadastrale.numeroRequisition.toString(), style: Theme.of(context).textTheme.bodyText1,),
              Text('Date Bornage : ' + (refcadastrale.dateBornage != null ? DateFormat.yMMMMd('en').format(refcadastrale.dateBornage!) : ''), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
