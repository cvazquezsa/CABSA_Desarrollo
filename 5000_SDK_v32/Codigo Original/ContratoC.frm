[Forma]
Clave=ContratoC
Nombre=<T>Consecutivos - Contratos<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Hoja
CarpetaPrincipal=Hoja
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialIzquierda=787
PosicionInicialArriba=446
PosicionInicialAltura=300
PosicionInicialAncho=346
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
Vista=ContratoC
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
ListaEnContrato=ContratoC.Mov<BR>ContratoC.Serie<BR>ContratoC.Consecutivo
CarpetaVisible=S
Filtros=S
OtroOrden=S
ListaOrden=ContratoC.Mov<TAB>(Acendente)<BR>ContratoC.Serie<TAB>(Acendente)<BR>ContratoC.Periodo<TAB>(Acendente)<BR>ContratoC.Ejercicio<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=ContratoC.Mov<BR>ContratoC.Serie<BR>ContratoC.Consecutivo
FiltroGeneral=Sucursal={Sucursal} AND ContratoC.Empresa=<T>{Empresa}<T>

[Hoja.ContratoC.Mov]
Carpeta=Hoja
Clave=ContratoC.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Hoja.ContratoC.Consecutivo]
Carpeta=Hoja
Clave=ContratoC.Consecutivo
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
Serie=90
Periodo=43
Ejercicio=47
Consecutivo=99
ID=165

[Hoja.ContratoC.Serie]
Carpeta=Hoja
Clave=ContratoC.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
