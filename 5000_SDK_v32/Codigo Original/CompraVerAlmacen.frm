[Forma]
Clave=CompraVerAlmacen
Nombre=Ver Almacén Especifico
Icono=0
Modulos=(Todos)
PosicionInicialAlturaCliente=364
PosicionInicialAncho=500
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=390
PosicionInicialArriba=316
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CompraVerAlmacen
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

[Lista.Almacen]
Carpeta=Lista
Clave=Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Nombre]
Carpeta=Lista
Clave=Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Almacen=95
Nombre=376

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(CompraVerAlmacen:Almacen)
AntesExpresiones=Asigna(Ver.Almacen, CompraVerAlmacen:Almacen)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=23
NombreEnBoton=S
NombreDesplegar=&Todo
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Ver.Almacen, Nulo)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Todo
Todo=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Almacen
Almacen=Nombre
Nombre=(Fin)
