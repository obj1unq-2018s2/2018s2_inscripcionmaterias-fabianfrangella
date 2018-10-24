class Curso {
	const materia
	var alumnos = #{}
	var property listaDeEspera = #{}
	
	constructor(_materia){
		materia = _materia
	}
	method inscribirAlumno(alumno){
		alumnos.add(alumno)
	}
	
	method alumnos() = alumnos
	
	method ponerEnEspera(alumno){
		listaDeEspera.add(alumno)
	}
}

class Carrera {
	const property materias
	
	constructor (_materias){
		materias = _materias
	}
}