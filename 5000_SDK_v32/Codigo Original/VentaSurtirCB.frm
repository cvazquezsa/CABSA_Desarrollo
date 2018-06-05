[Forma]
Clave=VentaSurtirCB
Nombre=Surtir Pedidos
Icono=49
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=312
PosicionInicialArriba=110
PosicionInicialAltura=540
PosicionInicialAncho=400
Totalizadores=S
PosicionSeccion1=8
PosicionSeccion2=93
EsMovimiento=S
TituloAuto=S
MovModulo=VTAS
MovEspecificos=Todos
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.Mov, <T>Pedido<T>)<BR>Asigna(Info.MovID, Nulo)<BR>EjecutarSQL(<T>spListaStBorrar :nEstacion<T>, EstacionTrabajo)
PosicionInicialAlturaCliente=513

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ListaSt
Fuente={Fixedsys, 9, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ListaSt.Clave
CarpetaVisible=S
ConFuenteEspecial=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroGeneral=ListaSt.Estacion={EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General

[Lista.ListaSt.Clave]
Carpeta=Lista
Clave=ListaSt.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Clave=361

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
Totalizadores1=Conteo
Totalizadores2=Conteo(ListaSt:ListaSt.Clave)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Conteo
CarpetaVisible=S
FichaAlineacionDerecha=S

[(Carpeta Totalizadores).Conteo]
Carpeta=(Carpeta Totalizadores)
Clave=Conteo
Editar=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[(Variables).Info.MovID]
Carpeta=(Variables)
Clave=Info.MovID
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Editar=S
Pegado=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=7
NombreDesplegar=&Continuar
Multiple=S
EnBarraHerramientas=S
Activo=S
Visible=S
NombreEnBoton=S
ListaAccionesMultiples=Variables Asignar<BR>Generar<BR>Conciliar<BR>Cerrar
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ListaSt:ListaSt.Clave)))<BR>ConDatos(ListaSt:ListaSt.Clave) y Vacio(Temp.Texto)
EjecucionMensaje=Si(ConDatos(Temp.Texto), Comillas(Temp.Texto)+<T> Duplicado<T>, <T>Falta Indicar los Códigos<T>)

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
NombreDesplegar=<T>Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Info.ID)

[Acciones.Borrar]
Nombre=Borrar
Boton=5
NombreDesplegar=&Borrar Lista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S
NombreEnBoton=S
Multiple=S
ListaAccionesMultiples=Cancelar Cambios<BR>Registro Ultimo

[Acciones.Aceptar.Conciliar]
Nombre=Conciliar
Boton=0
TipoAccion=Formas
ClaveAccion=VentaConciliar
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=ConDatos(Info.ID)
EjecucionMensaje=<T>El Pedido No Existe o Ya Esta Concluido<T>

[Acciones.Aceptar.Generar]
Nombre=Generar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa = :tEmpresa AND Mov =:tMov AND MovID = :tMovID AND Estatus = :tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>Si(ConDatos(Info.ID),Asigna(Afectar.ID, SQL(<T>spProcesarCBGenerarRemision :nEstacion, :tEmpresa, :tUsuario, :tMov, :tMovID<T>, EstacionTrabajo, Empresa, Usuario, Info.Mov, Info.MovID)))

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Ver Pedido
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
ListaAccionesMultiples=Variables Asignar<BR>Rep
Activo=S
Visible=S

[Acciones.Preliminar.Rep]
Nombre=Rep
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.ID, SQL(<T>SELECT ID FROM Venta WHERE Empresa = :tEmpresa AND Mov =:tMov AND MovID = :tMovID AND Estatus = :tEstatus<T>, Empresa, Info.Mov, Info.MovID, EstatusPendiente))<BR>Si(ConDatos(Info.ID), ReportePantalla(ReporteMovPantalla(<T>VTAS<T>, Info.Mov, EstatusPendiente), Info.ID))

[Acciones.Borrar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Borrar.Registro Ultimo]
Nombre=Registro Ultimo
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Ultimo
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=(Variables)
(Variables)=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Borrar
Borrar=Preliminar
Preliminar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Mov
Info.Mov=Info.MovID
Info.MovID=(Fin)
