import estudiante.*

import universidad.*

class Materia {

	const carrera
	const creditos // numero
	const anio // numero
	const cupo
	var property alumnos = #{}
	var listaDeEspera = []


	constructor(_carrera, _creditos, _anio,_cupo) {
		carrera = _carrera
		creditos = _creditos
		anio = _anio
		cupo = _cupo
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
		self.anotarAlQueCorresponda()
	}
	
	method anotarAlQueCorresponda() { // las materias normales anotan por orden de llegada
		self.inscribir(self.primeroDeLaLista())
		listaDeEspera = listaDeEspera.drop(1)
	}
	method primeroDeLaLista() = listaDeEspera.first()
	
	method estudiantesEnListaDeEspera() = listaDeEspera
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

class MateriaElitista inherits Materia {

	override method anotarAlQueCorresponda() {
		var mejorPromedio = listaDeEspera.max{alumno=>alumno.promedio()}
		self.inscribir(mejorPromedio)
		listaDeEspera.remove(mejorPromedio)
	}

}

class MateriaPorGradoDeAvance inherits Materia {

	override method anotarAlQueCorresponda() {
		var masAvanzado = listaDeEspera.max{alumno=>alumno.cantidadDeAprobadas()}
		self.inscribir(masAvanzado)
		listaDeEspera.remove(masAvanzado)
		
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

