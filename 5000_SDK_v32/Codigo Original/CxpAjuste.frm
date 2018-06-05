[Forma]
Clave=CxpAjuste
Nombre=<T>Ajustes (Cxp)<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=385
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=371
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Mon
Fuente={MS Sans Serif, 8, Negro, []}
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

[Lista.Mon.Moneda]
Carpeta=Lista
Clave=Mon.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mon.CxpAjusteRedondeo]
Carpeta=Lista
Clave=Mon.CxpAjusteRedondeo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Moneda=124
CxpAjusteRedondeo=99
CxpEliminarSaldosMenores=118

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Mon.CxpEliminarSaldosMenores]
Carpeta=Lista
Clave=Mon.CxpEliminarSaldosMenores
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=Mon.Moneda
Mon.Moneda=Mon.CxpEliminarSaldosMenores
Mon.CxpEliminarSaldosMenores=Mon.CxpAjusteRedondeo
Mon.CxpAjusteRedondeo=(Fin)
