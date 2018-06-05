
[Forma]
Clave=MonHistTemp
Icono=0
CarpetaPrincipal=MonHistTemp
Modulos=(Todos)
Nombre=Generar Historico Monedas

ListaCarpetas=MonHistTemp
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=390
PosicionInicialArriba=304
Comentarios=Info.Moneda
ExpresionesAlMostrar=EjecutarSQL(<T>spBorrarMonHistTemp :nEstacion<T>,EstacionTrabajo)
[MonHistTemp]
Estilo=Hoja
Clave=MonHistTemp
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MonHistTemp
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaPermiteInsertar=S
FiltroGeneral=MonHistTemp.Estacion  = {EstacionTrabajo}
[MonHistTemp.MonHistTemp.Fecha]
Carpeta=MonHistTemp
Clave=MonHistTemp.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[MonHistTemp.MonHistTemp.TipoCambio]
Carpeta=MonHistTemp
Clave=MonHistTemp.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Enviar/Recibir Excel.Enviar/Recibir Excel]
Nombre=Enviar/Recibir Excel
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Enviar/Recibir Excel.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Enviar/Recibir Excel]
Nombre=Enviar/Recibir Excel
Boton=115
NombreDesplegar=Enviar/Recibir Excel
Multiple=S
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

EspacioPrevio=S
[MonHistTemp.Columnas]
Fecha=155
TipoCambio=147










[Acciones.Enviar/Recibir Excel.ListaAccionesMultiples]
(Inicio)=Enviar/Recibir Excel
Enviar/Recibir Excel=Actualizar Forma
Actualizar Forma=(Fin)













[Acciones.Expresion]
Nombre=Expresion
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S
Expresion=ProcesarSQL(<T>spInsertarMonHist :nEstacion, :tMoneda, :nSucursal<T>,EstacionTrabajo,Info.Moneda,Sucursal)<BR>ActualizarForma





[MonHistTemp.ListaEnCaptura]
(Inicio)=MonHistTemp.Fecha
MonHistTemp.Fecha=MonHistTemp.TipoCambio
MonHistTemp.TipoCambio=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Enviar/Recibir Excel
Enviar/Recibir Excel=Expresion
Expresion=(Fin)
