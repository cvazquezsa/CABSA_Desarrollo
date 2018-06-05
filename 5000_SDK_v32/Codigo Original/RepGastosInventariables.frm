
[Forma]
Clave=RepGastosInventariables
Icono=0
Nombre=RepGastosInventariables

ListaCarpetas=RepGastosInventariables
CarpetaPrincipal=RepGastosInventariables
PosicionInicialAlturaCliente=116
PosicionInicialAncho=241
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=391
PosicionInicialArriba=309
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)



[ReporteGastosInventariables.Columnas]
InfoFechaA=94
InfoConcepto=304






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

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=RepGastosInventariables
Activo=S
Visible=S



NombreEnBoton=S














































[ReporteGastosInventariables.ListaEnCaptura]
(Inicio)=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoConcepto
RepParam.InfoConcepto=(Fin)




[RepGastosInventariables]
Estilo=Ficha
Clave=RepGastosInventariables
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepGastosInventariables
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
CarpetaVisible=S



ListaEnCaptura=(Lista)


Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[RepGastosInventariables.RepParam.InfoFechaA]
Carpeta=RepGastosInventariables
Clave=RepParam.InfoFechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepGastosInventariables.RepParam.InfoConcepto]
Carpeta=RepGastosInventariables
Clave=RepParam.InfoConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[RepGastosInventariables.ListaEnCaptura]
(Inicio)=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoConcepto
RepParam.InfoConcepto=(Fin)















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=RepPan
RepPan=(Fin)
