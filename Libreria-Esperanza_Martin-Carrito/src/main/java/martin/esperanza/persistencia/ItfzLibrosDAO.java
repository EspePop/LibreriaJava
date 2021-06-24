package martin.esperanza.persistencia;

import java.util.List;

import martin.esperanza.modelo.Libro;

public interface ItfzLibrosDAO {
	
	    void abrirConexion();
	
		void cerrarConexion();
		
		public boolean altaLibro(Libro libro);
		
		public boolean eliminarLibro(int id);
		
		public List<Libro> consultarTodos();
		
		//buscar por isbn
		public Libro consultarISBN(String isbn);
		
		//buscar por título
		public List<Libro> consultarTitulo(String titulo);
		
		public boolean modificarPrecio(String isbn, double precio);
		
		//buscar por id
		public Libro buscar(int id);

}