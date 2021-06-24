package martin.esperanza.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import martin.esperanza.modelo.Libro;
import martin.esperanza.negocio.Carrito;
import martin.esperanza.negocio.GestionLibreria;
import martin.esperanza.negocio.ItfzGestionLibreria;

@WebServlet(urlPatterns = { "/servlet" },
		initParams = { 	
				@WebInitParam(
						name = "aviso", 
						value = "¡Compra en nuestra plataforma Online!") 
				})

public class LibrosServlet extends HttpServlet {

	private static final long serialVersionUID = -6687742739178851330L;
	
	//Llamamos a la capa negocio
	//recuperamos los mérodos de GestionLibreria a través de la interface que nos hemos creado
	ItfzGestionLibreria negocio = new GestionLibreria();

	
	// **************************** // 
	
	// METODO INIT()
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);

		// Recuperamos el parámetro inicial del servlet:
		String oferta = config.getInitParameter("aviso");

		// Recuperar el ServletContext 
		ServletContext ctxApp = config.getServletContext();

		// Lo guardamos como atributo de la app
		ctxApp.setAttribute("msgAviso", oferta);

		System.out.println("La instancia del servlet ha sido creada-----------");

		// recuperamos el dato en consultarTodos.jsp y mostrarCarrito.jsp
	}
	
	// **************************** // 

	// METODO DESTROY
	@Override
	public void destroy() {
		super.destroy();
		System.out.println("La instancia del servlet ha sido destruida-----------");
	}

	// CONSTRUCTOR
	public LibrosServlet() {}

	
	// **************************** // 
	
	//MOSTRAR TODOS LOS LIBROS
	private String procesarTodos(HttpServletRequest request, HttpServletResponse response) {

		List<Libro> libreria = negocio.consultarTodos();

		// Guardamos la lista de libros como atributo de la peticion:
		request.setAttribute("libros", libreria);

		//retornamos el nombre de la página
		return "/consultarTodos.jsp";
	}
	
	// **************************** // 

	// AÑADIR LIBRO
	private String procesarAlta(HttpServletRequest request, HttpServletResponse response) {

		// Recogemos los datos del formulario
		int id = Integer.parseInt(request.getParameter("codigo"));
		String titulo = request.getParameter("titulo");
		String autor = request.getParameter("autor");
		String editorial = request.getParameter("editorial");
		String isbn = request.getParameter("isbn");
		int publicacion = Integer.parseInt(request.getParameter("publi"));
		double precio = Double.parseDouble(request.getParameter("precio"));
		String descripcion = request.getParameter("descrip");

		boolean insertado = negocio
				.altaLibro(new Libro(id, titulo, autor, editorial, isbn, publicacion, precio, descripcion));

		if (insertado) {
			request.setAttribute("mensaje", "El libro " + titulo + " se ha añadido correctamente.");
		} else {
			request.setAttribute("mensaje", "El libro " + titulo + " no se ha podido añadir");
		}

		return "/formularioAlta.jsp";
	}
	
	// **************************** // 

	// ELIMINAR LIBRO
	private String procesarEliminar(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("codigo"));

		boolean eliminado = negocio.eliminarLibro(id);

		if (eliminado) {
			request.setAttribute("mensaje", "Has ELIMINADO el libro " + id);
		} else {
			request.setAttribute("mensaje", "El libro " + id + " no se ha podido eliminar");
		}

		return "/formularioEliminar.jsp";
	}
	
	// **************************** // 

	// BUSCAR LIBRO POR ISBN
	private String procesarBusqueda(HttpServletRequest request, HttpServletResponse response) {

		String isbn = request.getParameter("isbn");
		Libro libro = negocio.consultarISBN(isbn);
		request.setAttribute("encontrado", libro);

		return "/formularioBuscar.jsp";
	}
	
	// **************************** // 

	// BUSCAR LIBRO POR TITULO
	private String procesarBusquedaTitulo(HttpServletRequest request, HttpServletResponse response) {

		String titulo = request.getParameter("titulo");

		List<Libro> libro = negocio.consultarTitulo(titulo);

		request.setAttribute("busqueda", libro);

		return "/formularioBuscarTitulo.jsp";
	}
	
	// **************************** // 

	// MODIFICAR LIBRO
	private String procesarModificar(HttpServletRequest request, HttpServletResponse response) {

		String isbn = request.getParameter("isbn");

		double precio = Double.parseDouble(request.getParameter("precio"));

		boolean modificado = negocio.modificarPrecio(isbn, precio);

		if (modificado) {
			request.setAttribute("mensaje", "El precio ha sido MODIFICADO a " + precio + "€");
		} else {
			request.setAttribute("mensaje", "El precio no se ha podido modificar");
		}

		return "/formularioModificar.jsp";

	}
	
	// **************************** // 

	// AÑADIR UN LIBRO AL CARRITO
	private String procesarCompra(HttpServletRequest request, HttpServletResponse response) {

		// Recuperar las cookies y ver si existe una cookie de usuario
		String nombre = "";

		Cookie[] allCookies = request.getCookies();
		for (Cookie cookie : allCookies) {
			if ("usuario".equals(cookie.getName())) {
				nombre = cookie.getValue();
			}
		}

		// Si existe el nombre entonces puede comprar, sino redirigimos a
		// formularioLogin.jsp
		if (nombre.length() == 0) {
			return "/login.jsp";

		} else {

			// Nos llega un codigo de libro -> lo recuperamos con su identificador,parametro codigo
			int id = Integer.parseInt(request.getParameter("codigo"));

			// Recuperar la sesión el usuario;
			HttpSession miSesion = request.getSession(true);

			// Agregamos nuevo carrito a esa sesión
			Carrito carrito = (Carrito) miSesion.getAttribute("miCarro");
			// Si carrito está vacio,
			if (carrito == null) {
				// cogemos el carrito, creamos una instancia y
				carrito = new Carrito();
				// la proxima vez lo podremos recuperar/guardar
				miSesion.setAttribute("miCarro", carrito);
			}

			// Guardamos el nombre como atributo de la sesión
			miSesion.setAttribute("nombreUsuario", nombre);

			// Sumamos el libro al carrito
			carrito.addLibro(id);

			// Devolvemos la vista -> carrito
			return "/mostrarCarrito.jsp";
		}

	}
	
	// **************************** // 

	// SACAR UN LIBRO DEL CARRITO
	private String procesarSacarLibro(HttpServletRequest request, HttpServletResponse response) {
		// Recuperar el codigo del libro
		int id = Integer.parseInt(request.getParameter("codigo"));

		// Recuperar la session del usuario
		HttpSession miSession = request.getSession(false);

		// Agregamos el carrito a esa session 
		Carrito carrito = (Carrito) miSession.getAttribute("miCarro");

		// Agregamos el libro al carrito
		carrito.sacarLibro(id);

		// Devolvemos la vista
		return "/mostrarCarrito.jsp";
	}
	
	// **************************** // 

	// LOGIN
	private String procesarLogin(HttpServletRequest request, HttpServletResponse response) {

		// Recuperar usuario
		String nombre = request.getParameter("user");

		// Crear cookie
		Cookie miCookie = new Cookie("usuario", nombre);

		// Establecer permanencia en segundos
		miCookie.setMaxAge(24 * 60 * 60); // 1 día

		// Adjuntar la cookie a la respuesta
		response.addCookie(miCookie);

		// nos llevará al listado de libros para seguir comprando
		return "/servlet?op=1";
	}
	
	// **************************** // 

	// LOGOUT
	private String procesarLogout(HttpServletRequest request, HttpServletResponse response) {

		// Recuperamos sesion
		HttpSession miSession = request.getSession(false);

		// Cerramos sesion
		miSession.invalidate();

		// Recorremos la cookie y si está la eliminamos
		Cookie[] allCookies = request.getCookies();
		for (Cookie cookie : allCookies) {
			if ("usuario".equals(cookie.getName())) {
				cookie.setMaxAge(0);
				cookie.setValue("");
				response.addCookie(cookie);
			}
		}

		return "/index.jsp";
	}

	// **************************** // 
	
	// ENVIAR: METODO GET
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String vista = "/index.jsp";

		switch (request.getParameter("op")) { // en la peticion recogemos el parametro op

		case "1": // consultar todos los libros
			vista = procesarTodos(request, response);
			break;

		case "2": // añadir un libro nuevo
			vista = procesarAlta(request, response);
			break;

		case "3": // eliminar un libro
			vista = procesarEliminar(request, response);
			break;

		case "4": // buscar libro por isbn
			vista = procesarBusqueda(request, response);
			break;

		case "5": // buscar libro por título
			vista = procesarBusquedaTitulo(request, response);
			break;

		case "6": // modificar precio de un libro
			vista = procesarModificar(request, response);
			break;

		case "7": // añadir un libro al carrito
			vista = procesarCompra(request, response);
			break;

		case "8": // sacar un libro del carrito
			vista = procesarSacarLibro(request, response);
			break;

		case "9": // logarse
			vista = procesarLogin(request, response);
			break;

		case "10": // cerrar sesión
			vista = procesarLogout(request, response);
			break;

		default:
			break;
		}

		// Elegir la vista que mostrará el resultado:
		RequestDispatcher rd = request.getRequestDispatcher(vista);

		// Redirigir hasta la página de la vista:
		rd.forward(request, response);
	}
	
	// **************************** // 

	// ENVIAR METODO: POST
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Hacemos que cumpla las mismas condiciones que el método doGet
		doGet(request, response);
	}

}
