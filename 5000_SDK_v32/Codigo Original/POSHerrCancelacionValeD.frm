
[Forma]
Clave=POSHerrCancelacionValeD
Icono=0
CarpetaPrincipal=POSHerrCancelacionValeD
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=POSHerrCancelacionValeD
PosicionInicialIzquierda=519
PosicionInicialArriba=283
PosicionInicialAlturaCliente=122
PosicionInicialAncho=328
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=Cancelación Monedero
[POSHerrCancelacionValeD]
Estilo=Ficha
Clave=POSHerrCancelacionValeD
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSHerrCancelacionValeD
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
ListaEnCaptura=POSHerrCancelacionValeD.Tipo

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=POSHerrCancelacionValeD.Estacion = {EstacionTrabajo}
[POSHerrCancelacionValeD.ListaEnCaptura]
(Inicio)=POSHerrCancelacionValeD.Tipo
POSHerrCancelacionValeD.Tipo=POSHerrCancelacionValeD.Fecha
POSHerrCancelacionValeD.Fecha=(Fin)

[POSHerrCancelacionValeD.POSHerrCancelacionValeD.Tipo]
Carpeta=POSHerrCancelacionValeD
Clave=POSHerrCancelacionValeD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Acciones.Expresion.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


[Acciones.Expresion.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)






[Acciones.POSHerrCancelacionVale]
Nombre=POSHerrCancelacionVale
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSHerrCancelacionVale
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S







EspacioPrevio=S



























[Acciones.POSHerrCancelacionVale.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=EjecutarSQL(<T>spPOSInsertaHerrCancelarVale :nEstacion, :tTipo, :tFecha<T>,EstacionTrabajo,POSHerrCancelacionValeD:POSHerrCancelacionValeD.Tipo,NULO)<BR>FormaModal(<T>POSHerrCancelacionVale<T>)
[POSHerrCancelacionVale.Columnas]
0=-2
1=213
2=169
3=181
4=-2

[Acciones.POSHerrCancelacionVale.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.POSHerrCancelacionVale.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)















[Forma.ListaAcciones]
(Inicio)=POSHerrCancelacionVale
POSHerrCancelacionVale=Cerrar
Cerrar=(Fin)
