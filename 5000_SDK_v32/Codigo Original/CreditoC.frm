[Forma]
Clave=CreditoC
Nombre=<T>Consecutivos - Crédito<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=422
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=436
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
Vista=CreditoC
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
FiltroGeneral=Sucursal={Sucursal} AND CreditoC.Empresa=<T>{Empresa}<T>

[Hoja.CreditoC.Mov]
Carpeta=Hoja
Clave=CreditoC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CreditoC.Periodo]
Carpeta=Hoja
Clave=CreditoC.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CreditoC.Ejercicio]
Carpeta=Hoja
Clave=CreditoC.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.CreditoC.Consecutivo]
Carpeta=Hoja
Clave=CreditoC.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Serie=88
Periodo=43
Ejercicio=47
Consecutivo=99

[Hoja.CreditoC.Serie]
Carpeta=Hoja
Clave=CreditoC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ListaEnCaptura]
(Inicio)=CreditoC.Mov
CreditoC.Mov=CreditoC.Periodo
CreditoC.Periodo=CreditoC.Ejercicio
CreditoC.Ejercicio=CreditoC.Serie
CreditoC.Serie=CreditoC.Consecutivo
CreditoC.Consecutivo=(Fin)

[Hoja.ListaOrden]
(Inicio)=CreditoC.Mov<TAB>(Acendente)
CreditoC.Mov<TAB>(Acendente)=CreditoC.Serie<TAB>(Acendente)
CreditoC.Serie<TAB>(Acendente)=CreditoC.Periodo<TAB>(Acendente)
CreditoC.Periodo<TAB>(Acendente)=CreditoC.Ejercicio<TAB>(Acendente)
CreditoC.Ejercicio<TAB>(Acendente)=(Fin)
