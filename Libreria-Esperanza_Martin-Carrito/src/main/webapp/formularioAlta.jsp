<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Añadir Libro</title>	
	<script src="js/script.js"></script>
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
		integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
		crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
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
		.h4{
			margin-top: 40px;
			text-align: center;
			text-shadow: 1px 1px 1px;	
		}
		.mensaje{
			background-color: black;
			margin: 30px auto;
			width: 50%;
		}
		.cabecera{
			margin-top: 40px;
			text-align: center;
			font-weight: bold;
			text-shadow: 1px 1px 1px grey;
		}
		.form-style{
			width: 90%;	
			margin: 30px auto;
			background-color: #f7a800;
		}
		.form-control{
			text-align: center;
		}
		.form-group-btn-enviar{
			margin-left: 200px;
		}
		.submit{
			background-color: black;
			color: #f7a800;
			border: none;
			height: 30px;
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
				<div class="mensaje">				
					<%if (request.getAttribute("mensaje") != null) {%>
						<%=request.getAttribute("mensaje")%>
					<%}%>
				</div>
				<div class="form-style">
					<h4 class="col-md-12 h4">AÑADIR LIBRO</h4>
					<form action="servlet" method="post" class="formulario"	id="formulario" onsubmit="validar()">
	
						<!-- ID -->
						<div class="form-group" id="group_ident">
							<label for="ident" class="form_label"></label>
							<div class="form-group_input">
								<input type="text" class="form-control col-lg-12" name="codigo"
									value="Nuevo ID" id="codigo" pattern="[0-9]{1,}"
									title="ID SOLO PUEDE CONTENER NUMEROS" placeholder="Nuevo ID" />
							</div>
						</div>
	
						<!-- TITULO -->
						<div class="form-group" id="group_titulo">
							<label for="titulo" class="form_label"></label>
							<div class="form-group_input">
								<input type="text" class="form-control col-lg-12" name="titulo"
									id="titulo" title="Introduce el título del libro"
									placeholder="Título del libro" />
							</div>
						</div>
	
						<!-- AUTOR -->
						<div class="form-group" id="group_autor">
							<label for="autor" class="form_label"></label>
							<div class="form-group_input">
								<input type="text" class="form-control col-lg-12" name="autor"
									id="autor" title="Introduce un autor"
									placeholder="¿Quién lo escribió?" />
							</div>
						</div>
	
						<!-- EDITORIAL -->
						<div class="form-group" id="group_edit">
							<label for="edit" class="form_label"></label>
							<div class="form-group_input">
								<input type="text" class="form-control col-lg-12"
									name="editorial" id="editorial"
									title="Introduce la editorial del libro"
									placeholder="Introduce Editorial" />
							</div>
						</div>
	
						<!-- ISBN -->
						<div class="form-group" id="group_isbn">
							<label for="isbn" class="form_label"></label>
							<div class="form-group_input">
								<input type="text" class="form-control col-lg-12" name="isbn"
									id="isbn" title="Introduce el ISBN del libro" placeholder="ISBN" />
							</div>
						</div>
	
						<!-- AÑO PUBLICACION -->
						<div class="form-group" id="group_publi">
							<label for="publi" class="form_label"></label>
							<div class="form-group_input">
								<input type="text" class="form-control col-lg-12" name="publi"
									value="0" id="publi" pattern="[0-9]{4}"
									title="ESCRIBE EL AÑO COMPLETO (cuatro dígitos)"
									placeholder="Año de publicación" />
							</div>
						</div>
	
						<!-- PRECIO -->
						<div class="form-group" id="group_precio">
							<label for="precio" class="form_label"></label>
							<div class="form-group_input">
								<input type="text" class="form-control col-lg-12" name="precio"
									value="0" id="precio" pattern="[0-9]+\.?|\,?[0-9]{0,2}"
									title="Introduce el precio (sólo números)"
									placeholder="Precio €" />
							</div>
						</div>
	
						<!-- DESCRIPCION -->
						<div class="form-group" id="group_descrip">
							<label for="descrip" class="form_label"></label>
							<div class="form-group_input">
								<input type="text" class="form-control" name="descrip"
									id="descrip" title="Introduce el género del libro"
									placeholder="¿Género?" />
							</div>
						</div>
	
						<!-- ENVIAR -->
						<div class="form-group form-group-btn-enviar">
							<input type="hidden" name="op" value="2" /> 
							<input type="submit" class="form_btn submit col-lg-12" 
								value="Añadir Libro" id="submit"
								title="Vas a añadir un libro" onclick="validarFormulario()" />
						</div>
						 <div>${requestScope.validaciones}</div>
					</form>
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