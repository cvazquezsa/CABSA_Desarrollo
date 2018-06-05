
[Forma]
Clave=TipoEmpresaLista
Icono=0
Modulos=(Todos)
Nombre=Tipos de Empresa

ListaCarpetas=TipoEmpresaLista
CarpetaPrincipal=TipoEmpresaLista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=491
PosicionInicialArriba=212
PosicionInicialAlturaCliente=342
PosicionInicialAncho=297
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[TipoEmpresaLista]
Estilo=Hoja
Clave=TipoEmpresaLista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoEmpresa
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoEmpresa.Descripcion
CarpetaVisible=S

[TipoEmpresaLista.TipoEmpresa.Descripcion]
Carpeta=TipoEmpresaLista
Clave=TipoEmpresa.Descripcion
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
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S






[TipoEmpresaLista.Columnas]
Descripcion=267









































































[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=(Fin)
