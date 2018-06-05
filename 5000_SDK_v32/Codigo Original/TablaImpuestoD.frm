[Forma]
Clave=TablaImpuestoD
Nombre=Info.Tabla+<T> - <T>+Info.PeriodoTipo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=651
PosicionInicialArriba=348
PosicionInicialAltura=346
PosicionInicialAncho=439
PosicionInicialAlturaCliente=319

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaImpuestoD
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
ListaOrden=TablaImpuestoD.LimiteInferior<TAB>(Acendente)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=TablaImpuestoD.TablaImpuesto=<T>{Info.Tabla}<T> AND<BR>TablaImpuestoD.PeriodoTipo=<T>{Info.PeriodoTipo}<T>

[Lista.TablaImpuestoD.LimiteInferior]
Carpeta=Lista
Clave=TablaImpuestoD.LimiteInferior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaImpuestoD.LimiteSuperior]
Carpeta=Lista
Clave=TablaImpuestoD.LimiteSuperior
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaImpuestoD.Cuota]
Carpeta=Lista
Clave=TablaImpuestoD.Cuota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.TablaImpuestoD.Porcentaje]
Carpeta=Lista
Clave=TablaImpuestoD.Porcentaje
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
LimiteInferior=102
LimiteSuperior=98
Cuota=87
Porcentaje=59
TablaImpuesto=96
PeriodoTipo=82
Descuento=59

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Acciones.Historico]
Nombre=Historico
Boton=53
NombreEnBoton=S
NombreDesplegar=&Histórico de Cambios
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TablaImpuestoHist
Activo=S
Visible=S

[Lista.TablaImpuestoD.Descuento]
Carpeta=Lista
Clave=TablaImpuestoD.Descuento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=Historico
Historico=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TablaImpuestoD.LimiteInferior
TablaImpuestoD.LimiteInferior=TablaImpuestoD.LimiteSuperior
TablaImpuestoD.LimiteSuperior=TablaImpuestoD.Cuota
TablaImpuestoD.Cuota=TablaImpuestoD.Porcentaje
TablaImpuestoD.Porcentaje=TablaImpuestoD.Descuento
TablaImpuestoD.Descuento=(Fin)
