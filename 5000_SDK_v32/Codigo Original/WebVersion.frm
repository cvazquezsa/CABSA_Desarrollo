
[Forma]
Clave=WebVersion
Icono=0
Modulos=(Todos)
Nombre=Configuración - SFTP
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
CarpetaPrincipal=WebVersion

ListaCarpetas=WebVersion
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=376
PosicionInicialArriba=227
PosicionInicialAlturaCliente=275
PosicionInicialAncho=675
[WebVersion]
Estilo=Ficha
Clave=WebVersion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebVersion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S



[WebVersion.WebVersion.WebUsuario]
Carpeta=WebVersion
Clave=WebVersion.WebUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco


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

[Lista.Columnas]
Usuario=95
Nombre=220
GrupoTrabajo=177
0=99
1=375


[WebVersion.WebVersion.Ftpuser]
Carpeta=WebVersion
Clave=WebVersion.Ftpuser
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco

[WebVersion.WebVersion.Ftppassword]
Carpeta=WebVersion
Clave=WebVersion.Ftppassword
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=44
ColorFondo=Blanco

[WebVersion.WebVersion.Ftphostr]
Carpeta=WebVersion
Clave=WebVersion.Ftphostr
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=64
ColorFondo=Blanco

[WebVersion.WebVersion.Ftprutawinscp]
Carpeta=WebVersion
Clave=WebVersion.Ftprutawinscp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90
ColorFondo=Blanco







































[WebVersion.WebVersion.DirSFTP]
Carpeta=WebVersion
Clave=WebVersion.DirSFTP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90
ColorFondo=Blanco








[WebVersion.WebVersion.WebArtDirectorio]
Carpeta=WebVersion
Clave=WebVersion.WebArtDirectorio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=90
ColorFondo=Blanco



[WebVersion.ListaEnCaptura]
(Inicio)=WebVersion.WebUsuario
WebVersion.WebUsuario=WebVersion.Ftphostr
WebVersion.Ftphostr=WebVersion.Ftpuser
WebVersion.Ftpuser=WebVersion.Ftppassword
WebVersion.Ftppassword=WebVersion.DirSFTP
WebVersion.DirSFTP=WebVersion.WebArtDirectorio
WebVersion.WebArtDirectorio=WebVersion.Ftprutawinscp
WebVersion.Ftprutawinscp=(Fin)
