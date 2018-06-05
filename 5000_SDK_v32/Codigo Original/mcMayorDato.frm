[Forma]
Clave=mcMayorDato
Nombre=Datos de la Cuenta
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=605
PosicionInicialArriba=315
PosicionInicialAlturaCliente=533
PosicionInicialAncho=709
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Mayor
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcMayorDato
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=mcMayorDato.Mayor=<T>{Info.Mayor}<T>

[Lista.mcMayorDato.DatoDestino]
Carpeta=Lista
Clave=mcMayorDato.DatoDestino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Dato=269
DatoDestino=247
DatoOrigen=270
DatoRequerido=81
Mayor=124
AceptaCeros=71

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

[Lista.mcMayorDato.DatoRequerido]
Carpeta=Lista
Clave=mcMayorDato.DatoRequerido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcMayorDato.AceptaCeros]
Carpeta=Lista
Clave=mcMayorDato.AceptaCeros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcMayorDato.Dato]
Carpeta=Lista
Clave=mcMayorDato.Dato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=mcMayorDato.Dato
mcMayorDato.Dato=mcMayorDato.DatoDestino
mcMayorDato.DatoDestino=mcMayorDato.DatoRequerido
mcMayorDato.DatoRequerido=mcMayorDato.AceptaCeros
mcMayorDato.AceptaCeros=(Fin)
