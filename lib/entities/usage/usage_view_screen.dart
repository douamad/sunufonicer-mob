import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/usage/bloc/usage_bloc.dart';
import 'package:sunufoncier/entities/usage/usage_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'usage_route.dart';

class UsageViewScreen extends StatelessWidget {
  UsageViewScreen({Key? key}) : super(key: UsageRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Usages View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<UsageBloc, UsageState>(
              buildWhen: (previous, current) => previous.loadedUsage != current.loadedUsage,
              builder: (context, state) {
                return Visibility(
                  visible: state.usageStatusUI == UsageStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    usageCard(state.loadedUsage, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, UsageRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget usageCard(Usage usage, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + usage.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + usage.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + usage.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
