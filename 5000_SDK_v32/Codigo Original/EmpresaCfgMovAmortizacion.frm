[Forma]
Clave=EmpresaCfgMovAmortizacion
Nombre=Amortizaciones Especificas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Empresa
PosicionInicialIzquierda=763
PosicionInicialArriba=389
PosicionInicialAlturaCliente=385
PosicionInicialAncho=393
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgMovAmortizacion
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=EmpresaCfgMovAmortizacion.Empresa=<T>{Info.Empresa}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.EmpresaCfgMovAmortizacion.Modulo]
Carpeta=Lista
Clave=EmpresaCfgMovAmortizacion.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovAmortizacion.Mov]
Carpeta=Lista
Clave=EmpresaCfgMovAmortizacion.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgMovAmortizacion.Amortizacion]
Carpeta=Lista
Clave=EmpresaCfgMovAmortizacion.Amortizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Modulo=52
Mov=148
Amortizacion=152

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgMovAmortizacion.Modulo
EmpresaCfgMovAmortizacion.Modulo=EmpresaCfgMovAmortizacion.Mov
EmpresaCfgMovAmortizacion.Mov=EmpresaCfgMovAmortizacion.Amortizacion
EmpresaCfgMovAmortizacion.Amortizacion=(Fin)
