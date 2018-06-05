
[Forma]
Clave=ProyectoDArtMaterial
Icono=9
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=Actividad - Lista de Materiales

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=421
PosicionInicialAncho=549
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Lista(Info.Proyecto,Info.Actividad)
PosicionInicialIzquierda=453
PosicionInicialArriba=184
ListaAcciones=(Lista)
Menus=S
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDArtMaterial
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)


CondicionEdicion=Info.Estatus = EstatusSinAfectar
FiltroAutoCampo=ProyectoDArtMaterial.Material
FiltroAutoValidar=ProyectoDArtMaterial.Material
FiltroGeneral=ProyectoDArtMaterial.ID = {Info.ID} AND ProyectoDArtMaterial.Actividad = <T>{Info.Actividad}<T>
[Lista.ProyectoDArtMaterial.Material]
Carpeta=Lista
Clave=ProyectoDArtMaterial.Material
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ProyectoDArtMaterial.SubCuenta]
Carpeta=Lista
Clave=ProyectoDArtMaterial.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ProyectoDArtMaterial.Cantidad]
Carpeta=Lista
Clave=ProyectoDArtMaterial.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ProyectoDArtMaterial.Unidad]
Carpeta=Lista
Clave=ProyectoDArtMaterial.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.ProyectoDArtMaterial.Almacen]
Carpeta=Lista
Clave=ProyectoDArtMaterial.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Columnas]
Material=124
SubCuenta=131
Cantidad=64
Unidad=79
Almacen=107

Articulo=131
Descripcion1=244

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
Activo=S
Visible=S

TipoAccion=Ventana
ClaveAccion=Aceptar
[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=&Información Material
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S

NombreEnBoton=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
EnMenu=S
EspacioPrevio=S























ConCondicion=S
EjecucionCondicion=ConDatos(ProyectoDArtMaterial:ProyectoDArtMaterial.Material)
Antes=S
AntesExpresiones=Asigna(Info.Articulo, ProyectoDArtMaterial:ProyectoDArtMaterial.Material)




[Acciones.Dividir]
Nombre=Dividir
Boton=75
NombreDesplegar=&Prorratear Material en las Actividades
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S



















Expresion=Informacion(SQL(<T>EXEC spProyectoProrratearMaterial :nID, :tActividad, :nEstacion<T>,Info.ID, Info.Actividad,  EstacionTrabajo))<BR>ActualizarVista
ActivoCondicion=Temp.Logico = VERDADERO

















[Lista.ListaEnCaptura]
(Inicio)=ProyectoDArtMaterial.Material
ProyectoDArtMaterial.Material=ProyectoDArtMaterial.SubCuenta
ProyectoDArtMaterial.SubCuenta=ProyectoDArtMaterial.Cantidad
ProyectoDArtMaterial.Cantidad=ProyectoDArtMaterial.Unidad
ProyectoDArtMaterial.Unidad=ProyectoDArtMaterial.Almacen
ProyectoDArtMaterial.Almacen=(Fin)









































































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Dividir
Dividir=ArtInfo
ArtInfo=(Fin)
