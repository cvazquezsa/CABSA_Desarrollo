[Forma]
Clave=PersonalSuc
Nombre=Sucursales Asignadas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Personal, Info.Nombre)
PosicionInicialIzquierda=321
PosicionInicialArriba=148
PosicionInicialAlturaCliente=437
PosicionInicialAncho=382
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalSuc
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
FiltroGeneral=PersonalSuc.Personal=<T>{Info.Personal}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.PersonalSuc.Sucursal]
Carpeta=Lista
Clave=PersonalSuc.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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
Sucursal=48
Nombre=304

[Lista.ListaEnCaptura]
(Inicio)=PersonalSuc.Sucursal
PersonalSuc.Sucursal=Sucursal.Nombre
Sucursal.Nombre=(Fin)
