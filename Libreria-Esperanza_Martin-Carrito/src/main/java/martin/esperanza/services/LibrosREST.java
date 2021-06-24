package martin.esperanza.services;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.json.JSONArray;
import org.json.JSONObject;

import martin.esperanza.modelo.Libro;
import martin.esperanza.negocio.GestionLibreria;
import martin.esperanza.negocio.ItfzGestionLibreria;

@Path("/")

public class LibrosREST {
	
	private ItfzGestionLibreria negocio = new GestionLibreria();
	
	//Metodo buscar por isbn
	//http://localhost:8080/Libreria-Esperanza_Martin-Carrito/rest/listado/isbn6
	@GET
	@Path("listado/{codigo}") //ruta -> metodo que al que llama
	@Produces("application/json") 
	public String buscar(@PathParam("codigo") String isbn) {
		Libro libro = negocio.consultarISBN(isbn);
		JSONObject json = new JSONObject(libro);
		return json.toString();
	}
	
	
	//Metodo buscar por titulo
	//http://localhost:8080/Libreria-Esperanza_Martin-Carrito/rest/consultar/matilda
	@GET
	@Path("consultar/{titulo}") //ruta -> metodo que al que llama
	@Produces("application/json") 
	public String buscarTitulo(@PathParam("titulo") String titulo) {
		List<Libro> lista = negocio.consultarTitulo(titulo);
		JSONArray array = new JSONArray(lista);
		return array.toString();
	}
	
	
	//CRUD
	//CREATE
	//http://localhost:8080/Libreria-Esperanza_Martin-Carrito/rest/alta
	@POST
	@Path("alta")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces("application/json")
	public String alta(@FormParam("id") int id, @FormParam("titulo") String titulo, 
			@FormParam("autor") String autor, @FormParam("editorial") String editorial, 
			@FormParam("isbn") String isbn, @FormParam("publicacion") int publicacion,
			@FormParam("precio") double precio, @FormParam("descripcion") String descripcion ) {
		
		Libro libro = new Libro(id, titulo, autor, editorial, isbn, publicacion, precio, descripcion);
		
		boolean insertado = negocio.altaLibro(libro);
		JSONObject json = new JSONObject(libro);
		json.put("insertado", insertado);
		return json.toString();
	}
	
	//READ
	//http://localhost:8080/Libreria-Esperanza_Martin-Carrito/rest/listado
	@GET
	@Path("listado") //ruta -> metodo que al que llama
	@Produces("application/json") //ContentType -> lo que estamos devolviendo/formato
	public String todos() {
		
		//Recogemos la lista de productos
		List<Libro> lista = negocio.consultarTodos();
		
		//convertimos una lista de objetos java a un array json
		JSONArray array = new JSONArray(lista);
		
		//Me devuelves el array convertido a String
		return array.toString();		
	}
	
	//UPDATE
	//http://localhost:8080/Libreria-Esperanza_Martin-Carrito/rest/modificar
	@PUT
	@Path("modificar")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	@Produces("application/json")
	public String modificar(@FormParam("isbn") String isbn, @FormParam("precio") double precio) {
		boolean modificado = negocio.modificarPrecio(isbn, precio);
		JSONObject json = new JSONObject();
		json.put("modificado", modificado);
		return json.toString();
			
	} 
	
	//DELETE
	//http://localhost:8080/Libreria-Esperanza_Martin-Carrito/rest/eliminar/7
	@DELETE
	@Path("eliminar/{codigo}") //ruta -> metodo que al que llama y el objeto a recuperar {parametro}
	@Produces("application/json") //ContentType -> lo que estamos devolviendo/formato
	public String eliminar(@PathParam("codigo") int id) {
		boolean eliminado = negocio.eliminarLibro(id);
		JSONObject json = new JSONObject(eliminado);
		json.put("eliminado", eliminado);
		return json.toString();			
	}	
	
}