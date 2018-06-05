[Forma]
Clave=IncidenciaH
Nombre=Incidencias en Lote
Icono=0
BarraHerramientas=S
EsMovimiento=S
Modulos=INC
TituloAuto=S
MovEspecificos=Todos
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=234
PosicionInicialArriba=266
PosicionInicialAlturaCliente=465
PosicionInicialAncho=812
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
MovModulo=INC
ExpresionesAlMostrar=Asigna(Info.Fecha, Hoy)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.NominaConcepto, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.Personal, Nulo)<BR>Asigna(Info.FechaD, Hoy-16)<BR>Asigna(Info.FechaA, Hoy-1)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IncidenciaH
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
PermiteEditar=S
ValidarCampos=S
ListaCamposAValidar=(Lista)
BusquedaRapidaControles=S
FiltroUsuarios=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroUsuarioDefault=(Usuario)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=IncidenciaH.Personal
FiltroValida1=IncidenciaH.Personal
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo2=NominaConcepto.Concepto
FiltroValida2=NominaConcepto.Concepto
FiltroTodo=S

[Lista.IncidenciaH.Mov]
Carpeta=Lista
Clave=IncidenciaH.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IncidenciaH.FechaEmision]
Carpeta=Lista
Clave=IncidenciaH.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IncidenciaH.Personal]
Carpeta=Lista
Clave=IncidenciaH.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IncidenciaH.Cantidad]
Carpeta=Lista
Clave=IncidenciaH.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IncidenciaH.Importe]
Carpeta=Lista
Clave=IncidenciaH.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
EspacioPrevio=S

[Lista.Columnas]
Mov=107
Concepto=123
FechaEmision=71
Personal=80
Cantidad=48
Importe=84
NombreCompleto=145
Referencia=101
Horas=40
FechaD=69
FechaA=75
NominaConcepto=81

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar Movimientos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Actualizar Vista
ConfirmarAntes=S
DialogoMensaje=EstaSeguro

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

[Acciones.Generar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spIncidenciaH :nEstacion, :nSuc, :tEmp, :tUsr<T>, EstacionTrabajo, Sucursal, Empresa, Usuario)
Activo=S
Visible=S

[Acciones.Generar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.IncidenciaH.Referencia]
Carpeta=Lista
Clave=IncidenciaH.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IncidenciaH.Horas]
Carpeta=Lista
Clave=IncidenciaH.Horas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IncidenciaH.FechaD]
Carpeta=Lista
Clave=IncidenciaH.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IncidenciaH.FechaA]
Carpeta=Lista
Clave=IncidenciaH.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IncidenciaH.NominaConcepto]
Carpeta=Lista
Clave=IncidenciaH.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Sugerir]
Nombre=Sugerir
Boton=20
NombreEnBoton=S
NombreDesplegar=&Sugerir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
GuardarAntes=S
Expresion=EjecutarSQL(<T>spIncidenciaSugerir :nEstacion, :tUsuario, :nSucursal, :tEmpresa, :tMov, :fFechaEmision, :fDel, :fAl<T>, EstacionTrabajo, Usuario, Sucursal, Empresa, Info.Mov, Info.Fecha, Info.FechaD, Info.FechaA)<BR>Forma.ActualizarVista(<T>Lista<T>)
EjecucionCondicion=Forma(<T>IncidenciaHSugerir<T>)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar Cambios
Guardar Cambios=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Sugerir
Sugerir=Generar
Generar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=IncidenciaH.FechaEmision
IncidenciaH.FechaEmision=IncidenciaH.Personal
IncidenciaH.Personal=IncidenciaH.Mov
IncidenciaH.Mov=IncidenciaH.NominaConcepto
IncidenciaH.NominaConcepto=IncidenciaH.Referencia
IncidenciaH.Referencia=IncidenciaH.Cantidad
IncidenciaH.Cantidad=IncidenciaH.Importe
IncidenciaH.Importe=IncidenciaH.FechaD
IncidenciaH.FechaD=IncidenciaH.FechaA
IncidenciaH.FechaA=IncidenciaH.Horas
IncidenciaH.Horas=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=NombreCompleto
NombreCompleto=NominaConcepto.Concepto
NominaConcepto.Concepto=NominaConcepto.Movimiento
NominaConcepto.Movimiento=(Fin)
