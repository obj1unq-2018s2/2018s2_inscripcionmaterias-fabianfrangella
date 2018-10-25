import estudiante.*

import universidad.*

class Materia {

	const carrera
	const creditos // numero
	const anio // numero
	const cupo
	const criterio 
	var property alumnos = #{}
	var property listaDeEspera = []


	constructor(_carrera, _creditos, _anio,_cupo,_criterio) {
		carrera = _carrera
		creditos = _creditos
		anio = _anio
		cupo = _cupo
		criterio = _criterio
	}

	method carrera() = carrera

	method prerrequisitos(alumno) = alumno.cursaLaCarrera(self.carrera())

	method creditos() = creditos
	
	method anio() = anio
	
	method inscribir(alumno) {
		if (alumno.puedeCursar(self) && self.tieneCupo()) {
			alumno.inscribirse(self)
			alumnos.add(alumno)
		} else if (alumno.puedeCursar(self) && !self.tieneCupo()) {
			self.ponerEnEspera(alumno)
			alumno.agregarEnEspera(self)
		} else {
			self.error ("No podes anotarte en esta materia")
		}
	}

	
	method tieneCupo() = cupo > alumnos.size()
	
	method ponerEnEspera(alumno) {
		listaDeEspera.add(alumno)
	}
	
	method darDeBaja(estudiante){
		alumnos.remove(estudiante)
		criterio.anotarAlQueCorresponda(self)
	}
	method sacarDeLista(alguien){
		listaDeEspera.remove(alguien)
	}
	method sacarPrimero() { 
		listaDeEspera = listaDeEspera.drop(1)
	}
	method primeroDeLaLista() = listaDeEspera.first()
	
	method estudiantesEnListaDeEspera() = listaDeEspera
	
	method mejorPromedioEnEspera() =
		listaDeEspera.max{ alumno => alumno.promedio() }
	
}

class MateriaConCorrelativas inherits Materia {

	var correlativas // lista de materias

	override method prerrequisitos(alumno) {
		return super(alumno) && alumno.tieneAprobadas(correlativas)
	}

}

class MateriaConCreditos inherits Materia {

	override method prerrequisitos(alumno) {
		return super(alumno) && alumno.creditos() >= creditos
	}

}

class MateriaDeAnio inherits Materia {

	override method prerrequisitos(alumno) {
		return super(alumno) && alumno.aproboElAnioAnterior(self)
	}

}

class MateriaAprobada {

	const alumno
	const nota
	const materia

	constructor(_alumno, _nota, _materia) {
		alumno = _alumno
		nota = _nota
		materia = _materia
	}

	method materia() = materia
	method anioMateria() = materia.anio()
	method nota() = nota
}


object porOrdenDeLlegada {
	 method anotarAlQueCorresponda(materia){
		materia.inscribir(materia.primeroDeLaLista())
		materia.sacarPrimero()
	}
}

object porGradoDeAvance {
	 method anotarAlQueCorresponda(materia){
		var masAvanzado = materia.listaDeEspera().max{alumno=>alumno.cantidadDeAprobadas()}
		materia.inscribir(masAvanzado)
		materia.sacarDeLista(masAvanzado)
	}
}

object elitista  {

	 method anotarAlQueCorresponda(materia) {
		var mejorPromedio = materia.mejorPromedioEnEspera()
		materia.inscribir(mejorPromedio)
		materia.sacarDeLista(mejorPromedio)
	}

}

