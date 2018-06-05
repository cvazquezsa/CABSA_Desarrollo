[Forma]
Clave=Conciliar
Nombre=<T>Conciliar - <T>+Info.Descripcion
Icono=48
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=513
PosicionInicialArriba=371
PosicionInicialAltura=449
PosicionInicialAncho=894
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Si(no Info.VerPendientes, FechaEnTexto(Info.FechaD,<T>dd/mmm/aaaa<T>)+<T> - <T>+FechaEnTexto(Info.FechaA,<T>dd/mmm/aaaa<T>),<T><T>),Info.Cuenta)
Totalizadores=S
PosicionSeccion1=90
PosicionInicialAlturaCliente=422
ExpresionesAlMostrar=Asigna(Info.VerPendientes, Verdadero)<BR>Asigna(Info.FechaD, FechaDel(Hoy, 30))<BR>Asigna(Info.FechaA, Hoy)<BR>Asigna(Temp.Reg, SQL(<T>SELECT SUM(Saldo), SUM(PorConciliar) FROM Saldo WHERE Empresa=:tEmpresa AND Rama=:tRama AND Cuenta=:tCuenta<T>, Empresa, Info.Rama, Info.Cuenta))<BR>Asigna(Info.SaldoFinal, Temp.Reg[1])<BR>Asigna(Info.Saldo, Temp.Reg[1])<BR>Asigna(Info.SaldoInicial, Temp.Reg[1]-Temp.Reg[2])
PosicionSec1=348

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AuxiliarMov
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
FiltroPredefinido=S
OtroOrden=S
ListaOrden=(Lista)
PermiteLocalizar=S
MenuLocal=S
ListaAcciones=(Lista)
HojaIndicador=S
BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=Auxiliar.Fecha
FiltroFechasDefault=(Todo)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
FiltroSucursales=S
HojaAjustarColumnas=S
FiltroGeneral=Auxiliar.Empresa = <T>{Empresa}<T> AND<BR>Auxiliar.Rama = <T>{Info.Rama}<T> AND<BR>Auxiliar.Cuenta = <T>{Info.Cuenta}<T> AND<BR>Auxiliar.Conciliado <BR>{Si(Info.VerPendientes,<T>= 0<T>,<T> IN (0,1) AND Auxiliar.Fecha >= <T>+Comillas(FechaFormatoServidor(Info.FechaD))+<T> AND Auxiliar.Fecha < <T>+Comillas(FechaFormatoServidor(Info.FechaA+1)))}

[Lista.Auxiliar.Cargo]
Carpeta=Lista
Clave=Auxiliar.Cargo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Auxiliar.Abono]
Carpeta=Lista
Clave=Auxiliar.Abono
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Auxiliar.EsCancelacion]
Carpeta=Lista
Clave=Auxiliar.EsCancelacion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Auxiliar.Conciliado]
Carpeta=Lista
Clave=Auxiliar.Conciliado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Columnas]
Modulo=49
Mov=105
MovID=67
Cargo=111
Abono=108
EsCancelacion=74
Conciliado=52
Fecha=67
Referencia=105
Movimiento=114
Concepto=103
FechaConciliacion=92

[Lista.Auxiliar.Fecha]
Carpeta=Lista
Clave=Auxiliar.Fecha
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
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

[Acciones.Conciliar]
Nombre=Conciliar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Si
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Asigna(AuxiliarMov:Auxiliar.Conciliado, Verdadero)
ConCondicion=S
EjecucionCondicion=ConDatos(AuxiliarMov:Auxiliar.Cuenta)

[Acciones.Desconciliar]
Nombre=Desconciliar
Boton=21
NombreEnBoton=S
NombreDesplegar=<T>&No<T>
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(AuxiliarMov:Auxiliar.Conciliado, Falso)
ConCondicion=S
EjecucionCondicion=ConDatos(AuxiliarMov:Auxiliar.Cuenta)

[Acciones.Pendientes]
Nombre=Pendientes
Boton=59
NombreEnBoton=S
NombreDesplegar=&Pendientes
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Antes=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
ActivoCondicion=no Info.VerPendientes
AntesExpresiones=Asigna(Info.VerPendientes, Verdadero)

[Acciones.Fecha]
Nombre=Fecha
Boton=53
NombreEnBoton=S
NombreDesplegar=por &Fechas
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
Antes=S
AntesExpresiones=Forma(<T>EspecificarFechas<T>)

