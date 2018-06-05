[Forma]
Clave=SATMunicipio
Nombre=Catálogo de Municipios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=385
PosicionInicialArriba=127
PosicionInicialAltura=346
PosicionInicialAncho=501
PosicionInicialAlturaCliente=421

ListaAcciones=Cerrar
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATMunicipio
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
OtroOrden=S
ListaOrden=(Lista)






[Lista.Columnas]
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Fecha=122

ClaveMunicipio=108
ClaveEstado=111
Descripcion=205

[Lista.SATMunicipio.ClaveMunicipio]
Carpeta=Lista
Clave=SATMunicipio.ClaveMunicipio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.SATMunicipio.ClaveEstado]
Carpeta=Lista
Clave=SATMunicipio.ClaveEstado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.SATMunicipio.Descripcion]
Carpeta=Lista
Clave=SATMunicipio.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco











[Lista.ListaEnCaptura]
(Inicio)=SATMunicipio.ClaveMunicipio
SATMunicipio.ClaveMunicipio=SATMunicipio.ClaveEstado
SATMunicipio.ClaveEstado=SATMunicipio.Descripcion
SATMunicipio.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=SATMunicipio.ClaveEstado	(Acendente)
SATMunicipio.ClaveEstado	(Acendente)=SATMunicipio.ClaveMunicipio	(Acendente)
SATMunicipio.ClaveMunicipio	(Acendente)=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

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
