
[Forma]
Clave=TCTerminalAgenteCfg
Icono=0
Modulos=(Todos)
PosicionInicialAlturaCliente=136
PosicionInicialAncho=452
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=457
PosicionInicialArriba=277
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=GuardarCerrar
ListaCarpetas=Detalles
CarpetaPrincipal=Detalles
MovModulo=(Todos)
Nombre=Tarjetas Bancarias - Configuración Terminales por Agente
Comentarios=Lista(Empresa, Info.Agente)
PosicionCol1=188


[Lista.Columnas]
Estacion=115
TerminalEquiv=114
Pinpad=93
Puerto=77
Estatus=82



[Lista.ListaEnCaptura]
(Inicio)=TCTerminalCfg.Estacion
TCTerminalCfg.Estacion=TCTerminalCfg.TerminalEquiv
TCTerminalCfg.TerminalEquiv=TCTerminalCfg.Pinpad
TCTerminalCfg.Pinpad=TCTerminalCfg.Puerto
TCTerminalCfg.Puerto=TCTerminalCfg.Estatus
TCTerminalCfg.Estatus=(Fin)

[Detalles]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalles
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TCTerminalCfg
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
FiltroGeneral=TCTerminalCfg.Agente = <T>{Info.Agente}<T>
[Detalles.TCTerminalCfg.TerminalEquiv]
Carpeta=Detalles
Clave=TCTerminalCfg.TerminalEquiv
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.TCTerminalCfg.Pinpad]
Carpeta=Detalles
Clave=TCTerminalCfg.Pinpad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalles.TCTerminalCfg.Puerto]
Carpeta=Detalles
Clave=TCTerminalCfg.Puerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalles
Detalles=(Fin)










[Detalles.ListaEnCaptura]
(Inicio)=TCTerminalCfg.Pinpad
TCTerminalCfg.Pinpad=TCTerminalCfg.Puerto
TCTerminalCfg.Puerto=TCTerminalCfg.TerminalEquiv
TCTerminalCfg.TerminalEquiv=(Fin)













[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Eliminar
Eliminar=(Fin)
