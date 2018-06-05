
[Forma]
Clave=RepAsisteNoReportaAsistencia
Icono=0
Modulos=(Todos)
Nombre=No Reporta Asistencia

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=159
PosicionInicialAncho=236
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=394
PosicionInicialArriba=287
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
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

[Lista.RepParam.InfoFechaD]
Carpeta=Lista
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

Tamano=20
[Lista.RepParam.InfoFechaA]
Carpeta=Lista
Clave=RepParam.InfoFechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


Tamano=20
[Lista.RepParam.InfoSucursal]
Carpeta=Lista
Clave=RepParam.InfoSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S
Tamano=20
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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=46
NombreEnBoton=S
NombreDesplegar=&Imprimir
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Impresora
ClaveAccion=AsisteNoReportaAsistencia
Activo=S
Visible=S




[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=AsisteNoReportaAsistencia
Activo=S
Visible=S







[Lista.RepParam.InfoReportaA]
Carpeta=Lista
Clave=RepParam.InfoReportaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S

[Lista.Columnas]
0=106
1=301

[Lista.ListaEnCaptura]
(Inicio)=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoReportaA
RepParam.InfoReportaA=RepParam.InfoSucursal
RepParam.InfoSucursal=(Fin)



























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
