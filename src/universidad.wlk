class Curso {
	const materia
	var alumnos = #{}
	var property listaDeEspera = []
	
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
	
	method darDeBaja(estudiante){
		alumnos.remove(estudiante)
	}
	
	method anotarAlPrimero(){
		self.inscribirAlumno(self.primeroDeLaLista())
		materia.inscribir(self.primeroDeLaLista())
		listaDeEspera = listaDeEspera.drop(1)
	}
	
	method primeroDeLaLista() = listaDeEspera.get(0)
}

class Carrera {
	
	var property materias = #{}
	
	method asignarMateria(materia){
		materias.add(materia)
	}
}