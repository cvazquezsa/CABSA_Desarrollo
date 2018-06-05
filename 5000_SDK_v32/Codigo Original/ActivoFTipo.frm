
[Forma]
Clave=ActivoFTipo
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Tipos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=287
PosicionInicialAncho=331
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=554
PosicionInicialArriba=293
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoFTipo
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
ListaEnCaptura=ActivoFTipo.Tipo
ListaOrden=ActivoFTipo.Tipo<TAB>(Acendente)
CarpetaVisible=S

[Lista.ActivoFTipo.Tipo]
Carpeta=Lista
Clave=ActivoFTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tipo=304

0=-2
1=-2
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ActivoFTipo:ActivoFTipo.Tipo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreEnBoton=S
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S





EspacioPrevio=S
ActivoCondicion=Usuario.EnviarExcel











[Acciones.ActivoFTipoIndicador]
Nombre=ActivoFTipoIndicador
Boton=110
NombreEnBoton=S
NombreDesplegar=Indicadores
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ActivoFTipoIndicador
Activo=S



EspacioPrevio=S




Antes=S





























AntesExpresiones=Asigna(Info.Tipo, ActivoFTipo:ActivoFTipo.Tipo)
VisibleCondicion=General.MAF
[Acciones.ActivoFTipoServicio]
Nombre=ActivoFTipoServicio
Boton=88
NombreEnBoton=S
NombreDesplegar=Servicios
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ActivoFTipoServicio
Activo=S





Antes=S




























































































AntesExpresiones=Asigna(Info.Tipo, ActivoFTipo:ActivoFTipo.Tipo)
VisibleCondicion=General.MAF










































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=ActivoFTipoIndicador
ActivoFTipoIndicador=ActivoFTipoServicio
ActivoFTipoServicio=(Fin)
