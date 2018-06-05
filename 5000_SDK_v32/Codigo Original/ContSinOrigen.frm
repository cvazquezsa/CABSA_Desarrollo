[Forma]
Clave=ContSinOrigen
Nombre=Pólizas sin Origen
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=502
PosicionInicialArriba=317
PosicionInicialAlturaCliente=531
PosicionInicialAncho=915
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Cuenta, Info.Descripcion)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Cont
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroProyectos=S
FiltroListaEstatus=CONCLUIDO
FiltroEstatusDefault=CONCLUIDO
FiltroFechasCampo=Cont.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasCancelacion=Cont.FechaCancelacion
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
FiltroPredefinido1=por Importe<BR>por Fecha
FiltroPredefinido2=1=1<BR>1=1
FiltroPredefinido3=Importe DESC<BR>FechaEmision
FiltroEstilo=Directorio
FiltroGeneral=Cont.ID IN (SELECT ID FROM dbo.fnPolizasSinOrigen(<T>{Empresa}<T>, <T>{Info.Cuenta}<T>))

[Lista.Cont.Mov]
Carpeta=Lista
Clave=Cont.Mov
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.Cont.MovID]
Carpeta=Lista
Clave=Cont.MovID
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.Cont.FechaEmision]
Carpeta=Lista
Clave=Cont.FechaEmision
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Cont.Concepto]
Carpeta=Lista
Clave=Cont.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.Cont.Referencia]
Carpeta=Lista
Clave=Cont.Referencia
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.Cont.ContactoTipo]
Carpeta=Lista
Clave=Cont.ContactoTipo
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cont.Contacto]
Carpeta=Lista
Clave=Cont.Contacto
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=107
MovID=64
FechaEmision=74
Concepto=111
Referencia=99
ContactoTipo=90
Contacto=104
Proyecto=105
UEN=28
Importe=95

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

[Lista.Cont.Proyecto]
Carpeta=Lista
Clave=Cont.Proyecto
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cont.UEN]
Carpeta=Lista
Clave=Cont.UEN
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Lista.Cont.Importe]
Carpeta=Lista
Clave=Cont.Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Ver]
Nombre=Ver
Boton=57
NombreEnBoton=S
NombreDesplegar=&Ver Póliza
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=ReportePantalla(<T>CONT<T>, Cont:Cont.ID)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Cont:Cont.ID)
Visible=S

[Acciones.ContDSinOrigen]
Nombre=ContDSinOrigen
Boton=47
NombreEnBoton=S
NombreDesplegar=Contacto a Nivel &Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ContDSinOrigen
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(Cont:Cont.ContactoTipo)
EjecucionMensaje=<T>Es Necesario Especificar el Tipo de Contacto<T>
EjecucionConError=S
Antes=S
AntesExpresiones=Asigna(Info.ID, Cont:Cont.ID)<BR>Asigna(Info.Mov, Cont:Cont.Mov)<BR>Asigna(Info.MovID, Cont:Cont.MovID)<BR>Asigna(Info.ContactoTipo, Cont:Cont.ContactoTipo)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Ver
Ver=ContDSinOrigen
ContDSinOrigen=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cont.Mov
Cont.Mov=Cont.MovID
Cont.MovID=Cont.FechaEmision
Cont.FechaEmision=Cont.Concepto
Cont.Concepto=Cont.Referencia
Cont.Referencia=Cont.Importe
Cont.Importe=Cont.Proyecto
Cont.Proyecto=Cont.UEN
Cont.UEN=Cont.ContactoTipo
Cont.ContactoTipo=Cont.Contacto
Cont.Contacto=(Fin)
