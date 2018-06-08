[Forma]
Clave=ConfigDispersion
Icono=0
Modulos=(Todos)
Nombre=<T>Configuración: Dispersión y Envío de Comprobantes<T>

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
VentanaColor=Plata
PosicionInicialIzquierda=374
PosicionInicialArriba=128
PosicionInicialAlturaCliente=444
PosicionInicialAncho=617
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionSec1=143
ListaAcciones=Guardar
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConfigDispersion
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
CarpetaVisible=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Dispersión de Pagos

ListaEnCaptura=(Lista)
ExpAntesRefrescar=Asigna(Temp.ID,0)
RefrescarAlEntrar=S
[Comprobantes]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Envío de Comprobantes
Clave=Comprobantes
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConfigDispersion
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
CarpetaVisible=S


ListaEnCaptura=(Lista)
ExpAntesRefrescar=Asigna(Temp.ID, 1)
RefrescarAlEntrar=S

[Lista.ConfigDispersion.RutaDestino]
Carpeta=Lista
Clave=ConfigDispersion.RutaDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Comprobantes.ConfigDispersion.Asunto]
Carpeta=Comprobantes
Clave=ConfigDispersion.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco

[Comprobantes.ConfigDispersion.Mensaje]
Carpeta=Comprobantes
Clave=ConfigDispersion.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70
ColorFondo=Blanco







[Detalle.Columnas]
NombreServer=604



















[Detalle.ListaEnCaptura]
(Inicio)=ConfigDispersion.NombreServer
ConfigDispersion.NombreServer=ConfigDispersion.Puerto
ConfigDispersion.Puerto=ConfigDispersion.eMail
ConfigDispersion.eMail=ConfigDispersion.Contrasena
ConfigDispersion.Contrasena=ConfigDispersion.Contrasena1
ConfigDispersion.Contrasena1=ConfigDispersion.ConexionSSL
ConfigDispersion.ConexionSSL=(Fin)




[Servidor]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Servidor de Correo Saliente
Clave=Servidor
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ConfigDispersion
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


CondicionVisible=Temp.ID=1
[Servidor.ConfigDispersion.NombreServer]
Carpeta=Servidor
Clave=ConfigDispersion.NombreServer
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Servidor.ConfigDispersion.Puerto]
Carpeta=Servidor
Clave=ConfigDispersion.Puerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Servidor.ConfigDispersion.eMail]
Carpeta=Servidor
Clave=ConfigDispersion.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Servidor.ConfigDispersion.Contrasena]
Carpeta=Servidor
Clave=ConfigDispersion.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco


[Servidor.ConfigDispersion.ConexionSSL]
Carpeta=Servidor
Clave=ConfigDispersion.ConexionSSL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Comprobantes.ListaEnCaptura]
(Inicio)=ConfigDispersion.Asunto
ConfigDispersion.Asunto=ConfigDispersion.Mensaje
ConfigDispersion.Mensaje=(Fin)




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



[Servidor.ConfigDispersion.Perfil]
Carpeta=Servidor
Clave=ConfigDispersion.Perfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco



[msdbdbosysmail_profile.Columnas]
name=604










[Lista.ListaEnCaptura]
(Inicio)=ConfigDispersion.RutaDestino
ConfigDispersion.RutaDestino=ConfigDispersion.UsuarioSQL
ConfigDispersion.UsuarioSQL=ConfigDispersion.ContrasenaSQL
ConfigDispersion.ContrasenaSQL=(Fin)

[Lista.ConfigDispersion.UsuarioSQL]
Carpeta=Lista
Clave=ConfigDispersion.UsuarioSQL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Lista.ConfigDispersion.ContrasenaSQL]
Carpeta=Lista
Clave=ConfigDispersion.ContrasenaSQL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
















[Servidor.ListaEnCaptura]
(Inicio)=ConfigDispersion.Perfil
ConfigDispersion.Perfil=ConfigDispersion.NombreServer
ConfigDispersion.NombreServer=ConfigDispersion.Puerto
ConfigDispersion.Puerto=ConfigDispersion.Cuenta
ConfigDispersion.Cuenta=ConfigDispersion.eMail
ConfigDispersion.eMail=ConfigDispersion.Contrasena
ConfigDispersion.Contrasena=ConfigDispersion.ConexionSSL
ConfigDispersion.ConexionSSL=(Fin)

[Servidor.ConfigDispersion.Cuenta]
Carpeta=Servidor
Clave=ConfigDispersion.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco





[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Comprobantes
Comprobantes=Servidor
Servidor=(Fin)
