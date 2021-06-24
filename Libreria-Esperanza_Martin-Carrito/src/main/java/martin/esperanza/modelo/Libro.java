package martin.esperanza.modelo;

public class Libro {

	private int id;
	private String titulo;
	private String autor;
	private String editorial;
	private String isbn;
	private int publicacion;
	private double precio;
	private String descripcion;
	
	public Libro() {}

	public Libro(int id, String titulo, String autor, String editorial, String isbn, int publicacion, double precio, String descripcion) {
		super();
		this.id = id;
		this.titulo = titulo;
		this.autor = autor;
		this.editorial = editorial;
		this.isbn = isbn;
		this.publicacion = publicacion;
		this.precio = precio;
		this.descripcion = descripcion;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getAutor() {
		return autor;
	}

	public void setAutor(String autor) {
		this.autor = autor;
	}

	public String getEditorial() {
		return editorial;
	}

	public void setEditorial(String editorial) {
		this.editorial = editorial;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public int getPublicacion() {
		return publicacion;
	}

	public void setPublicacion(int pubicacion) {
		this.publicacion = pubicacion;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	@Override
	public String toString() {
		return "Libro: \n ID:" + id + "\n Titulo: " + titulo + "\n Autor: " + autor + "\n Editorial: " + editorial + "\n isbn: "
				+ isbn + "\n Publicacion: " + publicacion + "\n PVP: " + precio + "€ \n Descripcion: " + descripcion + "\n";
	}
	
	
}
