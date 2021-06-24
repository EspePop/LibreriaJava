package martin.esperanza.negocio;

import java.util.List;

import martin.esperanza.modelo.Libro;
import martin.esperanza.persistencia.ItfzLibrosDAO;
import martin.esperanza.persistencia.LibrosDAO;


public class GestionLibreria implements ItfzGestionLibreria {
	
	ItfzLibrosDAO dao = new LibrosDAO();

	@Override
	public boolean altaLibro(Libro libro) {
		return dao.altaLibro(libro);
	}


	@Override
	public boolean eliminarLibro(int id) {
		return dao.eliminarLibro(id);
	}

	@Override
	public List<Libro> consultarTodos() {
		return dao.consultarTodos();
	}

	@Override
	public Libro consultarISBN(String isbn) {
		return dao.consultarISBN(isbn);
	}

	@Override
	public List<Libro> consultarTitulo(String titulo) {
		return dao.consultarTitulo(titulo);
	}

	@Override
	public boolean modificarPrecio(String isbn, double precio) {
		return dao.modificarPrecio(isbn, precio);
	}


	@Override
	public Libro buscar(int id) {
		return dao.buscar(id);
	}

	
}
