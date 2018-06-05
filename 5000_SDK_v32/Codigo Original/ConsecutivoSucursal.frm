[Forma]
Clave=ConsecutivoSucursal
Nombre=Consecutivos Generales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=245
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=461
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Tipo

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConsecutivoSucursal
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.ConsecutivoSucursal.Sucursal]
Carpeta=Lista
Clave=ConsecutivoSucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sucursal.Prefijo]
Carpeta=Lista
Clave=Sucursal.Prefijo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ConsecutivoSucursal.Consecutivo]
Carpeta=Lista
Clave=ConsecutivoSucursal.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Sucursal=50
Prefijo=98
Nombre=184
Consecutivo=98

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
(Inicio)=ConsecutivoSucursal.Sucursal
ConsecutivoSucursal.Sucursal=Sucursal.Prefijo
Sucursal.Prefijo=Sucursal.Nombre
Sucursal.Nombre=ConsecutivoSucursal.Consecutivo
ConsecutivoSucursal.Consecutivo=(Fin)
