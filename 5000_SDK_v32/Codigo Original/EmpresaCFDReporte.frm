
[Forma]
Clave=EmpresaCFDReporte
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Reporte CFD por Empresa
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
Comentarios=Lista(Info.Empresa)
ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=Lista
PosicionInicialIzquierda=176
PosicionInicialArriba=231
PosicionInicialAlturaCliente=437
PosicionInicialAncho=570
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDReporte
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S

FiltroGeneral=EmpresaCFDReporte.Empresa = {Comillas(Info.Empresa)}
[Lista.EmpresaCFDReporte.Modulo]
Carpeta=Lista
Clave=EmpresaCFDReporte.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.EmpresaCFDReporte.Mov]
Carpeta=Lista
Clave=EmpresaCFDReporte.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.EmpresaCFDReporte.Reporte]
Carpeta=Lista
Clave=EmpresaCFDReporte.Reporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Modulo=56
Mov=166
Reporte=242





ReporteJasper=304
[Lista.ListaEnCaptura]
(Inicio)=EmpresaCFDReporte.Modulo
EmpresaCFDReporte.Modulo=EmpresaCFDReporte.Mov
EmpresaCFDReporte.Mov=EmpresaCFDReporte.Reporte
EmpresaCFDReporte.Reporte=EmpresaCFDReporte.ReporteJasper
EmpresaCFDReporte.ReporteJasper=(Fin)

[Lista.EmpresaCFDReporte.ReporteJasper]
Carpeta=Lista
Clave=EmpresaCFDReporte.ReporteJasper
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
