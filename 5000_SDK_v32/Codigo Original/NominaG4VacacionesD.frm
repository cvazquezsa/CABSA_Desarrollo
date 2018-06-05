
[Forma]
Clave=NominaG4VacacionesD
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Detalle

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ListaAcciones=GuardarCerrar
PosicionInicialIzquierda=502
PosicionInicialArriba=125
PosicionInicialAlturaCliente=438
PosicionInicialAncho=361
Comentarios=Info.ABC
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaG4VacacionesD
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=NominaG4VacacionesD.TipoSindicato = <T>{Info.ABC}<T>
[Lista.NominaG4VacacionesD.Antiguedad]
Carpeta=Lista
Clave=NominaG4VacacionesD.Antiguedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NominaG4VacacionesD.Vacaciones]
Carpeta=Lista
Clave=NominaG4VacacionesD.Vacaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NominaG4VacacionesD.PrimaVacacional]
Carpeta=Lista
Clave=NominaG4VacacionesD.PrimaVacacional
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.NominaG4VacacionesD.Aguinaldo]
Carpeta=Lista
Clave=NominaG4VacacionesD.Aguinaldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=NominaG4VacacionesD.Antiguedad
NominaG4VacacionesD.Antiguedad=NominaG4VacacionesD.Vacaciones
NominaG4VacacionesD.Vacaciones=NominaG4VacacionesD.PrimaVacacional
NominaG4VacacionesD.PrimaVacacional=NominaG4VacacionesD.Aguinaldo
NominaG4VacacionesD.Aguinaldo=(Fin)

[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Antiguedad=72
Vacaciones=64
PrimaVacacional=110
Aguinaldo=64
