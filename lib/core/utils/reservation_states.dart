enum ReserveStates { ACTIVE, NOT_ACTIVE, CANCELED, SHARED, FINISHED }

extension ReserveStatesSpanish on ReserveStates {
  
  static const reserveStatesMap = {
    ReserveStates.ACTIVE: "Activada",
    ReserveStates.NOT_ACTIVE: "Sin activar",
    ReserveStates.CANCELED: "Cancelada",
    ReserveStates.SHARED: "Compartida",
    ReserveStates.FINISHED: "Finalizada"
  };

  
  void console() {
    print("${this.translation}");
  }

  
  String? get translation => reserveStatesMap[this];
}

ReserveStates getState(String state) {
  switch (state) {
    case 'ACTIVE':
      return ReserveStates.ACTIVE;
    case 'NOT_ACTIVE':
      return ReserveStates.NOT_ACTIVE;
    case 'CANCELED':
      return ReserveStates.CANCELED;
    case 'SHARED':
      return ReserveStates.SHARED;
    default:
      return ReserveStates.FINISHED;
  }
}
