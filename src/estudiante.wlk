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
		if (self.puedeCursar(materia) && materia.tieneCupo()) {
			materiasInscriptas.add(materia)
			materia.inscribir(self)
		} else if (self.puedeCursar(materia) && !materia.tieneCupo()) {
			materia.ponerEnEspera(self)
			materiasEnEspera.add(materia)
		} else {
			self.error ("No podes anotarte en esta materia")
		}
	}
	
	method cumplePrerrequisitos(materia) = materia.prerrequisitos(self)
	
	method tieneAprobadas(materias) {
		
		var matsAux = materias
		var matsAprAux = materiasAprobadas.map{mat => mat.materia()}.asSet().intersection(matsAux)
		return matsAprAux == matsAux 
		
	}
	
	method creditos() = materiasAprobadas.sum{ mat => mat.Materia().creditos() }
	
	method aproboElAnioAnterior(materia) {
		
		var materiasAnio = materia.carrera().materias().filter{mat=>mat.anio() == materia.anio()-1}
		var aprobadasAux = materiasAprobadas.map{mat=>mat.materia()}.filter{mat=>mat.anio() == materia.anio()}
		
		return materiasAnio.size() == aprobadasAux.size()
	}
	
	method cursaLaCarrera(carrera) = carreras.contains(carrera)
	
	method registrarAprobada(materia, nota) {
		var aprLocl = new MateriaAprobada(alumno = self, nota = nota, materia = materia)
		if (!materiasAprobadas.any{ mat => mat.materia() == aprLocl.materia()}) materiasAprobadas.add(aprLocl)
	}
	
	method materiasQuePuedeCursar(carrera){
		return carrera.materias().filter{materia=>self.puedeCursar(materia)}
	}
	
}

