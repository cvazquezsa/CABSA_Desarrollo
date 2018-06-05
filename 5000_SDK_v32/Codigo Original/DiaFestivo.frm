[Forma]
Clave=DiaFestivo
Nombre=Días Festivos (Generales)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=423
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=433
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DiaFestivo
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

[Lista.DiaFestivo.Fecha]
Carpeta=Lista
Clave=DiaFestivo.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DiaFestivo.Concepto]
Carpeta=Lista
Clave=DiaFestivo.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[Lista.Columnas]
Fecha=86
Concepto=248
EsLaborable=68

[Lista.DiaFestivo.EsLaborable]
Carpeta=Lista
Clave=DiaFestivo.EsLaborable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=DiaFestivo.Fecha
DiaFestivo.Fecha=DiaFestivo.Concepto
DiaFestivo.Concepto=DiaFestivo.EsLaborable
DiaFestivo.EsLaborable=(Fin)
