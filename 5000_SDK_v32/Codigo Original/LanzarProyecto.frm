[Forma]
Clave=LanzarProyecto
Nombre=Lanzar Proyecto
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=211
PosicionInicialAncho=459
IniciarAgregando=S
PosicionInicialIzquierda=730
PosicionInicialArriba=476
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=EjecutarSQL(<T>spListaStBorrar :nEstacion<T>, EstacionTrabajo)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=LanzarProyecto
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.LanzarProyecto.Fecha]
Carpeta=Ficha
Clave=LanzarProyecto.Fecha
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
IgnoraFlujo=N

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[(Carpeta Abrir).LanzarProyecto.Fecha]
Carpeta=(Carpeta Abrir)
Clave=LanzarProyecto.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=623
1=91

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Ficha.LanzarProyecto.Grupo]
Carpeta=Ficha
Clave=LanzarProyecto.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LanzarProyecto.Mov]
Carpeta=Ficha
Clave=LanzarProyecto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.LanzarProyecto.Proyecto]
Carpeta=Ficha
Clave=LanzarProyecto.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.LanzarProyecto.UEN]
Carpeta=Ficha
Clave=LanzarProyecto.UEN
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.UEN.Nombre]
Carpeta=Ficha
Clave=UEN.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=69
NombreEnBoton=S
NombreDesplegar=&Seleccionar Clientes
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Forma(<T>CteProcesar<T>)

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Movimientos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
GuardarAntes=S
Expresion=ProcesarSQL(<T>xpLanzarProyecto :nID, :nEstacion, :tEmpresa, :nSucursal, :tUsuario, :fFecha, :tMov, :tProyecto, :nUEN, :tAsunto<T>, LanzarProyecto:LanzarProyecto.ID, EstacionTrabajo, Empresa, Sucursal, Usuario, LanzarProyecto:LanzarProyecto.Fecha, LanzarProyecto:LanzarProyecto.Mov, LanzarProyecto:LanzarProyecto.Proyecto, LanzarProyecto:LanzarProyecto.UEN, LanzarProyecto:LanzarProyecto.Asunto)
EjecucionCondicion=ConDatos(LanzarProyecto:LanzarProyecto.Asunto) y ConDatos(LanzarProyecto:LanzarProyecto.Mov)

[Acciones.ListaCorreos]
Nombre=ListaCorreos
Boton=84
NombreEnBoton=S
NombreDesplegar=&Lista Correos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=VerComentario(<T>Lista de Correos<T>, SQLEnLista(<T>xpLanzarProyectoLista :nID, :nEstacion, :tGrupo<T>, LanzarProyecto:LanzarProyecto.ID, EstacionTrabajo, LanzarProyecto:LanzarProyecto.Grupo))

[Ficha.LanzarProyecto.Asunto]
Carpeta=Ficha
Clave=LanzarProyecto.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Seleccionar
Seleccionar=ListaCorreos
ListaCorreos=Generar
Generar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=LanzarProyecto.Grupo
LanzarProyecto.Grupo=LanzarProyecto.Mov
LanzarProyecto.Mov=LanzarProyecto.Fecha
LanzarProyecto.Fecha=LanzarProyecto.Proyecto
LanzarProyecto.Proyecto=LanzarProyecto.UEN
LanzarProyecto.UEN=UEN.Nombre
UEN.Nombre=LanzarProyecto.Asunto
LanzarProyecto.Asunto=(Fin)
