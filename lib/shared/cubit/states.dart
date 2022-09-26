abstract class NewsStates {}

class InitialState extends NewsStates {}

class ChangeTapState extends NewsStates {}

class LoadingState extends NewsStates {}

class GetBusinessSuccessState extends NewsStates {}

class GetBusinessErrorState extends NewsStates {
  String error;

  GetBusinessErrorState(this.error);
}

class GetSportsSuccessState extends NewsStates {}

class GetSportsErrorState extends NewsStates {
  String error;

  GetSportsErrorState(this.error);
}

class GetScienceSuccessState extends NewsStates {}

class GetScienceErrorState extends NewsStates {
  String error;

  GetScienceErrorState(this.error);
}

class ChangeModeState extends NewsStates {}

class GetSearchState extends NewsStates {
  String controller;
  GetSearchState(this.controller);
}

class LoadingSearchState extends NewsStates {}

class GetSearchErrorState extends NewsStates {}