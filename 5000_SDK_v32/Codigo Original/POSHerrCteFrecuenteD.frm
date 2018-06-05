
[Forma]
Clave=POSHerrCteFrecuenteD
Icono=0
CarpetaPrincipal=POSHerrCteFrecuenteD
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=POSHerrCteFrecuenteD
PosicionInicialIzquierda=410
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=546
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=Cliente Frecuente Detalle
[POSHerrCteFrecuenteD]
Estilo=Hoja
Clave=POSHerrCteFrecuenteD
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSHerrCteFrecuente
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSHerrCteFrecuente.Estacion = {EstacionTrabajo}
[POSHerrCteFrecuenteD.POSHerrCteFrecuente.Cliente]
Carpeta=POSHerrCteFrecuenteD
Clave=POSHerrCteFrecuente.Cliente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[POSHerrCteFrecuenteD.POSHerrCteFrecuente.Monedero]
Carpeta=POSHerrCteFrecuenteD
Clave=POSHerrCteFrecuente.Monedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[POSHerrCteFrecuenteD.Columnas]
Cliente=83
Monedero=173

Nombre=242

[POSHerrCteFrecuenteD.Cte.Nombre]
Carpeta=POSHerrCteFrecuenteD
Clave=Cte.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar/Cancelar Cambios]
Nombre=Cancelar/Cancelar Cambios
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S






[POSHerrCteFrecuenteD.ListaEnCaptura]
(Inicio)=POSHerrCteFrecuente.Cliente
POSHerrCteFrecuente.Cliente=Cte.Nombre
Cte.Nombre=POSHerrCteFrecuente.Monedero
POSHerrCteFrecuente.Monedero=(Fin)





























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar/Cancelar Cambios
Cancelar/Cancelar Cambios=(Fin)
