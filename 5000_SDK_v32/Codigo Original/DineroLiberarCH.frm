[Forma]
Clave=DineroLiberarCH
Nombre=Liberar Solicitudes de Cheques
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=96
PosicionInicialArriba=150
PosicionInicialAlturaCliente=433
PosicionInicialAncho=831
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
MovModulo=DIN
Comentarios=Asigna(Info.SaldoInicial, SQL(<T>SELECT Saldo FROM DineroSaldo WHERE Empresa=:tEmp AND CtaDinero=:tCta<T>, Empresa, Info.CtaDinero))<BR>Info.CtaDinero
Totalizadores=S
PosicionSeccion1=91
Menus=S
ExpresionesAlMostrar=Asigna(Info.SaldoInicial, SQL(<T>SELECT Saldo FROM DineroSaldo WHERE Empresa=:tEmp AND CtaDinero=:tCta<T>, Empresa, Info.CtaDinero))
MenuPrincipal=(Lista)

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Ordenes
Clave=Lista
Filtros=S
PermiteLocalizar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DineroLiberar
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin cuenta)
FiltroTodoNombre=(Todas)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroAplicaEn=Dinero.CtaDinero
FiltroAutoCampo=(Validaciones Memoria)
FiltroAutoValidar=CtaDinero
FiltroTodo=S
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
PermiteEditar=S
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=(Lista)
HojaAjustarColumnas=S
FiltroGeneral=Dinero.Empresa=<T>{Empresa}<T> <BR>AND MovTipo.Clave = <T>DIN.SCH<T> <BR>AND Dinero.CtaDinero=<T>{Info.CtaDinero}<T><BR>AND Dinero.Estatus=<T>PENDIENTE<T><BR>AND Dinero.Liberar=0

[Lista.Columnas]
0=135
1=79
Liberar=38
CtaDinero=75
Movimiento=115
FechaEmision=75
FechaProgramada=88
Concepto=99
BeneficiarioNombre=135
Saldo=79
FormaPago=68
Referencia=88

[Acciones.Seleccionar Todo]
Nombre=Seleccionar Todo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Quitar Seleccion]
Nombre=Quitar Seleccion
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Lista.Dinero.Liberar]
Carpeta=Lista
Clave=Dinero.Liberar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Lista.Dinero.CtaDinero]
Carpeta=Lista
Clave=Dinero.CtaDinero
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=N

[Lista.Movimiento]
Carpeta=Lista
Clave=Movimiento
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFuente=Negro
ColorFondo=Blanco

[Lista.Dinero.FechaEmision]
Carpeta=Lista
Clave=Dinero.FechaEmision
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
ColorFondo=Blanco

[Lista.Dinero.FechaProgramada]
Carpeta=Lista
Clave=Dinero.FechaProgramada
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
ColorFondo=Blanco

[Lista.Dinero.Concepto]
Carpeta=Lista
Clave=Dinero.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFuente=Negro
ColorFondo=Blanco

[Lista.Dinero.BeneficiarioNombre]
Carpeta=Lista
Clave=Dinero.BeneficiarioNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFuente=Negro
ColorFondo=Blanco

[Lista.Dinero.Saldo]
Carpeta=Lista
Clave=Dinero.Saldo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
ColorFondo=Blanco

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

[Acciones.Liberar]
Nombre=Liberar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Liberar Solicitudes
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Dialogos
Activo=S
Visible=S
ClaveAccion=DineroLiberarCH
GuardarAntes=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
EnMenu=S
RefrescarDespues=S
Multiple=S
ListaAccionesMultiples=DineroLiberarCH<BR>Actualizar Titulos<BR>Aceptar<BR>Refrescar

[Acciones.CtaDinero]
Nombre=CtaDinero
Boton=61
NombreEnBoton=S
NombreDesplegar=&Especificar Cuenta
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S
ConCondicion=S
Multiple=S
ListaAccionesMultiples=Actualizar Titulos<BR>Actualizar Vista
Menu=&Archivo
EnMenu=S
EjecucionCondicion=Forma(<T>EspecificarCtaDinero<T>)

[Acciones.CtaDinero.Actualizar Titulos]
Nombre=Actualizar Titulos
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Activo=S
Visible=S

[Acciones.CtaDinero.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Saldo Actual<BR>Importe a Liberar<BR>Nuevo Saldo
Totalizadores2=Info.SaldoInicial<BR>Suma(Si(DineroLiberar:Dinero.Liberar, DineroLiberar:Dinero.Saldo))<BR>Info.SaldoInicial - Suma(Si(DineroLiberar:Dinero.Liberar, DineroLiberar:Dinero.Saldo))
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotExpresionesEnSumas=S
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
ListaEnCaptura=(Lista)
TotCarpetaRenglones=Lista

[(Carpeta Totalizadores).Saldo Actual]
Carpeta=(Carpeta Totalizadores)
Clave=Saldo Actual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Importe a Liberar]
Carpeta=(Carpeta Totalizadores)
Clave=Importe a Liberar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Pegado=S

[(Carpeta Totalizadores).Nuevo Saldo]
Carpeta=(Carpeta Totalizadores)
Clave=Nuevo Saldo
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
Menu=&Archivo
NombreDesplegar=<T>&Cerrar<T>
Multiple=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cancelar
ListaAccionesMultiples=Cancelar Cambios<BR>Cerrar
Activo=S
Visible=S

[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar

[Acciones.Cerrar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios

[Acciones.CtaDineroInfo]
Nombre=CtaDineroInfo
Boton=34
NombreDesplegar=Información Cuenta
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtaDineroInfo
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
ActivoCondicion=Usuario.CtaDineroInfo

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
Menu=&Ver
NombreDesplegar=Propiedades del Movimiento
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.ID, DineroLiberar:Dinero.ID)
Visible=S

[Acciones.Liberar.DineroLiberarCH]
Nombre=DineroLiberarCH
Boton=0
TipoAccion=Dialogos
ClaveAccion=DineroLiberarCH
Activo=S
Visible=S

[Acciones.Liberar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S

[Acciones.Liberar.Refrescar]
Nombre=Refrescar
Boton=0
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Refrescar Controles
Activo=S
Visible=S

[Acciones.Liberar.Actualizar Titulos]
Nombre=Actualizar Titulos
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Activo=S
Visible=S

[Lista.Dinero.FormaPago]
Carpeta=Lista
Clave=Dinero.FormaPago
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Liberar
Liberar=CtaDineroInfo
CtaDineroInfo=MovPropiedades
MovPropiedades=CtaDinero
CtaDinero=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Ver
&Ver=(Fin)

[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Dinero.Liberar
Dinero.Liberar=Dinero.FormaPago
Dinero.FormaPago=Dinero.CtaDinero
Dinero.CtaDinero=Dinero.Concepto
Dinero.Concepto=Dinero.BeneficiarioNombre
Dinero.BeneficiarioNombre=Movimiento
Movimiento=Dinero.FechaEmision
Dinero.FechaEmision=Dinero.FechaProgramada
Dinero.FechaProgramada=Dinero.Saldo
Dinero.Saldo=(Fin)

[Lista.ListaOrden]
(Inicio)=Dinero.FechaProgramada<TAB>(Acendente)
Dinero.FechaProgramada<TAB>(Acendente)=Dinero.FechaEmision<TAB>(Acendente)
Dinero.FechaEmision<TAB>(Acendente)=Dinero.Saldo<TAB>(Decendente)
Dinero.Saldo<TAB>(Decendente)=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Saldo Actual
Saldo Actual=Importe a Liberar
Importe a Liberar=Nuevo Saldo
Nuevo Saldo=(Fin)
