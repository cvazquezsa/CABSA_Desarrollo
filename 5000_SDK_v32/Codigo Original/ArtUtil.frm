[Forma]
Clave=ArtUtil
Nombre=Tipos de Margenes de Utilidad
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=364
PosicionInicialArriba=234
PosicionInicialAltura=300
PosicionInicialAncho=296
ListaAcciones=(Lista)
CarpetaPrincipal=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S

[Lista]
Estilo=Hoja
Pestana=
PestanaOtroNombre=
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=ArtUtil
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=Si
HojaMostrarColumnas=Si
HojaMostrarRenglones=Si
HojaAjustarColumnas=
HojaColoresPorEstatus=Si
HojaMantenerSeleccion=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=Si
PermiteEditar=Si
HojaConfirmarEliminar=Si

[Lista.ArtUtil.Utilidad]
Carpeta=Lista
Clave=ArtUtil.Utilidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

[Lista.Columnas]
Utilidad=118
Descripcion=313
Margen=75
Incremento=72

[Detalle.ArtUtil.Utilidad]
Carpeta=Detalle
Clave=ArtUtil.Utilidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalle.ArtUtil.Margen]
Carpeta=Detalle
Clave=ArtUtil.Margen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Detalle.ArtUtil.Incremento]
Carpeta=Detalle
Clave=ArtUtil.Incremento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Detalle.Columnas]
Utilidad=34
Descripcion=304
Margen=64
Incremento=64

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=Si
EnBarraAcciones=Si
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=Si
Activo=Si
NombreEnBoton=Si
EnBarraHerramientas=Si

[Lista.ArtUtil.Margen]
Carpeta=Lista
Clave=ArtUtil.Margen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.ArtUtil.Incremento]
Carpeta=Lista
Clave=ArtUtil.Incremento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtUtil.Utilidad
ArtUtil.Utilidad=ArtUtil.Margen
ArtUtil.Margen=ArtUtil.Incremento
ArtUtil.Incremento=(Fin)
