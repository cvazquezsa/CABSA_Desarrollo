
[Forma]
Clave=TCCfg
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Interface Tarjetas Bancarias - Configuración General
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
Comentarios=Empresa
PosicionInicialIzquierda=421
PosicionInicialArriba=225
PosicionInicialAlturaCliente=239
PosicionInicialAncho=523
ListaCarpetas=TCCfg
CarpetaPrincipal=TCCfg
Menus=S
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

[TCCfg]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=TCCfg
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TCCfg
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=TCCfg.Empresa = <T>{Empresa}<T>
[TCCfg.TCCfg.ProcesadorTrans]
Carpeta=TCCfg
Clave=TCCfg.ProcesadorTrans
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[TCCfg.Columnas]
ProcesadorTrans=129
InstitucionAdquiriente=124
InstitucionAdquirienteAMEX=142
ConexionExplicita=91






[Lista.Columnas]
Institucion=87
Nombre=190
Ciudad=63
Estado=48



[Acciones.TCSucursalCfg]
Nombre=TCSucursalCfg
Boton=94
NombreEnBoton=S
NombreDesplegar=&Sucursales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TCSucursalCfg
Activo=S
Visible=S

















GuardarAntes=S
[TCCfg.TCCfg.NivelCfg]
Carpeta=TCCfg
Clave=TCCfg.NivelCfg
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















































[Acciones.TCPinPad]
Nombre=TCPinPad
Boton=46
Menu=&Maestros
NombreDesplegar=PinPad
TipoAccion=Formas
ClaveAccion=TCPinPad
Activo=S
Visible=S








NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S
GuardarAntes=S
[Acciones.TCProcesadorTrans]
Nombre=TCProcesadorTrans
Boton=43
NombreDesplegar=&Procesador Transacciones
TipoAccion=Formas
ClaveAccion=TCProcesadorTrans
Activo=S
Visible=S



Menu=&Maestros














NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S














































































GuardarAntes=S




[TCCfg.TCCfg.Ubicacion]
Carpeta=TCCfg
Clave=TCCfg.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





EspacioPrevio=S












[TCCfg.TCCfg.RutaArchivosXML]
Carpeta=TCCfg
Clave=TCCfg.RutaArchivosXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[TCCfg.TCCfg.CxcMovAnticipo]
Carpeta=TCCfg
Clave=TCCfg.CxcMovAnticipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco









[TCCfg.TCCfg.CxcMovDevolucion]
Carpeta=TCCfg
Clave=TCCfg.CxcMovDevolucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















[TCCfg.TCCfg.NivelCfgPinPad]
Carpeta=TCCfg
Clave=TCCfg.NivelCfgPinPad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[TCCfg.ListaEnCaptura]
(Inicio)=TCCfg.CxcMovAnticipo
TCCfg.CxcMovAnticipo=TCCfg.CxcMovDevolucion
TCCfg.CxcMovDevolucion=TCCfg.NivelCfgPinPad
TCCfg.NivelCfgPinPad=TCCfg.NivelCfg
TCCfg.NivelCfg=TCCfg.ProcesadorTrans
TCCfg.ProcesadorTrans=TCCfg.Ubicacion
TCCfg.Ubicacion=TCCfg.RutaArchivosXML
TCCfg.RutaArchivosXML=(Fin)















[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=TCSucursalCfg
TCSucursalCfg=TCPinPad
TCPinPad=TCProcesadorTrans
TCProcesadorTrans=(Fin)
