import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/routes.dart';
import 'package:sunufoncier/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:flutter/material.dart';

// jhipster-merlin-needle-menu-import-entry-add

class SunufoncierDrawer extends StatelessWidget {
   SunufoncierDrawer({Key? key}) : super(key: key);

   static final double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DrawerBloc, DrawerState>(
      listener: (context, state) {
        if(state.isLogout) {
          Navigator.popUntil(context, ModalRoute.withName(SunufoncierRoutes.login));
          Navigator.pushNamed(context, SunufoncierRoutes.login);
        }
      },
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            header(context),
            ListTile(
              leading: Icon(Icons.home, size: iconSize,),
              title: Text('Home'),
              onTap: () => Navigator.pushNamed(context, SunufoncierRoutes.main),
            ),
            ListTile(
              leading: Icon(Icons.settings, size: iconSize,),
              title: Text('Settings'),
              onTap: () => Navigator.pushNamed(context, SunufoncierRoutes.settings),
            ),
            ExpansionTile(
              leading: Icon(Icons.exit_to_app, size: iconSize,),
              title: Text('Region'),
              children: <Widget>[ 
                ListTile(
                  leading: Icon(Icons.settings, size: iconSize,),
                  title: Text('List'),
                  onTap: () => Navigator.pushNamed(context, SunufoncierRoutes.region,)
                )
              ],
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, size: iconSize,),
          title: Text('Sign out'),
              onTap: () => context.read<DrawerBloc>().add(Logout())
            ),
            Divider(thickness: 2),
            // jhipster-merlin-needle-menu-entry-add
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Text('Menu',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
