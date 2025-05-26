class Empresa {
  const profesionales = #{}
  const honorarioReferencia

  //Metodos de consulta
  method cantProfesionalesQueEstudiaronEn(universidad) = profesionales.count({p => p.universidad() == universidad})

  method profesionalesCaros() = profesionales.filter({p => p.honorarios() > honorarioReferencia})

  method universidadesFormadoras() = profesionales.map({p => p.universidad()}).asSet()

  method profesionalMasBarato() = profesionales.min({p => p.honorarios()})

  method esDeGenteAcotada() = profesionales.all({p => p.provinciasQuePuedeTrabajar().size() <= 3})

  //Metodos de indicacion
  method agregarVariosProfesionales(listaProfesionales) {
    profesionales.addAll(listaProfesionales)
  }
}


//Profesionales
class ProfesionalVinculado {
  const universidad

  method universidad() = universidad
  method honorarios() = universidad.honorariosRecomendados()
  method provinciasQuePuedeTrabajar() = #{universidad.provincia()}
}

class ProfesionalesDelLitoral {
  const universidad

  method universidad() = universidad
  method honorarios() = 3000
  method provinciasQuePuedeTrabajar() = #{"Entre Rios", "Santa Fe", "Corrientes"}
}

class ProfesionalLibre {
  const universidad
  const honorarios
  const provinciasQuePuedeTrabajar = #{}

  method universidad() = universidad
  method honorarios() = honorarios
  method provinciasQuePuedeTrabajar() = provinciasQuePuedeTrabajar

  //Metodos de indicacion
  method agregarLugaresDeTrabajo(listaLugares) {
    provinciasQuePuedeTrabajar.addAll(listaLugares)
  }
}

//Universidad
class Universidad {
  const provincia
  const honorariosRecomendados

  method provincia() = provincia
  method honorariosRecomendados() = honorariosRecomendados
}