import estudiante.*

import universidad.*

class Materia {

	const carrera
	const creditos // numero
	const anio // numero
	const cupo
	var curso = new Curso(materia=self)
	var property inscriptos // conjunto

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
	
	method inscribir(alumno){
		inscriptos.add(alumno)
		curso.inscribirAlumno(alumno)
	}
	
	method tieneCupo() = cupo > curso.alumnos().size()
	
	method ponerEnEspera(alumno){
		curso.ponerEnEspera(alumno)
	}
	
	method darDeBaja(estudiante){
		inscriptos.remove(estudiante)
		self.inscribir(curso.listaDeEspera())
	}
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

}

