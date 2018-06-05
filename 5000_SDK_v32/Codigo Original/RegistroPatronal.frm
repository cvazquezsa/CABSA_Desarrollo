
[Forma]
Clave=RegistroPatronal
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Registro Patronal
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=390
PosicionInicialArriba=358
PosicionInicialAlturaCliente=273
PosicionInicialAncho=539
[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Registro Patronal
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RegistroPatronal
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

ListaOrden=RegistroPatronal.RegistroPatronal<TAB>(Acendente)
CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=RegistroPatronal.RegistroPatronal
RegistroPatronal.RegistroPatronal=RegistroPatronal.AnexoCertificado
RegistroPatronal.AnexoCertificado=RegistroPatronal.Usuario
RegistroPatronal.Usuario=RegistroPatronal.Contrasena
RegistroPatronal.Contrasena=(Fin)

[Lista.RegistroPatronal.RegistroPatronal]
Carpeta=Lista
Clave=RegistroPatronal.RegistroPatronal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RegistroPatronal.AnexoCertificado]
Carpeta=Lista
Clave=RegistroPatronal.AnexoCertificado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RegistroPatronal.Usuario]
Carpeta=Lista
Clave=RegistroPatronal.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RegistroPatronal.Contrasena]
Carpeta=Lista
Clave=RegistroPatronal.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
RegistroPatronal=124
AnexoCertificado=204
Usuario=81
Contrasena=97
