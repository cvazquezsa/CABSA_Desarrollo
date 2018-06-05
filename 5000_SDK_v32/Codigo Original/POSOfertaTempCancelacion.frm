
[Forma]
Clave=POSOfertaTempCancelacion
Icono=0
CarpetaPrincipal=POSOfertaTempCancelacion
Modulos=(Todos)
Nombre=Cancelar Ofertas Puntos/Importe

ListaCarpetas=POSOfertaTempCancelacion
PosicionInicialIzquierda=481
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=692
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(<T>Monedero: <T>+Info.POSMonedero,<T>Saldo Disponible: $<T>+Info.Disponible)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=EjecutarSQL(<T>spPOSInsertarOfertaTempCancelacion :nEstacion, :tID<T>,EstacionTrabajo, Info.IDTexto)
[POSOfertaTempCancelacion]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Articulos
Clave=POSOfertaTempCancelacion
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSOfertaTempCancelacion
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Articulo<T>
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
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

MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=POSOfertaTempCancelacion:POSOfertaTempCancelacion.Articulo
FiltroGeneral=POSOfertaTempCancelacion.Estacion = {EstacionTrabajo} AND<BR>POSOfertaTempCancelacion.IDR =<T>{Info.IDTexto}<T>
[POSOfertaTempCancelacion.POSOfertaTempCancelacion.PrecioSugerido]
Carpeta=POSOfertaTempCancelacion
Clave=POSOfertaTempCancelacion.PrecioSugerido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[POSOfertaTempCancelacion.POSOfertaTempCancelacion.Puntos]
Carpeta=POSOfertaTempCancelacion
Clave=POSOfertaTempCancelacion.Puntos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=0
[POSOfertaTempCancelacion.Columnas]
0=135
1=96
2=103
3=84

4=66
5=78
6=105

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si<BR>  CuantosSeleccionID(<T>POSOfertaTempCancelacion<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSOfertaTempCancelacion<T>)<BR>  EjecutarSQL(<T>spPOSCancelarOfertaPuntos :nEstacion, :tID<T>,EstacionTrabajo,Info.IDTexto)<BR>Fin
[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aplicar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

EspacioPrevio=S
[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






















































[POSOfertaTempCancelacion.POSOfertaTempCancelacion.Cantidad]
Carpeta=POSOfertaTempCancelacion
Clave=POSOfertaTempCancelacion.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSOfertaTempCancelacion.PuntosUnitario]
Carpeta=POSOfertaTempCancelacion
Clave=PuntosUnitario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSOfertaTempCancelacion.Total(Importe)]
Carpeta=POSOfertaTempCancelacion
Clave=Total(Importe)
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=TotalPunto
Totalizadores2=Suma(POSOfertaTempCancelacion:POSOfertaTempCancelacion.Puntos)
Totalizadores3=(Cantidades)
Totalizadores=S
TotExpresionesEnSumas=S
TotAlCambiar=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=TotalPunto
CarpetaVisible=S

[(Carpeta Totalizadores).TotalPunto]
Carpeta=(Carpeta Totalizadores)
Clave=TotalPunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata







[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S






[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=EjecutarSQL(<T>spPOSOfertaAplicar :tID<T>,Info.IDTexto)<BR>Si<BR>  CuantosSeleccionID(<T>POSOfertaTempCancelacion<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSOfertaTempCancelacion<T>)<BR> Asigna(Info.Condicion,SQL(<T>SELECT dbo.fnPOSValidarImporteMonedero(:tID,:nEstacion,:nDisponible)<T>,Info.IDTexto,EstacionTrabajo,Info.Disponible))<BR>  Si<BR>    Vacio(Info.Condicion)<BR>  Entonces<BR>    EjecutarSQL(<T>spPOSOfertaPuntosAplicar :tID,:tFecha,:nPuntos,:nEstacion<T>,Info.IDTexto,Nulo,1,EstacionTrabajo)<BR>  SiNo<BR>    Informacion(Info.Condicion)<BR>  Fin<BR>Fin
Activo=S
Visible=S


[Acciones.Cancelar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S






[POSOfertaTempCancelacionD.Columnas]
Articulo=124
Precio=64
Puntos=83
CantidadO=86
CantidadM=101
PuntosUsar=82
ImporteTotal=69






[Acciones.Modificar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Si<BR>  CuantosSeleccionID(<T>POSOfertaTempCancelacion<T>)>0<BR>Entonces<BR>  RegistrarSeleccionID(<T>POSOfertaTempCancelacion<T>)<BR>  EjecutarSQL(<T>spPOSModificarOfertaTemp :nEstacion, :tID<T>,EstacionTrabajo,Info.IDTexto)<BR>  FormaModal(<T>POSOfertaTempCancelacionD<T>)<BR>Fin
Activo=S
Visible=S

[Acciones.Modificar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Modificar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
















[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
















[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)













[POSOfertaTempCancelacion.ListaEnCaptura]
(Inicio)=POSOfertaTempCancelacion.Cantidad
POSOfertaTempCancelacion.Cantidad=POSOfertaTempCancelacion.PrecioSugerido
POSOfertaTempCancelacion.PrecioSugerido=POSOfertaTempCancelacion.Precio
POSOfertaTempCancelacion.Precio=PuntosUnitario
PuntosUnitario=POSOfertaTempCancelacion.Puntos
POSOfertaTempCancelacion.Puntos=Total(Importe)
Total(Importe)=(Fin)

[POSOfertaTempCancelacion.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)

[POSOfertaTempCancelacion.POSOfertaTempCancelacion.Precio]
Carpeta=POSOfertaTempCancelacion
Clave=POSOfertaTempCancelacion.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=(Fin)
