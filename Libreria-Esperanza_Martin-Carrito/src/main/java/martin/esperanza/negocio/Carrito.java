package martin.esperanza.negocio;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import martin.esperanza.modelo.Libro;

//Queremos serializar nuestro carrito:
public class Carrito implements Serializable {
	
	// Generamos un serialVersionUID para poder recuperar sesiones
	private static final long serialVersionUID = -6927176239806303587L;
	
	//Nos creamos las instancias con el importe del carrito 
	private double importe;	
	
	//y la lista del contenido del carrito
	private List<Libro> contenido = new ArrayList<>();
	
	//llamamos a la capa negocio
	private ItfzGestionLibreria negocio = new GestionLibreria();
	
	//El método donde le vamos a decir que vamos a añadir un libro
	//recibimos el identificador
	public void addLibro(int id) {
		//el libro encontrado usará el metodo buscar 
		Libro encontrado = negocio.buscar(id);
		//añadimos al carrito
		contenido.add(encontrado);
		//sumamos su precio al importe total
		importe += encontrado.getPrecio();
	}
	
	public void sacarLibro(int id) {
		
		//creamos una instancia de la clase Libro que va a ser de la clase eliminar
		Libro eliminar = null;
		
		//recorremos el contenido del carrito
		for(Libro libro : contenido) {
			
		//si el id del libro es igual al precio del libro
			if(id == libro.getId()) {
				//el libro con ese id será el que eliminemos
				eliminar = libro;
			}
		}		
		//entonces -> me lo "eliminas"
		contenido.remove(eliminar);
		//y restas el precio del producto
		importe -= eliminar.getPrecio();
		
	}
	
	
	//Clases idenpotentes 
	public double getImporte() {
		return importe;
	}
	
	public List<Libro> getContenido() {
		return contenido;
	}

	
	
	
	
	

}
