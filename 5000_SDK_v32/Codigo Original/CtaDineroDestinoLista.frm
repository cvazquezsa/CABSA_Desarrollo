[Forma]
Clave=CtaDineroDestinoLista
Nombre=Cuentas de Dinero
Icono=6
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=353
PosicionInicialArriba=353
PosicionInicialAltura=311
PosicionInicialAncho=573
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=284

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Cuentas
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaDineroDestino
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroAncho=17
FiltroAutoCampo=CtaDineroDestino.Tipo
FiltroAutoValidar=CtaDineroDestino.Tipo
FiltroEnOrden=S
FiltroTodoNombre=Todas
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
MenuLocal=S
ListaAcciones=Actualizar
PermiteLocalizar=S
FiltroGrupo1=CtaDineroDestino.Tipo
FiltroGrupo2=CtaDineroDestino.Moneda
FiltroValida1=CtaDineroDestino.Tipo
FiltroValida2=CtaDineroDestino.Moneda
FiltroTodo=S
FiltroTodoFinal=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=(Lista)
FiltroListas=S
FiltroListasRama=DIN
FiltroListasAplicaEn=CtaDineroDestino.CtaDinero

[Lista.Columnas]
0=143
CtaDineroDestino=118
Tipo=58
Moneda=65
Descripcion=186
CtaDinero=84

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Informacion]
Nombre=Informacion
Boton=34
NombreEnBoton=S
NombreDesplegar=&Información
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
Visible=S
Antes=S
ClaveAccion=CtaDineroInfo

ActivoCondicion=Usuario.CtaDineroInfo
AntesExpresiones=Asigna( Info.CtaDinero, CtaDineroDestino:CtaDineroDestino.CtaDinero )
[Acciones.Actualizar]
Nombre=Actualizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=Actualizar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.CtaDineroDestino.Moneda]
Carpeta=Lista
Clave=CtaDineroDestino.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroDestino.Descripcion]
Carpeta=Lista
Clave=CtaDineroDestino.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtaDineroDestino.CtaDinero]
Carpeta=Lista
Clave=CtaDineroDestino.CtaDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=CtaDineroDestino.CtaDinero
CtaDineroDestino.CtaDinero=CtaDineroDestino.Descripcion
CtaDineroDestino.Descripcion=CtaDineroDestino.Moneda
CtaDineroDestino.Moneda=(Fin)

[Lista.ListaOrden]
(Inicio)=CtaDineroDestino.Tipo<TAB>(Acendente)
CtaDineroDestino.Tipo<TAB>(Acendente)=CtaDineroDestino.CtaDinero<TAB>(Acendente)
CtaDineroDestino.CtaDinero<TAB>(Acendente)=(Fin)



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Informacion
Informacion=(Fin)
