
import 'dart:convert';
// import "package:flutter_bloc/flutter_bloc.dart";

import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';


class FDState 
{ 
  String food;

  FDState(this.food);

  // turns the object into a map
  Map<String,dynamic> toMap()
  { return
    { 'food' : food ,
    };
  } 
  
  // turn a map back into an object
  factory FDState.fromMap(Map<String,dynamic> map)
  {
    return FDState( map['food'] );
  }

  // turns the object into JSON.  Does this by 
  // call toMap and then encode() ing the map.
  String toJson() => json.encode(toMap());

  // turns Json back into an objevct.  
  factory FDState.fromJson( String source) 
  => FDState.fromMap( json.decode(source));
   
}

class SetFoodEvent
{ String food;
  SetFoodEvent(this.food);

}

class FDBloc extends HydratedBloc<SetFoodEvent, FDState>
{
  FDBloc() : super( FDState("plum") )
  {
    on<SetFoodEvent> ( (event,emit) => emit(FDState(event.food))  );
  }

  // void setFood(String f ) { emit( FDState(f)); }
 

  // converts the map form of FDState into an object.
  // should have been called fromMap, as the Hydrated stuff
  // will have already converted it from JSON to a map 
  // (after fetching it from storage).
  @override
  FDState fromJson( Map<String,dynamic> map)
  { return FDState.fromMap(map); }

  // This is called on s AFTER emit(s).  Every time there is a new
  // state, this function converts it to a Map and the Hydrated
  // stuff takes it from there and stores is.  
  @override
  Map<String,dynamic> toJson( FDState state)
  { return state.toMap(); }
}

class FDCubit extends Cubit<FDState> with HydratedMixin
{
  FDCubit() : super( FDState("banana") );

  void setFood(String f ) { emit( FDState(f)); }

  // converts the map form of FDState into an object.
  // should have been called fromMap, as the Hydrated stuff
  // will have already converted it from JSON to a map 
  // (after fetching it from storage).
  @override
  FDState fromJson( Map<String,dynamic> map)
  { return FDState.fromMap(map); }

  // This is called on s AFTER emit(s).  Every time there is a new
  // state, this function converts it to a Map and the Hydrated
  // stuff takes it from there and stores is.  
  @override
  Map<String,dynamic> toJson( FDState state)
  { return state.toMap(); }
}