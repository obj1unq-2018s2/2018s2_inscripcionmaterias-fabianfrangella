import materia.*
import universidad.*
class Estudiante {

	var property materiasAprobadas // conjunto
	var property materiasInscriptas // conjunto
	var property materiasEnEspera = #{}
	var property carreras 

	method puedeCursar(materia) = 
		self.cumplePrerrequisitos(materia)
		&& !materiasAprobadas.map{mat=>mat.materia()}.contains(materia)
	

	method inscribirse(materia) {
		materiasInscriptas.add(materia)
	}

	method agregarEnEspera(materia) {
		materiasEnEspera.add(materia)
	}
	
	method cumplePrerrequisitos(materia) = materia.prerrequisitos(self)
	
	method tieneAprobadas(materias) {
		
		var matsAux = materias
		var matsAprAux = materiasAprobadas.map{mat => mat.materia()}.asSet().intersection(matsAux)
		return matsAprAux == matsAux 
		
	}
	
	method creditos() = materiasAprobadas.sum{ mat => mat.Materia().creditos() }
	
	method aproboElAnioAnterior(materia) {
		
		var anioAux = materia.anio() - 1
		var carreraAux = materia.carrera()
		var aprobadasAnio = materiasAprobadas.filter{mat=>mat.anioMateria()==anioAux}
		return carreraAux.materiasDeAnio(anioAux) == aprobadasAnio.map{mat=>mat.materia()}.asSet()
	}
	
	method cursaLaCarrera(carrera) = carreras.contains(carrera)
	
	method registrarAprobada(materia, nota) {
		var aprLocl = new MateriaAprobada(alumno = self, nota = nota, materia = materia)
		if (!materiasAprobadas.any{ mat => mat.materia() == aprLocl.materia()}) materiasAprobadas.add(aprLocl)
	}
	
	method materiasQuePuedeCursar(carrera){
		return carrera.materias().filter{materia=>self.puedeCursar(materia)}
	}
	
	method cantidadDeAprobadas() = materiasAprobadas.size()
	
	method promedio() = materiasAprobadas.sum{ mat => mat.nota() }
}

