[Forma]
Clave=TipoTercero
Nombre=Tipo Tercero (Proveedores)
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=602
PosicionInicialArriba=227
PosicionInicialAltura=345
PosicionInicialAncho=405
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S

PosicionInicialAlturaCliente=346
[TipoTercero.Columnas]
Categoria=104
Descripcion=304

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoTercero
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
CarpetaVisible=S
HojaAjustarColumnas=S
PermiteEditar=S
HojaConfirmarEliminar=S


HojaMostrarColumnas=S
HojaTitulos=S
[Lista.Columnas]
Categoria=242
Descripcion=325

TipoTercero=164
Codigo=162
Clave=200
[Detalles.TipoTercero.Categoria]
Carpeta=Detalles
Clave=TipoTercero.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.TipoTercero.Icono]
Carpeta=Detalles
Clave=TipoTercero.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
GuardarAntes=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S









[Lista.TipoTercero.Codigo]
Carpeta=Lista
Clave=TipoTercero.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TipoTercero.Clave]
Carpeta=Lista
Clave=TipoTercero.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco










[Lista.ListaEnCaptura]
(Inicio)=TipoTercero.Codigo
TipoTercero.Codigo=TipoTercero.Clave
TipoTercero.Clave=(Fin)

[Lista.ListaOrden]
(Inicio)=TipoTercero.Codigo	(Acendente)
TipoTercero.Codigo	(Acendente)=TipoTercero.Clave	(Acendente)
TipoTercero.Clave	(Acendente)=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
