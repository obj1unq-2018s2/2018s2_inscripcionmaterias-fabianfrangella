import materia.*
import universidad.*
class Estudiante {

	var materiasAprobadas // conjunto
	var property materiasInscriptas // conjunto
	var carreras 

	method puedeCursar(materia) = 
		self.cumplePrerrequisitos(materia)
		&& !materiasAprobadas.map{mat=>mat.materia()}.contains(materia)
	

	method inscribirse(materia) {
		if (self.puedeCursar(materia) && materia.tieneCupo()) {
			materiasInscriptas.add(materia)
			materia.inscribir(self)
		} else if (self.puedeCursar(materia) && !materia.tieneCupo()) {
			materia.ponerEnEspera(self)
			
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
		var anioMat = materia.anio()
		var matAprAux = materiasAprobadas.map{mat=>mat.Materia().anio()}.filter{anio => anio == anioMat}
		return anioMat == matAprAux
	}
	
	method cursaLaCarrera(carrera) = carreras.contains(carrera)
	
	method registrarAprobada(materia, nota) {
		var aprLocl = new MateriaAprobada(alumno = self, nota = nota, materia = materia)
		if (!materiasAprobadas.any{ mat => mat.materia() == aprLocl.materia()}) materiasAprobadas.add(aprLocl)
	}
	
}

