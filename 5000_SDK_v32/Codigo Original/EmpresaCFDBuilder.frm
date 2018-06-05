
[Forma]
Clave=EmpresaCFDBuilder
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=EmpresaCFDBuilder
Nombre=Report Builder

ListaCarpetas=Lista
PosicionInicialIzquierda=541
PosicionInicialArriba=381
PosicionInicialAlturaCliente=273
PosicionInicialAncho=526
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCFDBuilder
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
FiltroGeneral=Empresa = {comillas(Info.Empresa)}
[Lista.EmpresaCFDBuilder.Reporte]
Carpeta=Lista
Clave=EmpresaCFDBuilder.Reporte
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.EmpresaCFDBuilder.Descripcion]
Carpeta=Lista
Clave=EmpresaCFDBuilder.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Reporte=138
Descripcion=265

Modulo=62

[Lista.EmpresaCFDBuilder.Modulo]
Carpeta=Lista
Clave=EmpresaCFDBuilder.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=EmpresaCFDBuilder.Modulo
EmpresaCFDBuilder.Modulo=EmpresaCFDBuilder.Reporte
EmpresaCFDBuilder.Reporte=EmpresaCFDBuilder.Descripcion
EmpresaCFDBuilder.Descripcion=(Fin)

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancela]
Nombre=Cancela
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S



EspacioPrevio=S






[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancela
Cancela=(Fin)
