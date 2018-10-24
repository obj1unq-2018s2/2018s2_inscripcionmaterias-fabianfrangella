class Carrera {

	var property materias = #{}

	method asignarMateria(materia) {
		materias.add(materia)
	}

	method materiasDeAnio(anio) = materias.filter{ mat => mat.anio() == anio }

}

