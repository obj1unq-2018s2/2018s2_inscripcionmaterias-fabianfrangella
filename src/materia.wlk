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
		alumnos.add(alumno)
	}

	
	method tieneCupo() = cupo > alumnos.size()
	
	method ponerEnEspera(alumno) {
		listaDeEspera.add(alumno)
	}
	
	method darDeBaja(estudiante){
		alumnos.remove(estudiante)
		self.anotarAlPrimero()
	}
	
	method anotarAlPrimero() {
		self.inscribir(self.primeroDeLaLista())
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
}

