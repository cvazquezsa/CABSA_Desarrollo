[Forma]
Clave=CtaDineroI
Nombre=Cuentas de Dinero
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=146
PosicionInicialArriba=137
PosicionInicialAltura=494
PosicionInicialAncho=731
MenuPrincipal=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaDineroI
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaCamposAValidar=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
CarpetaVisible=S
FiltroPredefinido1=por Clave<BR>por Descripción
FiltroPredefinido2=<BR>0=0
FiltroPredefinido3=Tipo, CtaDinero<BR>Tipo, Descripcion
FiltroEstilo=Directorio

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
NombreDesplegar=&Nuevo
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
Menu=&Archivo
NombreDesplegar=E&liminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
Menu=&Archivo
NombreDesplegar=Enviar/Recibir Excel...
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=45
Menu=&Archivo
NombreDesplegar=Personalizar &Vista...
EnBarraHerramientas=S
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
CtaDinero=119
Descripcion=279
Tipo=64
Uso=173
NumeroCta=107
Sucursal=304
CuentaHabiente=94
Moneda=106
Beneficiario=64
Conciliar=109
Mensaje=304
Estatus=85
BancoSucursal=93

[Acciones.Localizar]
Nombre=Localizar
Boton=73
NombreDesplegar=&Localizar
EnBarraHerramientas=S
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Alt+F3
EspacioPrevio=S

[Acciones.Siguiente]
Nombre=Siguiente
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[Lista.CtaDineroI.CtaDinero]
Carpeta=Lista
Clave=CtaDineroI.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.Descripcion]
Carpeta=Lista
Clave=CtaDineroI.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.Tipo]
Carpeta=Lista
Clave=CtaDineroI.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.Conciliar]
Carpeta=Lista
Clave=CtaDineroI.Conciliar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.CuentaHabiente]
Carpeta=Lista
Clave=CtaDineroI.CuentaHabiente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.NumeroCta]
Carpeta=Lista
Clave=CtaDineroI.NumeroCta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.Moneda]
Carpeta=Lista
Clave=CtaDineroI.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.Uso]
Carpeta=Lista
Clave=CtaDineroI.Uso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.Mensaje]
Carpeta=Lista
Clave=CtaDineroI.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.Estatus]
Carpeta=Lista
Clave=CtaDineroI.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroI.BancoSucursal]
Carpeta=Lista
Clave=CtaDineroI.BancoSucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Nuevo
Nuevo=Eliminar
Eliminar=Localizar
Localizar=Siguiente
Siguiente=Excel
Excel=Campos
Campos=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtaDineroI.CtaDinero
CtaDineroI.CtaDinero=CtaDineroI.Descripcion
CtaDineroI.Descripcion=CtaDineroI.Tipo
CtaDineroI.Tipo=CtaDineroI.Conciliar
CtaDineroI.Conciliar=CtaDineroI.CuentaHabiente
CtaDineroI.CuentaHabiente=CtaDineroI.BancoSucursal
CtaDineroI.BancoSucursal=CtaDineroI.NumeroCta
CtaDineroI.NumeroCta=CtaDineroI.Moneda
CtaDineroI.Moneda=CtaDineroI.Uso
CtaDineroI.Uso=CtaDineroI.Mensaje
CtaDineroI.Mensaje=CtaDineroI.Estatus
CtaDineroI.Estatus=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=CtaDineroI.CtaDinero
CtaDineroI.CtaDinero=CtaDineroI.Tipo
CtaDineroI.Tipo=CtaDineroI.Descripcion
CtaDineroI.Descripcion=(Fin)
