[Forma]
Clave=ChryslerTOV
Nombre=Tabla Objetivos Venta
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=265
PosicionInicialArriba=191
PosicionInicialAlturaCliente=352
PosicionInicialAncho=493

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ChryslerTOV
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

[Lista.ChryslerTOV.Ejercicio]
Carpeta=Lista
Clave=ChryslerTOV.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTOV.Periodo]
Carpeta=Lista
Clave=ChryslerTOV.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTOV.ObjetivoMenudeo]
Carpeta=Lista
Clave=ChryslerTOV.ObjetivoMenudeo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTOV.ObjetivoFlotilla]
Carpeta=Lista
Clave=ChryslerTOV.ObjetivoFlotilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTOV.VentasMenudeo]
Carpeta=Lista
Clave=ChryslerTOV.VentasMenudeo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ChryslerTOV.VentasFlotilla]
Carpeta=Lista
Clave=ChryslerTOV.VentasFlotilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Empresa=48
Ejercicio=68
Periodo=60
ObjetivoMenudeo=98
ObjetivoFlotilla=78
VentasMenudeo=84
VentasFlotilla=70

[Lista.ListaEnCaptura]
(Inicio)=ChryslerTOV.Ejercicio
ChryslerTOV.Ejercicio=ChryslerTOV.Periodo
ChryslerTOV.Periodo=ChryslerTOV.ObjetivoMenudeo
ChryslerTOV.ObjetivoMenudeo=ChryslerTOV.ObjetivoFlotilla
ChryslerTOV.ObjetivoFlotilla=ChryslerTOV.VentasMenudeo
ChryslerTOV.VentasMenudeo=ChryslerTOV.VentasFlotilla
ChryslerTOV.VentasFlotilla=(Fin)
