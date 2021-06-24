<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>LIBRERIA_Esperanza_Martín</title>
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
	    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
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
			.portada{
				width: 40%;
				height: 7hv;
				margin: 100px auto;
			}	
				
			.footer{				
				text-align: right;
				padding-right: 40px;
				line-height: 3;
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
					<h4>Librería ESPE</h4>
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
							<% String usuario = (String)session.getAttribute("nombreUsuario");%>					
							<% if(usuario != null){ %>
								<a class="nav-link" href="mostrarCarrito.jsp">Mi cesta</a>
							<% } %>							
						</li>					
						<li class="nav-item">
							<!-- Si está abierta la sesión motrará el usuario -->
							<%-- <% String usuario = (String)session.getAttribute("nombreUsuario");%> --%>
							
							<%if(usuario != null){ %>
								<h5>Usuario : <%=session.getAttribute("nombreUsuario") %></h5>
								<button class="closeSession">
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
        	<div class="row row-1">
        		<img class="portada" alt="portada con datos personales" src="img/portada.png"/>
	        </div>
	     </div>	   
		<div class="row">
	    	<footer class="footer">
	        	<p> Desarrollado con JAVA por <cite>Esperanza Martín</cite></p>
	        </footer>
	   </div>
	</body>
</html>