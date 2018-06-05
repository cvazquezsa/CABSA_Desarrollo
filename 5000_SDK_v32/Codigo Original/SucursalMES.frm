
[Forma]
Clave=SucursalMes
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Sucursales Mes
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=1608
PosicionInicialArriba=236
PosicionInicialAlturaCliente=428
PosicionInicialAncho=799
PosicionCol1=313
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SucursalMes
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
[Lista.ListaEnCaptura]
(Inicio)=SucursalMes.Sucursal
SucursalMes.Sucursal=Sucursal.Nombre
Sucursal.Nombre=(Fin)

[Lista.SucursalMes.Sucursal]
Carpeta=Lista
Clave=SucursalMes.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Sucursal.Nombre]
Carpeta=Lista
Clave=Sucursal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

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

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=SucursalMes
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

[Ficha.SucursalMes.Sucursal]
Carpeta=Ficha
Clave=SucursalMes.Sucursal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Sucursal.Nombre]
Carpeta=Ficha
Clave=Sucursal.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco

[Ficha.SucursalMes.Server]
Carpeta=Ficha
Clave=SucursalMes.Server
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SucursalMes.UserMes]
Carpeta=Ficha
Clave=SucursalMes.UserMes
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SucursalMes.Pass]
Carpeta=Ficha
Clave=SucursalMes.Pass
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Ficha.SucursalMes.FormatoFecha]
Carpeta=Ficha
Clave=SucursalMes.FormatoFecha
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SucursalMes.OptSyncServicio]
Carpeta=Ficha
Clave=SucursalMes.OptSyncServicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SucursalMes.TiempoSyncServicio]
Carpeta=Ficha
Clave=SucursalMes.TiempoSyncServicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.SucursalMes.DeleteLOGFiles]
Carpeta=Ficha
Clave=SucursalMes.DeleteLOGFiles
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Lista.Columnas]
Sucursal=52
Nombre=225





0=91
1=267

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Ficha
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

























[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=Eliminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S














[Ficha.SucursalMes.BDMES]
Carpeta=Ficha
Clave=SucursalMes.BDMES
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
















[Ficha.SucursalMes.BDINT]
Carpeta=Ficha
Clave=SucursalMes.BDINT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



EspacioPrevio=S


[Ficha.ListaEnCaptura]
(Inicio)=SucursalMes.Sucursal
SucursalMes.Sucursal=Sucursal.Nombre
Sucursal.Nombre=SucursalMes.Server
SucursalMes.Server=SucursalMes.UserMes
SucursalMes.UserMes=SucursalMes.Pass
SucursalMes.Pass=SucursalMes.BDMES
SucursalMes.BDMES=SucursalMes.FormatoFecha
SucursalMes.FormatoFecha=SucursalMes.OptSyncServicio
SucursalMes.OptSyncServicio=SucursalMes.TiempoSyncServicio
SucursalMes.TiempoSyncServicio=SucursalMes.DeleteLOGFiles
SucursalMes.DeleteLOGFiles=SucursalMes.BDINT
SucursalMes.BDINT=(Fin)





[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=(Fin)
