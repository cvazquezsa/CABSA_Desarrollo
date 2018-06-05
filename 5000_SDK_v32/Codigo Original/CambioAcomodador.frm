
[Forma]
Clave=CambioAcomodador
Icono=44
Modulos=(Todos)

ListaCarpetas=vTMAOtro
CarpetaPrincipal=vTMAOtro
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
BarraHerramientas=S
Nombre=<T>Cambio Acomodador<T>
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=650
PosicionInicialArriba=378
PosicionInicialAlturaCliente=105
PosicionInicialAncho=299
ListaAcciones=Seleccionar
VentanaExclusiva=S
Comentarios=Info.Mov + <T> <T> + Info.MovID
[vTMAOtro]
Estilo=Ficha
Clave=vTMAOtro
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TMA
Fuente={Tahoma, 8, Negro, []}
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TMA.Agente

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

PermiteEditar=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S





FiltroGeneral=TMA.ID = <T>{Info.ID}<T>
[vTMAOtro.Columnas]
0=-2
1=-2
2=-2
3=-2
4=-2
5=-2


[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S





Multiple=S
ListaAccionesMultiples=(Lista)
GuardarAntes=S
[vTMAOtro.ListaEnCaptura]
(Inicio)=vTMAOtro.Mov
vTMAOtro.Mov=vTMAOtro.MovID
vTMAOtro.MovID=vTMAOtro.Articulo
vTMAOtro.Articulo=vTMAOtro.CantidadPicking
vTMAOtro.CantidadPicking=vTMAOtro.Almacen
vTMAOtro.Almacen=(Fin)

[Acciones.Seleccionar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>EXEC spWMSActualizarMontacargaDetalle :nID, :tMontacarga<T>, TMA:TMA.ID, TMA:TMA.Agente)<BR>ActualizarForma
[Acciones.Seleccionar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[vTMAOtro.TMA.Agente]
Carpeta=vTMAOtro
Clave=TMA.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S

[Lista.Columnas]
0=105
1=247

















[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)
