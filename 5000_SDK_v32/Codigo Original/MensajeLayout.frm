[Forma]
Clave=MensajeLayout
Nombre=Mensajes del Layout
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=413
PosicionInicialArriba=159
PosicionInicialAltura=418
PosicionInicialAncho=773
Comentarios=Info.Clave
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=513
PosicionSec1=451


PosicionCol1=173
Totalizadores=S
PosicionSec2=244
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Lista.Columnas]
Mensaje=84
Descripcion=320
ConciliarMismaFecha=108
ConciliarAuto=131
ConciliarTipo=142
Tipo=92
Movimiento=125
TipoMovimiento=89
ConceptoGasto=114
PermiteAbonoNoIdentificado=171
Clasificacion=184

Layout=124
[Ficha.MensajeLayout.ConceptoGasto]
Carpeta=Ficha
Clave=MensajeLayout.ConceptoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MensajeLayout.PermiteAbonoNoIdentificado]
Carpeta=Ficha
Clave=MensajeLayout.PermiteAbonoNoIdentificado
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro



[Lista.ListaEnCaptura]
(Inicio)=MensajeLayout.Mensaje
MensajeLayout.Mensaje=MensajeLayout.Descripcion
MensajeLayout.Descripcion=MensajeLayout.TipoMovimiento
MensajeLayout.TipoMovimiento=MensajeLayout.NaturalezaMovimiento
MensajeLayout.NaturalezaMovimiento=(Fin)






[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MensajeLayout
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

RefrescarAlEntrar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
FiltroGeneral=MensajeLayout.Layout = <T>{Info.Clave}<T>
[Hoja.MensajeLayout.Mensaje]
Carpeta=Hoja
Clave=MensajeLayout.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Hoja.MensajeLayout.Descripcion]
Carpeta=Hoja
Clave=MensajeLayout.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Hoja.MensajeLayout.TipoMovimiento]
Carpeta=Hoja
Clave=MensajeLayout.TipoMovimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Hoja.MensajeLayout.NaturalezaMovimiento]
Carpeta=Hoja
Clave=MensajeLayout.NaturalezaMovimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Hoja.Columnas]
Mensaje=64
Descripcion=407
TipoMovimiento=124
NaturalezaMovimiento=124















Layout=124


[Lista.MensajeLayout.Layout]
Carpeta=Lista
Clave=MensajeLayout.Layout
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[(Carpeta Abrir)]
Estilo=Iconos
Pestana=S
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=MensajeLayoutA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=MensajeLayout.Layout
CarpetaVisible=S

[(Carpeta Abrir).MensajeLayout.Layout]
Carpeta=(Carpeta Abrir)
Clave=MensajeLayout.Layout
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[(Carpeta Abrir).Columnas]
0=-2







[Materia.MensajeLayout.Layout]
Carpeta=Materia
Clave=MensajeLayout.Layout
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Materia.Columnas]
Layout=124


[Forma.ListaCarpetas]
(Inicio)=Hoja
Hoja=Materia
Materia=(Fin)











[Acciones.Mensaje]
Nombre=Mensaje
Boton=55
NombreDesplegar=&Mensajes (Por Omisón)
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



NombreEnBoton=S
EspacioPrevio=S


















Expresion=Si<BR>Confirmacion(<T>Se borraran todos los datos<BR><BR> ¿Esta Seguro?<T>, BotonSi, BotonNo) = BotonSi<BR>Entonces<BR>  EjecutarSQL(<T>EXEC spOmisionMensajeLayout :tInstitucion<T>, Info.Clave)<BR>  ActualizarVista<BR>Fin








[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total Registros
Totalizadores2=Conteo(MensajeLayout:MensajeLayout.Mensaje)
Totalizadores3=#,
Totalizadores=S
TotCarpetaRenglones=Hoja
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total Registros
CarpetaVisible=S

TotAlCambiar=S


[(Carpeta Totalizadores).Total Registros]
Carpeta=(Carpeta Totalizadores)
Clave=Total Registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata


[Hoja.ListaEnCaptura]
(Inicio)=MensajeLayout.Mensaje
MensajeLayout.Mensaje=MensajeLayout.Descripcion
MensajeLayout.Descripcion=MensajeLayout.TipoMovimiento
MensajeLayout.TipoMovimiento=MensajeLayout.NaturalezaMovimiento
MensajeLayout.NaturalezaMovimiento=(Fin)























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=Mensaje
Mensaje=(Fin)
