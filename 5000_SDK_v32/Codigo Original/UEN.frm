[Forma]
Clave=UEN
Nombre=Unidades Estratégicas Negocio (UEN<T>s)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=649
PosicionInicialArriba=405
PosicionInicialAlturaCliente=354
PosicionInicialAncho=621
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UEN
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.UEN.UEN]
Carpeta=Lista
Clave=UEN.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UEN.Nombre]
Carpeta=Lista
Clave=UEN.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
UEN=44
Nombre=269
VentaLimiteRenFacturas=174
Estatus=94

[Acciones.Tareas]
Nombre=Tareas
Boton=70
NombreEnBoton=S
NombreDesplegar=&Tareas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Tarea
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(UEN:UEN.UEN)
Antes=S
AntesExpresiones=Asigna(Info.PuedeEditar, Verdadero)<BR>Asigna(Info.Nombre, UEN:UEN.Nombre)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Proveedor, Nulo)<BR>Asigna(Info.Agente, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.Proyecto, Nulo)<BR>Asigna(Info.UEN, UEN:UEN.UEN)<BR>Asigna(Info.Modulo, Nulo)<BR>Asigna(Info.ID, Nulo)<BR>Asigna(Info.Reporte, Nulo)
Visible=S

[Lista.UEN.VentaLimiteRenFacturas]
Carpeta=Lista
Clave=UEN.VentaLimiteRenFacturas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UEN.Estatus]
Carpeta=Lista
Clave=UEN.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tareas
Tareas=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=UEN.UEN
UEN.UEN=UEN.Nombre
UEN.Nombre=UEN.VentaLimiteRenFacturas
UEN.VentaLimiteRenFacturas=UEN.Estatus
UEN.Estatus=(Fin)
