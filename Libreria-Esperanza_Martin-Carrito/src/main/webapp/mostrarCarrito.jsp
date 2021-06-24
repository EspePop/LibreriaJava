<%@page import="martin.esperanza.modelo.Libro"%>
<%@page import="java.util.List"%>
<%@page import="martin.esperanza.negocio.Carrito" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Consultar todos</title>
		
		<link rel="stylesheet" 
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" 
        integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" 
        crossorigin="anonymous">
        
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

    	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" 
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" 
        crossorigin="anonymous"></script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" 
        crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/style.css"/>
		<style type="text/css">
			body{
				background: url("img/fondo.png")no-repeat center center fixed; 
				-webkit-background-size: cover;
				-moz-background-size: cover;
				-o-background-size: cover;
				background-size: cover;
				
			}
			.container{	
				background-color:transparent;
				min-height: 100vh;
				height: max-content;
			}
			button{
				background-color: black;
				border: none;
			}
			.h3{
				margin-top: 40px;
				text-align: center;
				text-shadow: 1px 1px 1px;	
			}
			.cabecera{
				margin-top: 40px;
				text-align: center;
				text-shadow: 1px 1px 1px grey;
			}
			.form-style{
				background-color: #f7a800;
			}
			.eliminar{
				width: 30px;
			}
			.total{
				background-color: white;
				text-align: right;
				padding-right: 90px;
				padding-bottom: 10px;
			}
			
			/* Table Styles */

			.table-wrapper{
				background-color: white;
			    margin: 40px auto;
			    width: 90%;
			    box-shadow: 0px 35px 50px rgba( 0, 0, 0, 0.2 );
			}
			
			.fl-table {
			    border-radius: 5px;
			    font-size: 18px;
			    font-weight: normal;
			    border: none;
			    border-collapse: collapse;
			    width: 100%;
			    max-width: 100%;
			    white-space: nowrap;
			    background-color: white;
			}
			
			.fl-table td, .fl-table th {
			    text-align: center;
			    padding: 8px;
			}
			
			.fl-table td {
			    border-right: 1px solid #f8f8f8;
			    font-size: 16px;
			}
			
			/* Responsive */
			
			@media (max-width: 767px) {
			    .fl-table {
			        display: block;
			        width: 100%;
			    }
			    .table-wrapper:before{
			        content: "Scroll horizontally >";
			        display: block;
			        text-align: right;
			        font-size: 11px;
			        color: white;
			        padding: 0 0 10px;
			    }
			    .fl-table thead, .fl-table tbody, .fl-table thead th {
			        display: block;
			    }
			    .fl-table thead th:last-child{
			        border-bottom: none;
			    }
			    .fl-table thead {
			        float: left;
			    }
			    .fl-table tbody {
			        width: auto;
			        position: relative;
			        overflow-x: auto;
			    }
			    .fl-table td, .fl-table th {
			        padding: 20px .625em .625em .625em;
			        height: 60px;
			        vertical-align: middle;
			        box-sizing: border-box;
			        overflow-x: hidden;
			        overflow-y: auto;
			        width: 120px;
			        font-size: 13px;
			        text-overflow: ellipsis;
			    }
			    .fl-table thead th {
			        text-align: left;
			        border-bottom: 1px solid #f7f7f9;
			    }
			    .fl-table tbody tr {
			        display: table-cell;
			    }
			    .fl-table tbody tr:nth-child(odd) {
			        background: none;
			    }
			    .fl-table tr:nth-child(even) {
			        background: transparent;
			    }
			    .fl-table tr td:nth-child(odd) {
			        background: #F8F8F8;
			        border-right: 1px solid #E6E4E4;
			    }
			    .fl-table tr td:nth-child(even) {
			        border-right: 1px solid #E6E4E4;
			    }
			    .fl-table tbody td {
			        display: block;
			        text-align: center;
			    }
			}
			.footer{
				background-color: black;	
				color: #f7a800; 
				text-align: right;
				padding-right: 40px;
				line-height: 3;
				width: 100%;
			}
		</style>

	</head>
	<body>
		<div class="row">
			<nav class="navbar navbar-expand-lg col-md-12">
				<button class="navbar-toggler navbar-dark" type="button"
					data-toggle="collapse" data-target="#navbarText"
					aria-controls="navbarText" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="tituloJava">
					<h4>Librería Java</h4>
				</div>
				<div class="collapse navbar-collapse" id="navbarText">
					<ul class="navbar-nav mr-auto">
	
						<li class="nav-item active">
							<a class="nav-link"	href="index.jsp">INICIO </a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="servlet?op=1">Listado de libros</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="formularioAlta.jsp">Añadir libro</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="formularioBuscar.jsp">Buscar ISBN</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="formularioBuscarTitulo.jsp">Consultar TITULO</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="formularioModificar.jsp">Modificar Precio</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="formularioEliminar.jsp">Eliminar libro</a>
						</li>	
						<li class="nav-item"> 
							<!-- Si está abierta la sesión motrará el usuario -->
							<% String usuario = (String)session.getAttribute("nombreUsuario");%>	
							<%if(usuario.length() > 0){ %>
								<h5>Usuario : <%=session.getAttribute("nombreUsuario") %></h5>
								<button> 
									<a href="servlet?op=10">
							 			<img alt="cerrar sesion" title="cerrar sesion" src="img/logout.png"/>
									</a>
								</button>
							<%} %>
						</li>
					</ul>
				</div>					
			</nav>
		</div>	
		<div class="container">
			<div class="row">
				<marquee class="mensaje"> <%= application.getAttribute("msgAviso") %> </marquee>
			</div>
			<div class="row row-1">				
				<div class="form-style">
					<h3 class="col-md-12 h3">Tu cesta de libros</h3>
					<%-- Recuperamos el carrito guardado en la sesion--%>
					<% Carrito carrito = (Carrito)session.getAttribute("miCarro"); %>
					<%  List<Libro> libros = carrito.getContenido(); %>
					<div class="table-wrapper">
						<table class="table table-striped table-hover table-borderless table-condensed fl-table">
  							<thead class="thead-dark">
								<tr>
									<th scope="col">ID </th>
									<th scope="col">TITULO </th>
									<th scope="col">AUTOR </th>
									<th scope="col">GENERO </th>
									<th scope="col">AÑO </th>
									<th scope="col">EDITORIAL </th>
									<th scope="col">ISBN </th>
									<th scope="col"> € </th>
									<th scope="col">Eliminar</th>				
								</tr>
							</thead>
							
							<tbody>
								<% for(Libro libro: libros){ %>
									<tr>
										<td scope="row"> <%= libro.getId() %> </td>
										<td scope="row"> <%= libro.getTitulo() %> </td>
										<td scope="row"> <%= libro.getAutor() %> </td>											
										<td scope="row"> <%= libro.getDescripcion() %> </td>									
										<td scope="row"> <%= libro.getPublicacion() %> </td>	
										<td scope="row"> <%= libro.getEditorial() %> </td>	
										<td scope="row"> <%= libro.getIsbn() %> </td>					
										<td scope="row"> <%= libro.getPrecio() %> €</td>
										<td scope="row">					
											<a href="servlet?op=8&codigo=<%= libro.getId() %>" onclick="confirmar(event)">
												<img alt="Eliminar <%= libro.getDescripcion() %>" class="eliminar"
												title="Quitar <%= libro.getDescripcion() %> del carrito" src="img/deleteCarrito.png" />
											</a>
										</td>			
									</tr>
								<% } %>		
							</tbody>	
						</table>
						<hr/>
						<div class="total">
							<h4 class="col-md-12">Total compra: <b> <%= Math.round(carrito.getImporte() * 100) / 100d %> € </b></h4>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
	    	<footer class="footer">
	        	<p> Desarrollado con JAVA por <cite>Esperanza Martín</cite></p>
	        </footer>
	   </div>
	
	</body>
</html>