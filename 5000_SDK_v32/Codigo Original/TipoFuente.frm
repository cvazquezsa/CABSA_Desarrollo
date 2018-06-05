
[Forma]
Clave=TipoFuente
Icono=0
Modulos=(Todos)
Nombre=Tipos de Fuente

ListaCarpetas=TipoFuente
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
CarpetaPrincipal=TipoFuente
PosicionInicialIzquierda=471
PosicionInicialArriba=216
PosicionInicialAlturaCliente=273
PosicionInicialAncho=347


VentanaTipoMarco=Diálogo
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.EnvioExcel]
Nombre=EnvioExcel
Boton=67
NombreDesplegar=EnvioExcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S


EspacioPrevio=S
[TipoFuente.Columnas]
TipoFuenteID=64
Descripcion=317

[TipoFuente.ListaEnCaptura]
(Inicio)=TipoFuente.TipoFuenteID
TipoFuente.TipoFuenteID=TipoFuente.Descripcion
TipoFuente.Descripcion=(Fin)








[TipoFuenteLista.Columnas]
Descripcion=318


















































[TipoFuente]
Estilo=Hoja
Clave=TipoFuente
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoFuente
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoFuente.Descripcion
CarpetaVisible=S

[TipoFuente.TipoFuente.Descripcion]
Carpeta=TipoFuente
Clave=TipoFuente.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=EnvioExcel
EnvioExcel=(Fin)
