[Forma]
Clave=InformeVentaNeta
Nombre=Ventas
Icono=18
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=RepParam
PosicionInicialIzquierda=643
PosicionInicialArriba=335
PosicionInicialAltura=146
PosicionInicialAncho=258
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDivision=S
VentanaExclusiva=S
AccionesCentro=S
BarraHerramientas=S
ListaAcciones=(Lista)
VentanaEscCerrar=S

PosicionInicialAlturaCliente=161

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=AUTOEXEC
[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.Ventas]
Carpeta=(Variables)
Clave=Rep.Ventas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
Activo=S
Visible=S


GuardarAntes=S
TipoAccion=Expresion
Expresion=Asigna(RepParam:RepParam.RepTitulo, <T>Ventas<T>)<BR>GuardarCambios<BR>Informe( <T>InformeVentaNeta<T>, RepParam:RepParam.RepTitulo)
[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.Imprimir.VentaNeta]
Nombre=VentaNeta
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=VentaNeta
Activo=S
Visible=S


[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Rep.Ventas
Rep.Ventas=(Fin)




[RepParam]
Estilo=Ficha
Clave=RepParam
Filtros=S
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PestanaOtroNombre=S
Pestana=S
PestanaNombre=Filtros
FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[RepParam.RepParam.InfoFechaD]
Carpeta=RepParam
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[RepParam.RepParam.InfoFechaA]
Carpeta=RepParam
Clave=RepParam.InfoFechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[RepParam.RepParam.InfoRepVentas]
Carpeta=RepParam
Clave=RepParam.InfoRepVentas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=21
ColorFondo=Blanco






[Grafica]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Grafica
Clave=Grafica
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=123
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=RepParam.Estacion = { EstacionTrabajo }
[Grafica.RepParam.InformeGraficarFecha]
Carpeta=Grafica
Clave=RepParam.InformeGraficarFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco


[Grafica.RepParam.InfoEtiqueta]
Carpeta=Grafica
Clave=RepParam.InfoEtiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoRepVentas
RepParam.InfoRepVentas=(Fin)








[Grafica.RepParam.VerGraficaDetalle]
Carpeta=Grafica
Clave=RepParam.VerGraficaDetalle
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S


[Grafica.ListaEnCaptura]
(Inicio)=RepParam.InformeGraficarFecha
RepParam.InformeGraficarFecha=RepParam.InfoEtiqueta
RepParam.InfoEtiqueta=RepParam.VerGraficaDetalle
RepParam.VerGraficaDetalle=(Fin)



[Forma.ListaCarpetas]
(Inicio)=RepParam
RepParam=Grafica
Grafica=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=(Fin)
