
[Forma]
Clave=TipoSistemaExperto
Icono=0
Modulos=(Todos)
Nombre=Tipos de Sistema Experto

ListaCarpetas=TipoSistemaExperto
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
CarpetaPrincipal=TipoSistemaExperto
PosicionInicialIzquierda=491
PosicionInicialArriba=220
PosicionInicialAlturaCliente=326
PosicionInicialAncho=297
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[TipoSistemaExperto]
Estilo=Hoja
Clave=TipoSistemaExperto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoSistemaExperto
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoSistemaExperto.Descripcion
CarpetaVisible=S

[TipoSistemaExperto.TipoSistemaExperto.Descripcion]
Carpeta=TipoSistemaExperto
Clave=TipoSistemaExperto.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


EspacioPrevio=S
[TipoSistemaExperto.Columnas]
Descripcion=267

























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=EnvioExcel
EnvioExcel=(Fin)
