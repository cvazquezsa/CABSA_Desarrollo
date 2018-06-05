[Forma]
Clave=MinimosProfesionales
Nombre=Minimos Profesionales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=262
PosicionInicialArriba=168
PosicionInicialAltura=432
PosicionInicialAncho=500
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MinimosProfesionales
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
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)

[Lista.MinimosProfesionales.Numero]
Carpeta=Lista
Clave=MinimosProfesionales.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MinimosProfesionales.Descripcion]
Carpeta=Lista
Clave=MinimosProfesionales.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MinimosProfesionales.ZonaA]
Carpeta=Lista
Clave=MinimosProfesionales.ZonaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MinimosProfesionales.ZonaB]
Carpeta=Lista
Clave=MinimosProfesionales.ZonaB
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MinimosProfesionales.ZonaC]
Carpeta=Lista
Clave=MinimosProfesionales.ZonaC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Numero=43
Descripcion=232
ZonaA=64
ZonaB=64
ZonaC=64

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

[Lista.ListaEnCaptura]
(Inicio)=MinimosProfesionales.Numero
MinimosProfesionales.Numero=MinimosProfesionales.Descripcion
MinimosProfesionales.Descripcion=MinimosProfesionales.ZonaA
MinimosProfesionales.ZonaA=MinimosProfesionales.ZonaB
MinimosProfesionales.ZonaB=MinimosProfesionales.ZonaC
MinimosProfesionales.ZonaC=(Fin)
