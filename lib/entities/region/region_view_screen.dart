import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/entities/region/bloc/region_bloc.dart';
import 'package:sunufoncier/entities/region/region_model.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/widgets/loading_indicator_widget.dart';
import 'region_route.dart';

class RegionViewScreen extends StatelessWidget {
  RegionViewScreen({Key? key}) : super(key: RegionRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Regions View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<RegionBloc, RegionState>(
              buildWhen: (previous, current) => previous.loadedRegion != current.loadedRegion,
              builder: (context, state) {
                return Visibility(
                  visible: state.regionStatusUI == RegionStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    regionCard(state.loadedRegion, context)
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, RegionRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget regionCard(Region region, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + region.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Code : ' + region.code.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Libelle : ' + region.libelle.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
