import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/bloc/login_bloc.dart';
import 'package:sunufoncier/account/login/login_repository.dart';
import 'package:sunufoncier/account/register/bloc/register_bloc.dart';
import 'package:sunufoncier/account/settings/settings_screen.dart';
import 'package:sunufoncier/main/bloc/main_bloc.dart';
import 'package:sunufoncier/routes.dart';
import 'package:sunufoncier/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/shared/repository/account_repository.dart';
import 'package:sunufoncier/themes.dart';
import 'account/settings/bloc/settings_bloc.dart';

import 'account/login/login_screen.dart';
import 'account/register/register_screen.dart';


import 'entities/dossier/dossier_route.dart';
import 'entities/region/region_route.dart';
import 'entities/departement/departement_route.dart';
import 'entities/lotissement/lotissement_route.dart';
import 'entities/nature/nature_route.dart';
import 'entities/usage/usage_route.dart';
import 'entities/activite/activite_route.dart';
import 'entities/ref_parcelaire/ref_parcelaire_route.dart';
import 'entities/refcadastrale/refcadastrale_route.dart';
import 'entities/proprietaire/proprietaire_route.dart';
import 'entities/representant/representant_route.dart';
import 'entities/categorie_batie/categorie_batie_route.dart';
import 'entities/categorie_cloture/categorie_cloture_route.dart';
import 'entities/quartier/quartier_route.dart';
import 'entities/commune/commune_route.dart';
import 'entities/arrondissement/arrondissement_route.dart';
// jhipster-merlin-needle-import-add - JHipster will add new imports here

class SunufoncierApp extends StatelessWidget {
  const SunufoncierApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunufoncier app',
      theme: Themes.jhLight,
      routes: {
        SunufoncierRoutes.login: (context) {
          return BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(loginRepository: LoginRepository()),
              child: LoginScreen());
        },
        SunufoncierRoutes.register: (context) {
          return BlocProvider<RegisterBloc>(
              create: (context) => RegisterBloc(accountRepository: AccountRepository()),
              child: RegisterScreen());
        },
        SunufoncierRoutes.main: (context) {
          return BlocProvider<MainBloc>(
              create: (context) => MainBloc(accountRepository: AccountRepository())
                ..add(Init()),
              child: MainScreen());
        },
        SunufoncierRoutes.settings: (context) {
          return BlocProvider<SettingsBloc>(
              create: (context) => SettingsBloc(accountRepository: AccountRepository())
                ..add(LoadCurrentUser()),
              child: SettingsScreen());
        },
        ...DossierRoutes.map,
        ...RegionRoutes.map,
        ...DepartementRoutes.map,
        ...LotissementRoutes.map,
        ...NatureRoutes.map,
        ...UsageRoutes.map,
        ...ActiviteRoutes.map,
        ...RefParcelaireRoutes.map,
        ...RefcadastraleRoutes.map,
        ...ProprietaireRoutes.map,
        ...RepresentantRoutes.map,
        ...CategorieBatieRoutes.map,
        ...CategorieClotureRoutes.map,
        ...QuartierRoutes.map,
        ...CommuneRoutes.map,
        ...ArrondissementRoutes.map,
        // jhipster-merlin-needle-route-add - JHipster will add new routes here
      },
    );
  }
}
