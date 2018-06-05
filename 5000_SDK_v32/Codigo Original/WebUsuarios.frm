[Forma]
Clave=WebUsuarios
Nombre=Usuarios eCommerce
Icono=0
CarpetaPrincipal=WebUsuarios
Modulos=(Todos)
ListaCarpetas=WebUsuarios
PosicionInicialIzquierda=470
PosicionInicialArriba=244
PosicionInicialAlturaCliente=368
PosicionInicialAncho=699
DialogoAbrir=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[WebUsuarios]
Estilo=Ficha
Clave=WebUsuarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebUsuarios
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=WebUsuarios.Nombre<BR>WebUsuarios.Apellido<BR>WebUsuarios.eMail<BR>WebUsuarios.eMail2<BR>WebUsuarios.Cliente<BR>Cte.Nombre<BR>WebUsuarios.Telefono<BR>WebUsuarios.Contrasena<BR>WebUsuarios.ContrasenaConfirmacion
CarpetaVisible=S
[WebUsuarios.WebUsuarios.Nombre]
Carpeta=WebUsuarios
Clave=WebUsuarios.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarios.WebUsuarios.Apellido]
Carpeta=WebUsuarios
Clave=WebUsuarios.Apellido
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarios.WebUsuarios.eMail]
Carpeta=WebUsuarios
Clave=WebUsuarios.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarios.WebUsuarios.Contrasena]
Carpeta=WebUsuarios
Clave=WebUsuarios.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
EspacioPrevio=S
[WebUsuarios.WebUsuarios.Telefono]
Carpeta=WebUsuarios
Clave=WebUsuarios.Telefono
Editar=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=WebUsuariosA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Nombre<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=WebUsuarios.ID<TAB>(Acendente)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroEmpresas=S
FiltroSucursales=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Usuario eCommerce
BusquedaRapida=S
BusquedaEnLinea=S
IconosConPaginas=S
IconosNombre=WebUsuariosA:WebUsuarios.Nombre
[(Carpeta Abrir).WebUsuarios.Apellido]
Carpeta=(Carpeta Abrir)
Clave=WebUsuarios.Apellido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
[(Carpeta Abrir).Columnas]
0=116
1=379
2=-2
[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=SI Confirmacion(<T>Al crear un Usuario Web en la tienda, éste tendrá acceso a todas las Sucursales del Cliente que asignó. Está seguro de esto?<T>,BotonAceptar,BotonCancelar) = BotonAceptar Entonces<BR>    GuardarCambios<BR>    EJECUTARSQL(<T>EXEC speCommerceWebUsuarioNuevaDireccion :tCliente<T>, WebUsuarios:WebUsuarios.Cliente)<BR>Fin
[Acciones.Documento Nuevo]
Nombre=Documento Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S
[Acciones.Documento Abrir]
Nombre=Documento Abrir
Boton=2
NombreDesplegar=&Abrir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S
[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
EspacioPrevio=S
[WebUsuarios.WebUsuarios.Cliente]
Carpeta=WebUsuarios
Clave=WebUsuarios.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S
[WebUsuarios.WebUsuarios.eMail2]
Carpeta=WebUsuarios
Clave=WebUsuarios.eMail2
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
[WebUsuarios.WebUsuarios.ContrasenaConfirmacion]
Carpeta=WebUsuarios
Clave=WebUsuarios.ContrasenaConfirmacion
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S
[WebUsuarios.Cte.Nombre]
Carpeta=WebUsuarios
Clave=Cte.Nombre
Editar=S
ValidaNombre=N
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro
Pegado=S






[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107


















































[Acciones.Navegador 1 (Registros)]
Nombre=Navegador 1 (Registros)
Boton=0
NombreDesplegar=Navegador 1 (Registros)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Activo=S
Visible=S



















[(Carpeta Abrir).WebUsuarios.Cliente]
Carpeta=(Carpeta Abrir)
Clave=WebUsuarios.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=WebUsuarios.Apellido
WebUsuarios.Apellido=WebUsuarios.Cliente
WebUsuarios.Cliente=(Fin)



[Forma.ListaAcciones]
(Inicio)=Documento Nuevo
Documento Nuevo=Documento Abrir
Documento Abrir=Guardar Cambios
Guardar Cambios=Registro Eliminar
Registro Eliminar=Navegador 1 (Registros)
Navegador 1 (Registros)=(Fin)
