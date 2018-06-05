
[Forma]
Clave=CFDVentaDCte
Icono=0
Modulos=(Todos)
MovModulo=VTAS
Nombre=Por Cuenta Terceros (Cliente)

ListaCarpetas=CFDVentaDCte
CarpetaPrincipal=CFDVentaDCte
PosicionInicialIzquierda=478
PosicionInicialArriba=106
PosicionInicialAlturaCliente=505
PosicionInicialAncho=353
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar<BR>Cancelar
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=2
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
ExpresionesAlActivar=EjecutarSQL(<T>xpCFDVentaDCopiarCliente :nID<T>,Info.ID)
[CFDVentaDCte]
Estilo=Hoja
Clave=CFDVentaDCte
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDVentaDCte
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CFDVentaDCte.Articulo<BR>CFDVentaDCte.Cliente
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
PermiteEditar=S
FiltroGeneral=CFDVentaDCte.ID = {Info.ID}
[CFDVentaDCte.CFDVentaDCte.Cliente]
Carpeta=CFDVentaDCte
Clave=CFDVentaDCte.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[CFDVentaDCte.Columnas]
Cliente=159

Articulo=154
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
Activo=S
Visible=S


GuardarAntes=S
ClaveAccion=Aceptar
[Acciones.Cancelar]
Nombre=Cancelar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S

EspacioPrevio=S



[Lista.Columnas]
0=79
1=220
2=100
3=130
4=104
5=117

[CFDVentaDCte.CFDVentaDCte.Articulo]
Carpeta=CFDVentaDCte
Clave=CFDVentaDCte.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
