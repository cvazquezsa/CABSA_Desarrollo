[Forma]
Clave=MensajeInstitucion
Nombre=Mensajes de la Institución
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=486
PosicionInicialArriba=139
PosicionInicialAltura=418
PosicionInicialAncho=627
Comentarios=Info.Cuenta
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialAlturaCliente=553
PosicionSec1=488

Totalizadores=S
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MensajeInstitucion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

BusquedaRapidaControles=S
FiltroGeneral=MensajeInstitucion.Institucion=<T>{Info.Cuenta}<T>
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
[Lista.MensajeInstitucion.Mensaje]
Carpeta=Lista
Clave=MensajeInstitucion.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.MensajeInstitucion.Descripcion]
Carpeta=Lista
Clave=MensajeInstitucion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

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

[Ficha.MensajeInstitucion.ConceptoGasto]
Carpeta=Ficha
Clave=MensajeInstitucion.ConceptoGasto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MensajeInstitucion.PermiteAbonoNoIdentificado]
Carpeta=Ficha
Clave=MensajeInstitucion.PermiteAbonoNoIdentificado
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MensajeInstitucion.Clasificacion]
Carpeta=Lista
Clave=MensajeInstitucion.Clasificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Clase]
Nombre=Clase
Boton=91
NombreEnBoton=S
NombreDesplegar=&Clasificaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MensajeInstitucionClase
Activo=S
Visible=S



[Acciones.Mensajes]
Nombre=Mensajes
Boton=55
NombreEnBoton=S
NombreDesplegar=Mensajes (Por Omisón)
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S




EspacioPrevio=S

GuardarAntes=S
Expresion=Si<BR>Confirmacion(<T>Se borraran todos los datos <BR><BR> ¿Esta Seguro?<T>, BotonSi, BotonNo) = BotonSi<BR>Entonces<BR>  Asigna(Info.CuentaA,SQL(<T>SELECT Layout FROM InstitucionFin WHERE Institucion = :tInstitucion<T>, Info.Cuenta))<BR>  EjecutarSQL(<T>EXEC spConciliacionInsertarMensajeLayout :tInstitucion, :tLayout<T>, Info.Cuenta, Info.CuentaA)<BR>  ActualizarVista<BR>Fin
[Acciones.Mensajes.ListaAccionesMultiples]
(Inicio)=Aceptar
Aceptar=Expresion
Expresion=(Fin)




























[Lista.ListaEnCaptura]
(Inicio)=MensajeInstitucion.Mensaje
MensajeInstitucion.Mensaje=MensajeInstitucion.Descripcion
MensajeInstitucion.Descripcion=MensajeInstitucion.Clasificacion
MensajeInstitucion.Clasificacion=(Fin)


















[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total registros
Totalizadores2=Conteo(MensajeInstitucion:MensajeInstitucion.Mensaje)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total registros
CarpetaVisible=S

Totalizadores3=#,
TotAlCambiar=S
[(Carpeta Totalizadores).Total registros]
Carpeta=(Carpeta Totalizadores)
Clave=Total registros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=Clase
Clase=Mensajes
Mensajes=(Fin)
