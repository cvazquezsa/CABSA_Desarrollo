
[Forma]
Clave=TipoLicenciamientoLista
Icono=0
Modulos=(Todos)
Nombre=Tipos de Licenciamiento

ListaCarpetas=TipoLicenciamientoLista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
CarpetaPrincipal=TipoLicenciamientoLista
PosicionInicialIzquierda=466
PosicionInicialArriba=256
PosicionInicialAlturaCliente=363
PosicionInicialAncho=275
[TipoLicenciamientoLista]
Estilo=Hoja
Clave=TipoLicenciamientoLista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoLicenciamiento
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoLicenciamiento.Descripcion
CarpetaVisible=S

[TipoLicenciamientoLista.TipoLicenciamiento.Descripcion]
Carpeta=TipoLicenciamientoLista
Clave=TipoLicenciamiento.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S




[TipoLicenciamientoLista.Columnas]
Descripcion=244





[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=(Fin)
