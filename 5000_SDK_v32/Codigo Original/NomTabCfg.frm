
[Forma]
Clave=NomTabCfg
Icono=0
Modulos=(Todos)
Nombre=Nomina Tabular Configuración

ListaCarpetas=Inicio
CarpetaPrincipal=Inicio
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Guardar
PosicionInicialIzquierda=432
PosicionInicialArriba=130
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
BarraHerramientas=S
[Inicio]
Estilo=Hoja
Clave=Inicio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomTabCfg
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
OtroOrden=S

ListaOrden=(Lista)
[Inicio.NomTabCfg.Columna]
Carpeta=Inicio
Clave=NomTabCfg.Columna
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Inicio.NomTabCfg.Concepto]
Carpeta=Inicio
Clave=NomTabCfg.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Inicio.NomTabCfg.Tipo]
Carpeta=Inicio
Clave=NomTabCfg.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

EnBarraHerramientas=S
[Inicio.Columnas]
Columna=64
Concepto=259
Tipo=124



[Inicio.ListaEnCaptura]
(Inicio)=NomTabCfg.Columna
NomTabCfg.Columna=NomTabCfg.Concepto
NomTabCfg.Concepto=NomTabCfg.Tipo
NomTabCfg.Tipo=(Fin)

[Inicio.ListaOrden]
(Inicio)=NomTabCfg.Tipo	(Acendente)
NomTabCfg.Tipo	(Acendente)=NomTabCfg.Columna	(Acendente)
NomTabCfg.Columna	(Acendente)=(Fin)
