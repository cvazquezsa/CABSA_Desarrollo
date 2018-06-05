
[Forma]
Clave=MonActualizacionAuto
Icono=0
CarpetaPrincipal=Hoja
Modulos=(Todos)
Nombre=Actualización automática de Tipo de Cambio

ListaCarpetas=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=438
PosicionInicialArriba=231
PosicionInicialAlturaCliente=369
PosicionInicialAncho=723
PosicionCol1=336
ListaAcciones=(Lista)
[Hoja]
Estilo=Ficha
PestanaOtroNombre=S
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MonActualizacionAuto
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S


[Hoja.MonActualizacionAuto.Url]
Carpeta=Hoja
Clave=MonActualizacionAuto.Url
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=50
[Hoja.MonActualizacionAuto.ExpInicial]
Carpeta=Hoja
Clave=MonActualizacionAuto.ExpInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=50
[Hoja.MonActualizacionAuto.ExpFinal]
Carpeta=Hoja
Clave=MonActualizacionAuto.ExpFinal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=50
[Hoja.Columnas]
ActualizacionAuto=304
Url=304
ExpInicial=304
ExpFinal=304






[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MonActualizacionAuto
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
ListaEnCaptura=MonActualizacionAuto.ActualizacionAuto
CarpetaVisible=S

PestanaOtroNombre=S
[Lista.MonActualizacionAuto.ActualizacionAuto]
Carpeta=Lista
Clave=MonActualizacionAuto.ActualizacionAuto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Lista.Columnas]
ActualizacionAuto=304







[Hoja.ListaEnCaptura]
(Inicio)=MonActualizacionAuto.Url
MonActualizacionAuto.Url=MonActualizacionAuto.ExpInicial
MonActualizacionAuto.ExpInicial=MonActualizacionAuto.ExpFinal
MonActualizacionAuto.ExpFinal=(Fin)














[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Navegador]
Nombre=Navegador
Boton=0
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Completo (Registros)
Activo=S
Visible=S



EspacioPrevio=S








[Forma.ListaCarpetas]
(Inicio)=Hoja
Hoja=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Navegador
Navegador=(Fin)
