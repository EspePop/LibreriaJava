<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="martin.esperanza.modelo.Libro"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Buscar ISBN</title>	
	    <script src="js/validacion.js"></script>
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" 
	    integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
	    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" 
	    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" 
	    integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>	
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
			.h4{
				margin-top: 40px;
				text-align: center;
				text-shadow: 1px 1px 1px;	
			}
			.mensaje{
				background-color: white;
				margin: 30px auto;
				width: 50%;
			}
			.cabecera{
				margin: 20px auto;
				width: 50%;
				color: white;
				text-align: center;
				font-weight: bold;
				text-shadow: 1px 1px 1px grey;
			}
			.form-style{
				width: 80%;	
				margin: 50px auto;
				background-color: #f7a800;
			}
			.formulario{
				width: 80%;
				display: grid;
			    grid-template-columns: 1fr;
			    gap: 20px;
			    margin: 20px auto;
			    padding-left: 40px;
			}
			.form-control{
				width: 100%;
				margin: auto;
				text-align: center;
			}
			.form-group-btn-enviar{
				width: 90%;
				text-align: center;
				margin: auto;
			}
			.submit{
				background-color: black;
				color: #f7a800;
				border: none;
				height: 30px;
			}
			.card{
				margin: auto;
				width: 20rem;
				background-color: #f7a800; 
			}
			.card-title{
				height: 50px;
				text-align: center;
				font-size: 26px;
				font-weigth: bold;
				margin-bottom: 20px;
				text-shadow: 1px 1px 1px;
			}
			.card-list{
				font-weight: bold;
				text-align: center;
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
							<%if(usuario != null){ %>
								<a class="nav-link" href="mostrarCarrito.jsp">Mi cesta</a>
							<%} %>							
						</li>					
						<li class="nav-item"> 
							<!-- Si está abierta la sesión motrará el usuario -->
							<%-- <% String usuario = (String)session.getAttribute("nombreUsuario");%> --%>
							
							<%if(usuario != null){ %>
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
        	<div class="row row-1">
	            
                <div class="form-style">
                	<h4 class="col-md-12 h4">CONSULTAR libro por ISBN</h4>
	                <form action="servlet" method="get" class="formulario col-md-12" id="consultarIsbn">
	                	<div class="form-group">
		                	<input type="text" class="form-control col-lg-12 col-md-12 col-sm-12" name="isbn" 
		                        id="isbn" title="Introduce el ISBN del libro" placeholder="Introduce ISBN" />
		                 </div>
						 <div class="form-group form-group-btn-enviar">
		                    <input type="hidden" name="op" value="4"/>
		                    <input type="submit" class="form_btn submit col-lg-6" value="Consultar Libro" id="consultar" title="Vamos a consultar si tenemos el libro" onclick="consultaLibro()" />
		                 </div>					
					</form>	
				</div>		
			</div>
		
			<div class="row">			
				<% Libro libros = (Libro)request.getAttribute("encontrado"); %>
				<%if(libros != null){%>
				
					<jsp:useBean id="encontrado" scope="request" class="martin.esperanza.modelo.Libro"/>
					<h2 class="col-md-12 cabecera">
						El libro con ISBN <u><jsp:getProperty property="isbn" name="encontrado"/></u> es:
					</h2>
					<div class="card">
						<div class="card-body">  
	  						<h5 class="card-title"><jsp:getProperty property="titulo" name="encontrado"/></h5>  
	  						<div class="card-list"> 
	  						    <ul class="list-group list-group-flush">  
	  						    	<li class="list-group-item">ID: <jsp:getProperty property="id" name="encontrado"/></li>  
	  								<li class="list-group-item"><jsp:getProperty property="autor" name="encontrado"/> </li> 
	  								<li class="list-group-item">Editorial: <jsp:getProperty property="editorial" name="encontrado"/></li> 
	  								<li class="list-group-item">Año: <jsp:getProperty property="publicacion" name="encontrado"/></li> 
	  								<li class="list-group-item">Género: <jsp:getProperty property="descripcion" name="encontrado"/> </li> 
	  								<li class="list-group-item pvp"> <jsp:getProperty property="precio" name="encontrado"/> € </li> 
	  							</ul> 
	  						</div> 
	  					</div>
					</div>
				<% }%>
			</div>
		</div>
		
		<div class="row">
	    	<footer class="footer">
	        	<p> Desarrollado con JAVA por <cite>Esperanza Martín</cite></p>
	        </footer>
	   </div>
	</body>
</html>