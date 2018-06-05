
[Forma]
Clave=CFDIGenerar
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Generar CFDI

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=649
PosicionInicialAncho=801
PosicionInicialIzquierda=118
PosicionInicialArriba=27
ListaAcciones=Aceptar
BarraHerramientas=S
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIGenerar
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
Filtros=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSeleccionMultiple=S
ElementosPorPaginaEsp=200
ListaEnCaptura=Estatus<BR>Fecha<BR>RFC<BR>TipoCambio<BR>Importe<BR>Impuesto1<BR>Timbrado
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)

IconosSubTitulo=Folio
FiltroArbolClave=Ejercicio
FiltroGrupo1=Modulo
FiltroValida1=Modulo
FiltroGrupo2=Serie
FiltroValida2=Serie
BusquedaRapidaControles=S
FiltroFechas=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Fecha
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaEnLinea=S


MenuLocal=S
ListaAcciones=CFDI
IconosSeleccionPorLlave=S
RefrescarAlEntrar=S
IconosNombre=CFDIGenerar:MovID
FiltroGeneral=Empresa = {comillas(Empresa)} AND Timbrado = 0
[Lista.Fecha]
Carpeta=Lista
Clave=Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.RFC]
Carpeta=Lista
Clave=RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[Lista.Importe]
Carpeta=Lista
Clave=Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Impuesto1]
Carpeta=Lista
Clave=Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.TipoCambio]
Carpeta=Lista
Clave=TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Timbrado]
Carpeta=Lista
Clave=Timbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Estatus]
Carpeta=Lista
Clave=Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
0=72
1=100
2=74
3=92
4=82
5=74
6=72
7=67
8=88
9=-2
10=-2
11=89
12=-2
13=-2
14=-2
15=-2
16=-2
17=-2
18=-2

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.CFDI]
Nombre=CFDI
Boton=0
NombreDesplegar=Generar CFDI
EnMenu=S
Activo=S
Visible=S
EnLote=S
TeclaFuncion=F12


TipoAccion=Expresion
Expresion=CFD.Generar(CFDIGenerar:Modulo, CFDIGenerar:moduloID)
