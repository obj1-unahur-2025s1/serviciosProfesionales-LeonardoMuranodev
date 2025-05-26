import profesionales.*

class Persona {
    const provinciaDondeVive
    
    method puedeSerAtendido(profesional) = profesional.provinciasQuePuedeTrabajar().contains(provinciaDondeVive)
}

class Institucion {
    const universidadesQueReconoce
    
    method puedeSerAtendido(profesional) {
        return universidadesQueReconoce.any({u => profesional.universidad() == u})
    }
}

class Club {
    const provincias 

    method puedeSerAtendido(profesional) {
        return provincias.any({p => profesional.provinciasQuePuedeTrabajar().contains(p)})
    }
}