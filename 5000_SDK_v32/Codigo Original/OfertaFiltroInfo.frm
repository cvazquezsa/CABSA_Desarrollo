[Forma]
Clave=OfertaFiltroInfo
Nombre=Filtro
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=425
PosicionInicialArriba=143
PosicionInicialAlturaCliente=480
PosicionInicialAncho=429
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Mov, Info.MovID)
ExpresionesAlMostrar=Asigna(Info.Campo, Nulo)
ExpresionesAlCerrar=Asigna(Info.Campo, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OfertaFiltro
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=(Lista)
CondicionEdicion=Info.PuedeEditar

FiltroGeneral=OfertaFiltro.ID={Info.ID}
[Lista.OfertaFiltro.Campo]
Carpeta=Lista
Clave=OfertaFiltro.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[Lista.OfertaFiltro.Valor]
Carpeta=Lista
Clave=OfertaFiltro.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S


[Lista.Columnas]
Campo=139
Valor=260




[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=OfertaFiltro.Campo
OfertaFiltro.Campo=OfertaFiltro.Valor
OfertaFiltro.Valor=(Fin)

[Lista.ListaOrden]
(Inicio)=OfertaFiltro.Campo	(Acendente)
OfertaFiltro.Campo	(Acendente)=OfertaFiltro.Valor	(Acendente)
OfertaFiltro.Valor	(Acendente)=(Fin)
