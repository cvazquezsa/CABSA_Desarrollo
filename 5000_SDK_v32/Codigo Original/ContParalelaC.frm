[Forma]
Clave=ContParalelaC
Nombre=<T>Consecutivos - Contabilidad Paralela<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=511
PosicionInicialArriba=208
PosicionInicialAltura=300
PosicionInicialAncho=344
Comentarios=Empresa
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=
VentanaEscCerrar=
PosicionInicialAlturaCliente=273

[Hoja]
Estilo=Hoja
Clave=Hoja
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaC
Fuente={MS Sans Serif, 8, Negro, []}
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
OtroOrden=S
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=Sucursal={Sucursal} AND ContParalelaC.Empresa=<T>{Empresa}<T>
[Hoja.ContParalelaC.Mov]
Carpeta=Hoja
Clave=ContParalelaC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Hoja.ContParalelaC.Consecutivo]
Carpeta=Hoja
Clave=ContParalelaC.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Hoja.Columnas]
Mov=126
Serie=84
Periodo=43
Ejercicio=47
Consecutivo=99

[Hoja.ContParalelaC.Serie]
Carpeta=Hoja
Clave=ContParalelaC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Hoja.ListaEnCaptura]
(Inicio)=ContParalelaC.Mov
ContParalelaC.Mov=ContParalelaC.Serie
ContParalelaC.Serie=ContParalelaC.Consecutivo
ContParalelaC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=ContParalelaC.Mov	(Acendente)
ContParalelaC.Mov	(Acendente)=ContParalelaC.Serie	(Acendente)
ContParalelaC.Serie	(Acendente)=ContParalelaC.Periodo	(Acendente)
ContParalelaC.Periodo	(Acendente)=ContParalelaC.Ejercicio	(Acendente)
ContParalelaC.Ejercicio	(Acendente)=(Fin)
