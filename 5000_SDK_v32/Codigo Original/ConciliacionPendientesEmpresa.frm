[Forma]
Clave=ConciliacionPendientesEmpresa
Nombre=Editar Conceptos Pendientes Empresa
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=515
PosicionInicialArriba=335
PosicionInicialAlturaCliente=493
PosicionInicialAncho=889
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConciliacionD2
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=ConciliacionD.ID={Info.ID} AND ConciliacionD.Seccion=2

[Lista.ConciliacionD.Fecha]
Carpeta=Lista
Clave=ConciliacionD.Fecha
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Editar=N

[Lista.ConciliacionD.Concepto]
Carpeta=Lista
Clave=ConciliacionD.Concepto
Editar=S
EditarConBloqueo=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFuente=Negro
ColorFondo=Blanco

[Lista.ConciliacionD.Referencia]
Carpeta=Lista
Clave=ConciliacionD.Referencia
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro
Editar=N

[Lista.ConciliacionD.Cargo]
Carpeta=Lista
Clave=ConciliacionD.Cargo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Editar=N

[Lista.ConciliacionD.Abono]
Carpeta=Lista
Clave=ConciliacionD.Abono
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Editar=N

[Lista.Columnas]
Fecha=94
Concepto=304
Referencia=192
Cargo=141
Abono=117

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ConciliacionD.Fecha
ConciliacionD.Fecha=ConciliacionD.Concepto
ConciliacionD.Concepto=ConciliacionD.Referencia
ConciliacionD.Referencia=ConciliacionD.Cargo
ConciliacionD.Cargo=ConciliacionD.Abono
ConciliacionD.Abono=(Fin)
