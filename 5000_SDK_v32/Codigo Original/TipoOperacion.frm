[Forma]
Clave=TipoOperacion
Nombre=Tipo Operación (Proveedores)
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=603
PosicionInicialArriba=226
PosicionInicialAltura=345
PosicionInicialAncho=404
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S

PosicionInicialAlturaCliente=347
[ProvTipoercero.Columnas]
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
Vista=TipoOperacion
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
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

TipoOperacion=177
Codigo=177
Clave=183
[Detalles.ProvTipoercero.Categoria]
Carpeta=Detalles
Clave=ProvTipoercero.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.ProvTipoercero.Icono]
Carpeta=Detalles
Clave=ProvTipoercero.Icono
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
Visible=S












ActivoCondicion=Usuario.EnviarExcel

[Lista.TipoOperacion.Codigo]
Carpeta=Lista
Clave=TipoOperacion.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.TipoOperacion.Clave]
Carpeta=Lista
Clave=TipoOperacion.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco











[Lista.ListaEnCaptura]
(Inicio)=TipoOperacion.Codigo
TipoOperacion.Codigo=TipoOperacion.Clave
TipoOperacion.Clave=(Fin)

[Lista.ListaOrden]
(Inicio)=TipoOperacion.Codigo	(Acendente)
TipoOperacion.Codigo	(Acendente)=TipoOperacion.Clave	(Acendente)
TipoOperacion.Clave	(Acendente)=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
