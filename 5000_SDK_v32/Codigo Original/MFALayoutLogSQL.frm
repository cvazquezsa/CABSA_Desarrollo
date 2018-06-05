
[Forma]
Clave=MFALayoutLogSQL
Icono=0
Modulos=(Todos)

ListaCarpetas=MFALayoutLogSQL
CarpetaPrincipal=MFALayoutLogSQL
PosicionInicialAlturaCliente=560
PosicionInicialAncho=755
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=305
PosicionInicialArriba=65
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
MovModulo=(Todos)
Nombre=MFA - SQL Excepciones
[MFALayoutLogSQL]
Estilo=Ficha
Clave=MFALayoutLogSQL
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=layout_log
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
ListaEnCaptura=layout_log.SQL
CarpetaVisible=S
AlinearTodaCarpeta=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
FiltroGeneral=layout_log.log_id = {Info.ID}
[MFALayoutLogSQL.layout_log.SQL]
Carpeta=MFALayoutLogSQL
Clave=layout_log.SQL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Aceptar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
ListaAccionesMultiples=(Lista)

Activo=S
Antes=S
Visible=S
[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=Cerrar
Cerrar=(Fin)
