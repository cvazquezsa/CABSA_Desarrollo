[Forma]
Clave=InformeCorteCaja
Nombre=Corte de Caja
Icono=18
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=RepParam
PosicionInicialIzquierda=360
PosicionInicialArriba=229
PosicionInicialAltura=146
PosicionInicialAncho=303
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
AccionesDivision=S
VentanaExclusiva=S
AccionesCentro=S
BarraHerramientas=S
ListaAcciones=(Lista)
VentanaEscCerrar=S


PosicionInicialAlturaCliente=183
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
Tamano=21
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=21
ColorFondo=Blanco

[(Variables).Rep.Compras]
Carpeta=(Variables)
Clave=Rep.Compras
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=21
ColorFondo=Blanco

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
ConCondicion=S
EjecucionConError=S
Expresion=Asigna(RepParam:RepParam.RepTitulo, <T>Corte Caja<T>)<BR>GuardarCambios<BR><BR>Si<BR>SQL(<T>IF EXISTS(SELECT * FROM Dinero d JOIN MovTipo mt ON d.Mov = mt.Mov AND mt.Modulo = :tModulo<BR>                  WHERE d.ID IN(SELECT DISTINCT Corte FROM Dinero WHERE Corte IS NOT NULL)<BR>                  AND d.Corte IS NOT NULL<BR>                  AND mt.Clave = :tClave<BR>                  AND mt.SubClave IS NULL<BR>                  AND d.CtaDinero = :tCaja<BR>                  AND d.FechaEmision = :tFecha<BR>                  AND d.Estatus = :tEstatus<BR>         ) SELECT 0 ELSE SELECT 1<T>, <T>DIN<T>, <T>DIN.C<T>, RepParam:RepParam.InfoCaja,  FechaFormatoServidor(RepParam:RepParam.InfoFechaDia), <T>CONCLUIDO<T>)=0<BR>Entonces<BR>  Informe( <T>InformeCorteCaja<T>,RepParam:RepParam.RepTitulo)<BR>Sino                                                                                <BR>  Error(<T>No hay cortes para la caja <T> + RepParam:RepParam.InfoCaja + <T> para la fecha <T> + RepParam:RepParam.InfoFechaDia)<BR>Fin
EjecucionCondicion=ConDatos(RepParam:RepParam.InfoCaja)
EjecucionMensaje=<T>Caja Campo Requerido<T>
[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S


[Acciones.Imprimir.CompraArtCat]
Nombre=CompraArtCat
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=CompraArtCat
Activo=S
Visible=S


[RepParam]
Estilo=Ficha
Clave=RepParam
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
CarpetaVisible=S
ListaEnCaptura=(Lista)


PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PestanaNombre=Filtros

Pestana=S

FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Rep.Compras
Rep.Compras=(Fin)






[Grafica]
Estilo=Ficha
Pestana=S
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
FichaEspacioNombres=111
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
PestanaOtroNombre=S
PestanaNombre=Grafica

CarpetaVisible=S

FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[Grafica.RepParam.InformeGraficarTipo]
Carpeta=Grafica
Clave=RepParam.InformeGraficarTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Grafica.RepParam.InformeGraficarCantidad]
Carpeta=Grafica
Clave=RepParam.InformeGraficarCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






















































































[Lista.Columnas]
0=84
1=111










2=-2


[RepParam.RepParam.InfoCaja]
Carpeta=RepParam
Clave=RepParam.InfoCaja
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoCajero]
Carpeta=RepParam
Clave=RepParam.InfoCajero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[Grafica.ListaEnCaptura]
(Inicio)=RepParam.InformeGraficarTipo
RepParam.InformeGraficarTipo=RepParam.InformeGraficarCantidad
RepParam.InformeGraficarCantidad=(Fin)












[RepParam.RepParam.InfoFechaDia]
Carpeta=RepParam
Clave=RepParam.InfoFechaDia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




































































































[RepParam.RepParam.InfoCorte]
Carpeta=RepParam
Clave=RepParam.InfoCorte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoFechaDia
RepParam.InfoFechaDia=RepParam.InfoCaja
RepParam.InfoCaja=RepParam.InfoCajero
RepParam.InfoCajero=RepParam.InfoCorte
RepParam.InfoCorte=(Fin)

















































































































































































[Forma.ListaCarpetas]
(Inicio)=RepParam
RepParam=Grafica
Grafica=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=(Fin)
