[Forma]
Clave=SucursalBanco
Nombre=Sucursales Bancarias de la Sucursal
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=257
PosicionInicialArriba=227
PosicionInicialAlturaCliente=279
PosicionInicialAncho=510
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Sucursal, Info.Nombre)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SucursalBanco
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
FiltroGeneral=SucursalBanco.Sucursal={Info.Sucursal}
FiltroRespetar=S
FiltroTipo=General

[Lista.SucursalBanco.Institucion]
Carpeta=Lista
Clave=SucursalBanco.Institucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InstitucionFin.Nombre]
Carpeta=Lista
Clave=InstitucionFin.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Lista.SucursalBanco.Numero]
Carpeta=Lista
Clave=SucursalBanco.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Institucion=124
Nombre=304
Numero=51

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

[Lista.ListaEnCaptura]
(Inicio)=SucursalBanco.Institucion
SucursalBanco.Institucion=InstitucionFin.Nombre
InstitucionFin.Nombre=SucursalBanco.Numero
SucursalBanco.Numero=(Fin)
