
[Forma]
Clave=TCSucursalCfg
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Interface Tarjetas Bancarias - Configuración Sucursales
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Empresa

ListaAcciones=(Lista)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=433
PosicionInicialArriba=192
PosicionInicialAlturaCliente=305
PosicionInicialAncho=500
PosicionCol1=156

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Sucursal
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TCSucursalCfg
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TCSucursalCfg.Sucursal
CarpetaVisible=S

HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=TCSucursalCfg.Sucursal<TAB>(Acendente)
FiltroGeneral=TCSucursalCfg.Empresa = <T>{Empresa}<T>
[Lista.TCSucursalCfg.Sucursal]
Carpeta=Lista
Clave=TCSucursalCfg.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Sucursal=103

Institucion=87
Nombre=190
Ciudad=63
Estado=48
[Detalle]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=TCSucursalCfg
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

Pestana=S
[Detalle.TCSucursalCfg.Sucursal]
Carpeta=Detalle
Clave=TCSucursalCfg.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Detalle.TCSucursalCfg.ProcesadorTrans]
Carpeta=Detalle
Clave=TCSucursalCfg.ProcesadorTrans
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S

[Detalle.TCSucursalCfg.Afiliacion]
Carpeta=Detalle
Clave=TCSucursalCfg.Afiliacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S



[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S



ConfirmarAntes=S
[Acciones.Navegador 1 (Registros)]
Nombre=Navegador 1 (Registros)
Boton=0
NombreDesplegar=Navegador 1 (Registros)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S












[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=TCSucursalCfg
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

[OtrosDatos.TCSucursalCfg.Usuario]
Carpeta=OtrosDatos
Clave=TCSucursalCfg.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

EspacioPrevio=S
[OtrosDatos.TCSucursalCfg.Contrasena]
Carpeta=OtrosDatos
Clave=TCSucursalCfg.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[OtrosDatos.Columnas]
Usuario=64
Contrasena=196













[OtrosDatos.ListaEnCaptura]
(Inicio)=TCSucursalCfg.ModoOperacion
TCSucursalCfg.ModoOperacion=TCSucursalCfg.Usuario
TCSucursalCfg.Usuario=TCSucursalCfg.Contrasena
TCSucursalCfg.Contrasena=(Fin)

[OtrosDatos.TCSucursalCfg.ModoOperacion]
Carpeta=OtrosDatos
Clave=TCSucursalCfg.ModoOperacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco












































[Detalle.ListaEnCaptura]
(Inicio)=TCSucursalCfg.Sucursal
TCSucursalCfg.Sucursal=TCSucursalCfg.Afiliacion
TCSucursalCfg.Afiliacion=TCSucursalCfg.ProcesadorTrans
TCSucursalCfg.ProcesadorTrans=(Fin)







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





















[Acciones.TCTerminalSucursalCfg]
Nombre=TCTerminalSucursalCfg
Boton=16
NombreEnBoton=S
NombreDesplegar=&Terminales
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TCTerminalSucursalCfg
Activo=S
Antes=S





AntesExpresiones=Asigna(Info.Sucursal, TCSucursalCfg:TCSucursalCfg.Sucursal)
VisibleCondicion=fnTCNivelCfgPinPad(Empresa) = <T>Sucursal<T>


[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=OtrosDatos
OtrosDatos=(Fin)

[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Nuevo
Nuevo=Eliminar
Eliminar=TCTerminalSucursalCfg
TCTerminalSucursalCfg=Navegador 1 (Registros)
Navegador 1 (Registros)=(Fin)
