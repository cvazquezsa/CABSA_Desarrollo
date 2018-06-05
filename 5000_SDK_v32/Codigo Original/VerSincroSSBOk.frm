[Forma]
Clave=VerSincroSSBOk
Nombre=Errores de Sincronización
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=556
PosicionInicialArriba=375
PosicionInicialAlturaCliente=414
PosicionInicialAncho=807
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerSincroSSBOk
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Conversación<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=VerSincroSSBOk.Fecha
FiltroFechasDefault=Hoy
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
IconosNombre=VerSincroSSBOk:VerSincroSSBOk.Conversacion

[Lista.VerSincroSSBOk.Fecha]
Carpeta=Lista
Clave=VerSincroSSBOk.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBOk.TipoMensaje]
Carpeta=Lista
Clave=VerSincroSSBOk.TipoMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBOk.DatosRef]
Carpeta=Lista
Clave=VerSincroSSBOk.DatosRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBOk.Ok]
Carpeta=Lista
Clave=VerSincroSSBOk.Ok
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.VerSincroSSBOk.OkRef]
Carpeta=Lista
Clave=VerSincroSSBOk.OkRef
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MensajeLista.Descripcion]
Carpeta=Lista
Clave=MensajeLista.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MensajeLista.Tipo]
Carpeta=Lista
Clave=MensajeLista.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=-2
1=-2

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
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=&Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.ReActivarCola]
Nombre=ReActivarCola
Boton=7
NombreEnBoton=S
NombreDesplegar=&Reactivar Cola
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spSincroSSB_ActivarCola<T>)

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=ReActivarCola
ReActivarCola=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=VerSincroSSBOk.Fecha
VerSincroSSBOk.Fecha=VerSincroSSBOk.TipoMensaje
VerSincroSSBOk.TipoMensaje=VerSincroSSBOk.DatosRef
VerSincroSSBOk.DatosRef=VerSincroSSBOk.Ok
VerSincroSSBOk.Ok=VerSincroSSBOk.OkRef
VerSincroSSBOk.OkRef=MensajeLista.Descripcion
MensajeLista.Descripcion=MensajeLista.Tipo
MensajeLista.Tipo=(Fin)
