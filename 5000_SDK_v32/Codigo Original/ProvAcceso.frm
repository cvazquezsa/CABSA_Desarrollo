[Forma]
Clave=ProvAcceso
Icono=0
Modulos=(Todos)
Nombre=Acceso Especifico
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Proveedor, Info.Nombre)
PosicionInicialIzquierda=283
PosicionInicialArriba=187
PosicionInicialAlturaProveedor=361
PosicionInicialAncho=457
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=360

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProvAcceso
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Gris
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
FiltroGeneral=ProvAcceso.Proveedor=<T>{Info.Proveedor}<T>

[Lista.ProvAcceso.Usuario]
Carpeta=Lista
Clave=ProvAcceso.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Usuario.Nombre]
Carpeta=Lista
Clave=Usuario.Nombre
Editar=N
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
Usuario=101
Nombre=326

[Lista.ListaEnCaptura]
(Inicio)=ProvAcceso.Usuario
ProvAcceso.Usuario=Usuario.Nombre
Usuario.Nombre=(Fin)
