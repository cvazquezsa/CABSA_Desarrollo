[Forma]
Clave=NominaH
Nombre=Movimientos a la Nómina
Icono=0
BarraHerramientas=S
EsMovimiento=S
Modulos=NOM
TituloAuto=S
MovEspecificos=Todos
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=225
PosicionInicialArriba=291
PosicionInicialAlturaCliente=415
PosicionInicialAncho=829
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
MovModulo=NOM
ExpresionesAlMostrar=Asigna(Info.Fecha, Hoy)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.Concepto, Nulo)<BR>Asigna(Info.Referencia, Nulo)<BR>Asigna(Info.Personal, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaH
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
ListaCamposAValidar=NombreCompleto
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=NominaH.Estacion={EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General

[Lista.NominaH.Mov]
Carpeta=Lista
Clave=NominaH.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaH.Concepto]
Carpeta=Lista
Clave=NominaH.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaH.FechaEmision]
Carpeta=Lista
Clave=NominaH.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaH.Personal]
Carpeta=Lista
Clave=NominaH.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaH.Cantidad]
Carpeta=Lista
Clave=NominaH.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaH.Importe]
Carpeta=Lista
Clave=NominaH.Importe
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
Personal=78
Cantidad=48
Importe=84
NombreCompleto=145
Referencia=101
Horas=34
FechaD=69
FechaA=75

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
Expresion=ProcesarSQL(<T>spNominaH :nEstacion, :nSuc, :tEmp, :tUsr<T>, EstacionTrabajo, Sucursal, Empresa, Usuario)
Activo=S
Visible=S

[Acciones.Generar.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Lista.NominaH.Referencia]
Carpeta=Lista
Clave=NominaH.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaH.Horas]
Carpeta=Lista
Clave=NominaH.Horas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaH.FechaD]
Carpeta=Lista
Clave=NominaH.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaH.FechaA]
Carpeta=Lista
Clave=NominaH.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar Cambios
Guardar Cambios=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Generar
Generar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=NominaH.FechaEmision
NominaH.FechaEmision=NominaH.Personal
NominaH.Personal=NominaH.Mov
NominaH.Mov=NominaH.Concepto
NominaH.Concepto=NominaH.Referencia
NominaH.Referencia=NominaH.Cantidad
NominaH.Cantidad=NominaH.Importe
NominaH.Importe=NominaH.FechaD
NominaH.FechaD=NominaH.FechaA
NominaH.FechaA=NominaH.Horas
NominaH.Horas=(Fin)
