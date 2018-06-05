[Forma]
Clave=MenuTicker
Nombre=Ticker
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=245
PosicionInicialArriba=295
PosicionInicialAlturaCliente=400
PosicionInicialAncho=790
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mensaje Primario
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MenuTicker
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.MenuTicker.Tipo1]
Carpeta=Ficha
Clave=MenuTicker.Tipo1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MenuTicker.Mensaje1]
Carpeta=Ficha
Clave=MenuTicker.Mensaje1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=100x20

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Secundario]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mensaje Secundario
Clave=Secundario
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MenuTicker
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Secundario.MenuTicker.Tipo2]
Carpeta=Secundario
Clave=MenuTicker.Tipo2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Secundario.MenuTicker.Mensaje2]
Carpeta=Secundario
Clave=MenuTicker.Mensaje2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Secundario
Secundario=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=MenuTicker.Tipo1
MenuTicker.Tipo1=MenuTicker.Mensaje1
MenuTicker.Mensaje1=(Fin)

[Secundario.ListaEnCaptura]
(Inicio)=MenuTicker.Tipo2
MenuTicker.Tipo2=MenuTicker.Mensaje2
MenuTicker.Mensaje2=(Fin)
