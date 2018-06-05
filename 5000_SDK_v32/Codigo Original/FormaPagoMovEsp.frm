
[Forma]
Clave=FormaPagoMovEsp
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Movimientos Especificos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
Comentarios=Info.FormaPago
ListaCarpetas=(Lista)
CarpetaPrincipal=AF
PosicionInicialIzquierda=433
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

GuardarAntes=S
[AF]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Activos Fijos
Clave=AF
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoMovEspAF
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
ListaEnCaptura=FormaPagoMovEsp.Mov

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=FormaPagoMovEsp.Mov<TAB>(Acendente)
FiltroGeneral=FormaPagoMovEsp.Modulo = <T>AF<T> AND<BR>FormaPagoMovEsp.FormaPago = <T>{Info.FormaPago}<T>
[AF.FormaPagoMovEsp.Mov]
Carpeta=AF
Clave=FormaPagoMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[AGENT]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comisiones y Destajos
Clave=AGENT
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoMovEspAGENT
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
ListaEnCaptura=FormaPagoMovEsp.Mov

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=FormaPagoMovEsp.Mov<TAB>(Acendente)
FiltroGeneral=FormaPagoMovEsp.Modulo = <T>AGENT<T> AND<BR>FormaPagoMovEsp.FormaPago = <T>{Info.FormaPago}<T>
[AGENT.FormaPagoMovEsp.Mov]
Carpeta=AGENT
Clave=FormaPagoMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[AF.Columnas]
Mov=203
ConDesglose=124

[AGENT.Columnas]
Mov=203
ConDesglose=124






[CREDI]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Crédito
Clave=CREDI
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoMovEspCREDI
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
ListaEnCaptura=FormaPagoMovEsp.Mov

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=FormaPagoMovEsp.Mov<TAB>(Acendente)
FiltroGeneral=FormaPagoMovEsp.Modulo = <T>CREDI<T> AND<BR>FormaPagoMovEsp.FormaPago = <T>{Info.FormaPago}<T>
[CREDI.FormaPagoMovEsp.Mov]
Carpeta=CREDI
Clave=FormaPagoMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[CREDI.Columnas]
Mov=203
ConDesglose=124


[CXC]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cxc
Clave=CXC
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoMovEspCXC
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
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=FormaPagoMovEsp.Mov<TAB>(Acendente)
FiltroGeneral=FormaPagoMovEsp.Modulo = <T>CXC<T> AND<BR>FormaPagoMovEsp.FormaPago = <T>{Info.FormaPago}<T>
[CXC.FormaPagoMovEsp.Mov]
Carpeta=CXC
Clave=FormaPagoMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CXC.FormaPagoMovEsp.ConDesglose]
Carpeta=CXC
Clave=FormaPagoMovEsp.ConDesglose
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[CXP]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cxp
Clave=CXP
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoMovEspCXP
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
ListaEnCaptura=FormaPagoMovEsp.Mov

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=FormaPagoMovEsp.Mov<TAB>(Acendente)
FiltroGeneral=FormaPagoMovEsp.Modulo = <T>CXP<T> AND<BR>FormaPagoMovEsp.FormaPago = <T>{Info.FormaPago}<T>
[CXP.FormaPagoMovEsp.Mov]
Carpeta=CXP
Clave=FormaPagoMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[DIN]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Tesorería
Clave=DIN
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoMovEspDIN
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
ListaEnCaptura=FormaPagoMovEsp.Mov

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=FormaPagoMovEsp.Mov<TAB>(Acendente)
FiltroGeneral=FormaPagoMovEsp.Modulo = <T>DIN<T> AND<BR>FormaPagoMovEsp.FormaPago = <T>{Info.FormaPago}<T>
[DIN.FormaPagoMovEsp.Mov]
Carpeta=DIN
Clave=FormaPagoMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[GAS]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gastos
Clave=GAS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoMovEspGAS
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
ListaEnCaptura=FormaPagoMovEsp.Mov

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=FormaPagoMovEsp.Mov<TAB>(Acendente)
FiltroGeneral=FormaPagoMovEsp.Modulo = <T>GAS<T> AND<BR>FormaPagoMovEsp.FormaPago = <T>{Info.FormaPago}<T>
[GAS.FormaPagoMovEsp.Mov]
Carpeta=GAS
Clave=FormaPagoMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[VTAS]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Ventas
Clave=VTAS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaPagoMovEspVTAS
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

ListaEnCaptura=(Lista)
Filtros=S
OtroOrden=S
ListaOrden=FormaPagoMovEsp.Mov<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=FormaPagoMovEsp.Modulo = <T>VTAS<T> AND<BR>FormaPagoMovEsp.FormaPago = <T>{Info.FormaPago}<T>
[CXC.Columnas]
Mov=203
ConDesglose=124

[CXP.Columnas]
Mov=203
ConDesglose=124

[DIN.Columnas]
Mov=203
ConDesglose=124

[GAS.Columnas]
Mov=203
ConDesglose=124



[VTAS.FormaPagoMovEsp.Mov]
Carpeta=VTAS
Clave=FormaPagoMovEsp.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[VTAS.FormaPagoMovEsp.ConDesglose]
Carpeta=VTAS
Clave=FormaPagoMovEsp.ConDesglose
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[GAS.ListaEnCaptura]
(Inicio)=FormaPagoMovEsp.Mov
FormaPagoMovEsp.Mov=FormaPagoMovEsp.ConDesglose
FormaPagoMovEsp.ConDesglose=(Fin)

[DIN.ListaEnCaptura]
(Inicio)=FormaPagoMovEsp.Mov
FormaPagoMovEsp.Mov=FormaPagoMovEsp.ConDesglose
FormaPagoMovEsp.ConDesglose=(Fin)


[CXP.ListaEnCaptura]
(Inicio)=FormaPagoMovEsp.Mov
FormaPagoMovEsp.Mov=FormaPagoMovEsp.ConDesglose
FormaPagoMovEsp.ConDesglose=(Fin)

[CXC.ListaEnCaptura]
(Inicio)=FormaPagoMovEsp.Mov
FormaPagoMovEsp.Mov=FormaPagoMovEsp.ConDesglose
FormaPagoMovEsp.ConDesglose=(Fin)

[CREDI.ListaEnCaptura]
(Inicio)=FormaPagoMovEsp.Mov
FormaPagoMovEsp.Mov=FormaPagoMovEsp.ConDesglose
FormaPagoMovEsp.ConDesglose=(Fin)

[AGENT.ListaEnCaptura]
(Inicio)=FormaPagoMovEsp.Mov
FormaPagoMovEsp.Mov=FormaPagoMovEsp.ConDesglose
FormaPagoMovEsp.ConDesglose=(Fin)

[AF.ListaEnCaptura]
(Inicio)=FormaPagoMovEsp.Mov
FormaPagoMovEsp.Mov=FormaPagoMovEsp.ConDesglose
FormaPagoMovEsp.ConDesglose=(Fin)


[VTAS.Columnas]
Mov=203
ConDesglose=124


























[VTAS.ListaEnCaptura]
(Inicio)=FormaPagoMovEsp.Mov
FormaPagoMovEsp.Mov=FormaPagoMovEsp.ConDesglose
FormaPagoMovEsp.ConDesglose=(Fin)























[Forma.ListaCarpetas]
(Inicio)=AF
AF=AGENT
AGENT=CREDI
CREDI=CXC
CXC=CXP
CXP=DIN
DIN=GAS
GAS=VTAS
VTAS=(Fin)
