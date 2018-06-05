[Forma]
Clave=ArtArancelProgramaSectorial
Nombre=Programas Sectoriales del Arancel
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=441
PosicionInicialArriba=311
PosicionInicialAlturaCliente=374
PosicionInicialAncho=398
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Arancel
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtArancelProgramaSectorial
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ArtArancelProgramaSectorial.Arancel=<T>{Info.Arancel}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Lista.ArtArancelProgramaSectorial.ProgramaSectorial]
Carpeta=Lista
Clave=ArtArancelProgramaSectorial.ProgramaSectorial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtArancelProgramaSectorial.Porcentaje]
Carpeta=Lista
Clave=ArtArancelProgramaSectorial.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
ProgramaSectorial=304
Porcentaje=64

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

[Lista.ListaEnCaptura]
(Inicio)=ArtArancelProgramaSectorial.ProgramaSectorial
ArtArancelProgramaSectorial.ProgramaSectorial=ArtArancelProgramaSectorial.Porcentaje
ArtArancelProgramaSectorial.Porcentaje=(Fin)
