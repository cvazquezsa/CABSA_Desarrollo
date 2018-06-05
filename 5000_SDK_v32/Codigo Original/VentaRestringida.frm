[Forma]
Clave=VentaRestringida
Nombre=Venta Restringida (Fechas/Horas)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=218
PosicionInicialArriba=208
PosicionInicialAltura=345
PosicionInicialAncho=588
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=318
Comentarios=Empresa

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaRestringida
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
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=VentaRestringida.Empresa=<T>{Empresa}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.VentaRestringida.Agrupador]
Carpeta=Lista
Clave=VentaRestringida.Agrupador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaRestringida.Nombre]
Carpeta=Lista
Clave=VentaRestringida.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Agrupador=113
Nombre=199
CostoVenta=99
CostoInv=123
CostoCompra=109
Moneda=56
PorcentajeVenta=74
PorcentajeInv=73
PorcentajeCompra=64
FechaD=118
FechaA=126

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

[Lista.VentaRestringida.FechaD]
Carpeta=Lista
Clave=VentaRestringida.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VentaRestringida.FechaA]
Carpeta=Lista
Clave=VentaRestringida.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=VentaRestringida.Agrupador
VentaRestringida.Agrupador=VentaRestringida.Nombre
VentaRestringida.Nombre=VentaRestringida.FechaD
VentaRestringida.FechaD=VentaRestringida.FechaA
VentaRestringida.FechaA=(Fin)
