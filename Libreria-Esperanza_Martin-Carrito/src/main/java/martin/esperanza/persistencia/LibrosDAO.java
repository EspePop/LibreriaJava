package martin.esperanza.persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import martin.esperanza.modelo.Libro;

public class LibrosDAO implements ItfzLibrosDAO {
	
	private Connection conexion;
	
	@Override
	public void abrirConexion() {
		
		try {
			//Conectamos con nuestra base de datos:
			Class.forName("com.mysql.jdbc.Driver");
			conexion = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/libreria?characterEncoding=UTF-8&useConfigs=maxPerformance", "root", "adminadmin");
			//?characterEncoding=latin1&useConfigs=maxPerformance
		
		} catch (ClassNotFoundException e) {
			System.out.println("Error en el driver");
			e.printStackTrace();
			
		} catch (SQLException e) {
			System.out.println("Error en la conexion");
			e.printStackTrace();
		}
	}
	

	@Override
	public void cerrarConexion() {
		try {
			conexion.close();
		} catch (SQLException e) {
			System.out.println("Error al cerrar la conexion");
			e.printStackTrace();
		}
	}
	
	
	//Nos creamos los métodos para poder hacer el CRUD en la BBDD
	
	//AÑADIR LIBRO
	@Override
	public boolean altaLibro(Libro libro) {
		
		boolean insertado = false;
		
		try {
			abrirConexion();
			
			PreparedStatement pst = conexion.prepareStatement("insert into libros values(?, ?, ?, ?, ?, ?, ?, ?)");
			
			pst.setInt(1, libro.getId());
			pst.setString(2, libro.getTitulo());
			pst.setString(3, libro.getAutor());
			pst.setString(4, libro.getEditorial());
			pst.setString(5, libro.getIsbn());
			pst.setInt(6, libro.getPublicacion());
			pst.setDouble(7, libro.getPrecio());
			pst.setString(8, libro.getDescripcion());
			
			int registros = pst.executeUpdate();

			if(registros == 1 ) {
				insertado = true;
				System.out.println("Se ha dado de alta el libro: " + libro.getTitulo() + "\n");
			}		
		
		} catch (SQLException e) {
			System.out.println("Error al dar de alta el nuevo libro");
			e.printStackTrace();
			
		} finally {
			cerrarConexion();
		}	
		
		return insertado;
	}
	
	//ELIMINAR LIBRO
	@Override
	public boolean eliminarLibro(int id) {
		
		boolean eliminado = false;
		
		try {
			abrirConexion();			
			
			PreparedStatement dlt = conexion.prepareStatement("delete from libros where ID =?");
			
			dlt.setInt(1, id);
			
			int registros = dlt.executeUpdate();			
			
			if(registros == 1 ) {
				
				eliminado = true;				
			}		
		
		} catch (SQLException e) {
			
			System.out.println("Error al eliminar el libro");
			e.printStackTrace();
		
		} finally {
			cerrarConexion();
		}	
		return eliminado;
	}

	//MOSTRAR LISTADO DE LOS LIBROS
	@Override
	public List<Libro> consultarTodos() {
     
		List<Libro> lista = new ArrayList<>();
		
		try {
			abrirConexion();
			
			Statement stm = conexion.createStatement();
			
			ResultSet rs = stm.executeQuery("select * from libros");
		
			while(rs.next()) {
				lista.add(new Libro(rs.getInt("ID"), rs.getString("TITULO"), rs.getString("AUTOR"), rs.getString("EDITORIAL"), rs.getString("ISBN"), rs.getInt("PUBLICACION"), rs.getDouble("PRECIO"), rs.getString("DESCRIPCION")));
			}
		
		} catch (SQLException e) {
			//pintamos los errores
			System.out.println("Error al consultar todos los libros");
			e.printStackTrace();
			
		} finally {
			cerrarConexion();
		}		
		
		return lista;
	}

	//CONSULTAR LIBRO POR ISBN
	@Override
	public Libro consultarISBN(String isbn) {
		
		Libro libro = null;
		
		try {
			abrirConexion();
			
			PreparedStatement srch = conexion.prepareStatement("select * from libros where ISBN = ?");
			
			srch.setString(1, isbn);
			ResultSet rs = srch.executeQuery();
			
			while(rs.next()) {
				libro = new Libro(rs.getInt("ID"), rs.getString("TITULO"), rs.getString("AUTOR"), rs.getString("EDITORIAL"), rs.getString("ISBN"), rs.getInt("PUBLICACION"), rs.getDouble("PRECIO"), rs.getString("DESCRIPCION"));

			}		
		
		} catch (SQLException e) {
			//pintamos los errores
			System.out.println("Error al consultar el libro por isbn");
			e.printStackTrace();
		} finally {
			cerrarConexion();
		}
		
		return libro;
	}
	
	//CONSULTAR LIBRO POR TITULO
	@Override
	public List<Libro> consultarTitulo(String titulo) {
		
		List<Libro> mostrarLibro = new ArrayList<>();
		
		try {
			abrirConexion();
			
			PreparedStatement stm = conexion.prepareStatement("select * from libros where TITULO like ?");
			
			stm.setString(1, "%"+ titulo+ "%");
			ResultSet rs = stm.executeQuery();
		
			while(rs.next()) {
				mostrarLibro.add(new Libro(rs.getInt("ID"), rs.getString("TITULO"), rs.getString("AUTOR"), rs.getString("EDITORIAL"), rs.getString("ISBN"), rs.getInt("PUBLICACION"), rs.getDouble("PRECIO"), rs.getString("DESCRIPCION")));
			}
		
		} catch (SQLException e) {
			System.out.println("Error al buscar el libro por titulo");
			e.printStackTrace();
			
		} finally {
			cerrarConexion();
		}		
		System.out.println(mostrarLibro);
		return mostrarLibro;
	}
	
	//MODIFICAR PRECIO DE UN LIBRO
	@Override
	public boolean modificarPrecio(String isbn, double precio) {
		
		boolean modificado = false;
		
		try {
			abrirConexion();			
		
			PreparedStatement chng = conexion.prepareStatement("update libros set PRECIO = ? where ISBN = ?");
			
			chng.setDouble(1, precio);	
			chng.setString(2, isbn);
				
			int reg = chng.executeUpdate();
				
			if(reg == 1) {
				modificado = true;
			}
	
		} catch(SQLException e) {
			System.out.println("Error al modificar el precio del libro");
			e.printStackTrace();
			
		} finally {
			cerrarConexion();
		}
		return modificado;
	}

	//CONSULTAR LIBRO POR ID
	@Override
	public Libro buscar(int id) {
		
		Libro libro = null;
		
		try {
			abrirConexion();
			PreparedStatement srch = conexion.prepareStatement("select * from libros where ID = ?");
			srch.setInt(1, id);
			ResultSet rs = srch.executeQuery();
			
			while(rs.next()) {
				libro = new Libro(rs.getInt("ID"), rs.getString("TITULO"), rs.getString("AUTOR"), rs.getString("EDITORIAL"), rs.getString("ISBN"), rs.getInt("PUBLICACION"), rs.getDouble("PRECIO"), rs.getString("DESCRIPCION"));
			}		
		
		} catch (SQLException e) {
			//pintamos los errores
			System.out.println("Error al consultar el libro");
			e.printStackTrace();
		} finally {
			cerrarConexion();
		}
		
		return libro;
	}


}
