<nav class="navbar navbar-default">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
		
					<a class="navbar-brand" href="#">
					<img src="recursos/image/menu_logo.png" alt="" style="height: 35px;"  />
				</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
		
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">Contratos <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="listacontratos">Listado de Contratos</a></li>
					</ul></li>
													
			</ul>

			
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false"><img alt="" src="recursos/image/user.png" width="20" height="20">${session.usuario} <span class="caret"></span></a>
					<ul class="dropdown-menu">
						
						<li><a href="logOut" title="Cerrar Session de usuario">Cerrar </a></li>
					</ul></li>
				
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>