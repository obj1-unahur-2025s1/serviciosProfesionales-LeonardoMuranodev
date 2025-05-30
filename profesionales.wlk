class Empresa {
  const profesionales = #{}
  const honorarioReferencia
  const clientes = #{}

  //Metodos de consulta
  method cantProfesionalesQueEstudiaronEn(universidad) = profesionales.count({p => p.universidad() == universidad})

  method profesionalesCaros() = profesionales.filter({p => p.honorarios() > honorarioReferencia})

  method universidadesFormadoras() = profesionales.map({p => p.universidad()}).asSet()

  method profesionalMasBarato() = profesionales.min({p => p.honorarios()})

  method esDeGenteAcotada() = profesionales.all({p => p.provinciasQuePuedeTrabajar().size() <= 3})

  method puedeSatisfacer(solicitante) = profesionales.any({p => solicitante.puedeSerAtendido(p)})

  method profesionalQuePuedenAtender(solicitante) = profesionales.filter({p => solicitante.puedeSerAtendido(p)})

  method cantidadClientes() = clientes.size()

  method tieneDeClienteA(solicitante) = clientes.contains(solicitante)

  method profesionalesQueTrabajanEn(provincia) {
    return profesionales.filter({p => p.provinciasQuePuedeTrabajar().contains(provincia)})
  }

  method esProfesionalPocoAtractivo(profesional) {
    return profesional.provinciasQuePuedeTrabajar().all({p => 
    self.profesionalesQueTrabajanEn(p).any({p => p.honorarios() < profesional.honorarios()})})
  }

  //Metodos de indicacion
  method agregarVariosProfesionales(listaProfesionales) {
    profesionales.addAll(listaProfesionales)
  }

  method darServicio(solicitante) {
    if (self.puedeSatisfacer(solicitante)) {
      //Guardo un profesional que pueda atender al cliente
      const profAtiende = self.profesionalQuePuedenAtender(solicitante).anyOne()
      //Hago que cobre su honorario
      profAtiende.cobrarImporte(profAtiende.honorarios())
      //Lo agrego a clientes
      clientes.add(solicitante)
    }
  }
}


//Profesionales
class ProfesionalVinculado {
  const universidad

  //Metodos de consulta
  method universidad() = universidad
  method honorarios() = universidad.honorariosRecomendados()
  method provinciasQuePuedeTrabajar() = #{universidad.provincia()}

  //Metodos de indicacion
  method cobrarImporte(dinero) {
    universidad.contribuirALaRecaudacion(dinero / 2)
  }
}

class ProfesionalesDelLitoral {
  const universidad

  //Metodos de consulta
  method universidad() = universidad
  method honorarios() = 3000
  method provinciasQuePuedeTrabajar() = #{"Entre Rios", "Santa Fe", "Corrientes"}

  //Metodos de indicacion

  method cobrarImporte(dinero) {
    asociacionLitoral.contribuirALaRecaudacion(dinero)
  }
}

class ProfesionalLibre {
  const universidad
  const honorarios
  const provinciasQuePuedeTrabajar = #{}
  var dineroTotal = 0

  //Metodos de consulta
  method universidad() = universidad
  method honorarios() = honorarios
  method provinciasQuePuedeTrabajar() = provinciasQuePuedeTrabajar
  method dineroTotal() = dineroTotal

  //Metodos de indicacion
  method agregarLugaresDeTrabajo(listaLugares) {
    provinciasQuePuedeTrabajar.addAll(listaLugares)
  }

  method cobrarImporte(dinero) {
    dineroTotal += dinero
  }

  method transferirDineroA(profLibre, dinero) {
    dineroTotal = 0.max(dineroTotal - dinero)
    profLibre.cobrarImporte(dinero)
  }
}

//Universidad
class Universidad {
  const provincia
  const honorariosRecomendados
  var recaudacion = 0

  method provincia() = provincia
  method honorariosRecomendados() = honorariosRecomendados
  method recaudacion() = recaudacion

  //Metodos de indicacion
  method contribuirALaRecaudacion(dinero) {
    recaudacion += dinero
  }
}

object asociacionLitoral {
  var recaudacion = 0

  method recaudacion() = recaudacion

  //Metodos de indicacion
  method contribuirALaRecaudacion(dinero) {
    recaudacion += dinero
  }
}