[Acciones.LocalizarLocal]
Nombre=LocalizarLocal
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.SiguienteLocal]
Nombre=SiguienteLocal
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[Acciones.ExaminarLocal]
Nombre=ExaminarLocal
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=F11
ClaveAccion=MovPropiedades
Antes=S
EjecucionCondicion=ConDatos(AuxiliarMov:Auxiliar.ModuloID)
AntesExpresiones=Asigna(Info.Modulo, AuxiliarMov:Auxiliar.Modulo)<BR>Asigna(Info.ID, AuxiliarMov:Auxiliar.ModuloID)

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreEnBoton=S
NombreDesplegar=<T>&Movimiento<T>
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(AuxiliarMov:Auxiliar.ModuloID)
AntesExpresiones=Asigna(Info.Modulo, AuxiliarMov:Auxiliar.Modulo)<BR>Asigna(Info.ID, AuxiliarMov:Auxiliar.ModuloID)

[Lista.Mov.Referencia]
Carpeta=Lista
Clave=Mov.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Localizar]
Nombre=Localizar
Boton=73
NombreDesplegar=&Localizar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
EspacioPrevio=S

[Lista.Movimiento]
Carpeta=Lista
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mov.Concepto]
Carpeta=Lista
Clave=Mov.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Saldo Inicial<BR>Pendiente<BR>Diferencia<BR>Saldo Final
Totalizadores2=Info.SaldoInicial<BR>Suma(Si(no AuxiliarMov:Auxiliar.Conciliado, AuxiliarMov:Auxiliar.Cargo-AuxiliarMov:Auxiliar.Abono))<BR>Info.Saldo-Info.SaldoFinal-Suma(Si(no AuxiliarMov:Auxiliar.Conciliado, AuxiliarMov:Auxiliar.Cargo-AuxiliarMov:Auxiliar.Abono))<BR>Info.SaldoFinal
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
TotCarpetaRenglones=Lista
TotExpresionesEnSumas=S

[(Carpeta Totalizadores).Pendiente]
Carpeta=(Carpeta Totalizadores)
Clave=Pendiente
Editar=S
LineaNueva=N
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S
Pegado=S

[(Carpeta Totalizadores).Diferencia]
Carpeta=(Carpeta Totalizadores)
Clave=Diferencia
Editar=S
LineaNueva=N
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S
Pegado=S

[Acciones.Saldo]
Nombre=Saldo
Boton=64
NombreDesplegar=S&aldo Final
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Visible=S
NombreEnBoton=S
GuardarAntes=S
EjecucionCondicion=Forma(<T>EspecificarSaldoFinal<T>)

[(Carpeta Totalizadores).Saldo Inicial]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Inicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Saldo Final]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Final
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Lista.Auxiliar.FechaConciliacion]
Carpeta=Lista
Clave=Auxiliar.FechaConciliacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Conciliar
Conciliar=Desconciliar
Desconciliar=MovPropiedades
MovPropiedades=Localizar
Localizar=Excel
Excel=Pendientes
Pendientes=Fecha
Fecha=Saldo
Saldo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Auxiliar.Conciliado
Auxiliar.Conciliado=Auxiliar.FechaConciliacion
Auxiliar.FechaConciliacion=Auxiliar.Fecha
Auxiliar.Fecha=Movimiento
Movimiento=Mov.Referencia
Mov.Referencia=Mov.Concepto
Mov.Concepto=Auxiliar.Cargo
Auxiliar.Cargo=Auxiliar.Abono
Auxiliar.Abono=Auxiliar.EsCancelacion
Auxiliar.EsCancelacion=(Fin)

[Lista.ListaOrden]
(Inicio)=Auxiliar.Fecha<TAB>(Acendente)
Auxiliar.Fecha<TAB>(Acendente)=Auxiliar.ModuloID<TAB>(Acendente)
Auxiliar.ModuloID<TAB>(Acendente)=(Fin)

[Lista.ListaAcciones]
(Inicio)=ExaminarLocal
ExaminarLocal=LocalizarLocal
LocalizarLocal=SiguienteLocal
SiguienteLocal=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Saldo Inicial
Saldo Inicial=Pendiente
Pendiente=Diferencia
Diferencia=Saldo Final
Saldo Final=(Fin)
