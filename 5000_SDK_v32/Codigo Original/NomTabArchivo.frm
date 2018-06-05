
[Forma]
Clave=NomTabArchivo
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración de Archivo
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Cerrar
ListaCarpetas=Inicio
CarpetaPrincipal=Inicio
PosicionInicialIzquierda=381
PosicionInicialArriba=213
PosicionInicialAlturaCliente=273
PosicionInicialAncho=571
[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Inicio]
Estilo=Ficha
Clave=Inicio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomTabArchivo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[Inicio.ListaEnCaptura]
(Inicio)=NomTabArchivo.RutaArchivo
NomTabArchivo.RutaArchivo=NomTabArchivo.NombreArchivo
NomTabArchivo.NombreArchivo=NomTabArchivo.BaseDatos
NomTabArchivo.BaseDatos=(Fin)

[Inicio.NomTabArchivo.RutaArchivo]
Carpeta=Inicio
Clave=NomTabArchivo.RutaArchivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Inicio.NomTabArchivo.NombreArchivo]
Carpeta=Inicio
Clave=NomTabArchivo.NombreArchivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco

[Inicio.NomTabArchivo.BaseDatos]
Carpeta=Inicio
Clave=NomTabArchivo.BaseDatos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
