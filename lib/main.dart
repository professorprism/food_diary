import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/f_d_state.dart';

void main() async
{ WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build
  ( storageDirectory: await getApplicationDocumentsDirectory()
  );
  runApp(const FoodDiary());
}

class FoodDiary extends StatelessWidget
{ static const String header = "Food Diary";

  const FoodDiary({super.key});

  @override
  Widget build(BuildContext context) 
  { return MaterialApp
    ( title: header,
      //home: BlocProvider<FDCubit>
      home: BlocProvider<FDBloc>
      ( 
        // create: (context) => FDCubit(),
        create: (context) => FDBloc(),
        // child: BlocBuilder<FDCubit,FDState>
        child: BlocBuilder<FDBloc,FDState> 
        ( builder: (context,state)
          { 
            // FDCubit fdc = BlocProvider.of<FDCubit>(context>;
            FDBloc fdc =  BlocProvider.of<FDBloc>(context);
            return  Splash(title: header, fdc:fdc);
          },
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget 
{ final String title;
  // final FDCubit fdc;
  final FDBloc fdc; 
  const Splash({super.key, required this.title, required this.fdc});

  @override
  Widget build(BuildContext context) 
  { 
    // FDCubit fdc = BlocProvider.of<FDCubit>(context>;
    FDBloc fdc = BlocProvider.of<FDBloc>(context);
    FDState fds = fdc.state;
    TextEditingController tec = TextEditingController();

    return Scaffold
    ( appBar: AppBar(  title: Text(title),),
      body: Column
      ( children: 
        [ Text(fds.food),
          SizedBox
          ( height:50, width:300,
            child: TextField(controller: tec ),
          ),
          ElevatedButton
          ( onPressed: ()
            { 
              //fdc.setFood(tec.text); 
              context.read<FDBloc>().add(SetFoodEvent(tec.text));
            },
            child: Text("save"),
          ),
        ],
      ),
    );
  }     
}
