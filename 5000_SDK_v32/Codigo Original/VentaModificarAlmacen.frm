[Forma]
Clave=VentaModificarAlmacen
Nombre=Modificar el Almacén
Icono=0
Modulos=(Todos)
CarpetaPrincipal=(Variables)
ListaCarpetas=(Variables)
PosicionInicialIzquierda=363
PosicionInicialArriba=325
PosicionInicialAltura=117
PosicionInicialAncho=298
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
Comentarios=Info.Mov+<T> <T>+Info.MovID
ExpresionesAlMostrar=Asigna(Info.Almacen, Nulo)<BR>Asigna(Info.Reservar, Si(Config.PedidosReservar, <T>Si<T>, <T>No<T>))

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.Almacen]
Carpeta=(Variables)
Clave=Info.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[(Variables).Info.Reservar]
Carpeta=(Variables)
Clave=Info.Reservar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=15

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=<T>&Afectar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
ListaAccionesMultiples=Variables Asignar<BR>Verificar<BR>Aceptar
Activo=S
Visible=S

[Acciones.Afectar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Afectar.Verificar]
Nombre=Verificar
Boton=0
TipoAccion=Expresion
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
Expresion=ProcesarSQL(<T>spModificarAlmacenPedidos :nID, :tAlmacen, :tReservar<T>, Info.ID, Info.Almacen, Info.Reservar)
EjecucionCondicion=SQL(<T>SELECT Almacen FROM Alm WHERE Almacen = :tAlmacen<T>, Info.Almacen) <> Nulo
EjecucionMensaje=<T>El Almacén Indicado No Existe<T>

[Acciones.Afectar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Afectar
Afectar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Almacen
Info.Almacen=Info.Reservar
Info.Reservar=(Fin)
