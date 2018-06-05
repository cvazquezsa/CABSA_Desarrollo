[Forma]
Clave=ContAutoD
Nombre=Contabilidad Automática - Movimiento Especifico
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=679
PosicionInicialArriba=446
PosicionInicialAlturaCliente=273
PosicionInicialAncho=562
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(e(<T>Empresa<T>)+<T>: <T>+Info.Empresa, Info.MovTipo)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=MovTipo.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipo.Clave=<T>{Info.MovTipo}<T>

[Lista.MovTipo.Mov]
Carpeta=Lista
Clave=MovTipo.Mov
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=320
EstatusContabilizar=107
AfectarPresupuesto=105

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Poliza]
Nombre=Poliza
Boton=47
NombreEnBoton=S
NombreDesplegar=&Póliza
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MovTipoContAuto
Activo=S
Antes=S
Visible=S
ConCondicion=S
EspacioPrevio=S
GuardarAntes=S
EjecucionCondicion=ConDatos(MovTipo:MovTipo.Mov)
AntesExpresiones=Asigna(Info.Clave, MovTipo:MovTipo.Mov)

[Lista.MovTipo.EstatusContabilizar]
Carpeta=Lista
Clave=MovTipo.EstatusContabilizar
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Editar=S

[Lista.MovTipo.AfectarPresupuesto]
Carpeta=Lista
Clave=MovTipo.AfectarPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=MovTipo.Mov
MovTipo.Mov=MovTipo.AfectarPresupuesto
MovTipo.AfectarPresupuesto=MovTipo.EstatusContabilizar
MovTipo.EstatusContabilizar=(Fin)





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Poliza
Poliza=(Fin)
