package martin.esperanza.negocio;

import java.util.List;

import martin.esperanza.modelo.Libro;

public interface ItfzGestionLibreria {
	
	public boolean altaLibro(Libro libro);
	
	public boolean eliminarLibro(int id);
	
	public List<Libro> consultarTodos();
	
	//buscar por isbn
	public Libro consultarISBN(String isbn);
	
	//buscar por titulo
	public List<Libro> consultarTitulo(String titulo);
	
	//buscar por id
	public Libro buscar(int id);
	
	public boolean modificarPrecio(String isbn, double precio);

}
