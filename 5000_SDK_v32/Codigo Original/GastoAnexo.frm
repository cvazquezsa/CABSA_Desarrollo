[Forma]
Clave=GastoAnexo
Nombre=Gastos
Icono=0
Modulos=GAS
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=263
PosicionInicialArriba=267
PosicionInicialAltura=483
PosicionInicialAncho=753
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Menus=S
BarraHerramientas=S
EsMovimiento=S
TituloAuto=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
DialogoAbrir=S
ListaAcciones=(Lista)
PosicionSeccion1=54
Totalizadores=S
PosicionSeccion2=91
BarraAyuda=S
MovModulo=GAS
PosicionColumna3=50
BarraAyudaBold=S
MovEspecificos=Todos
VentanaBloquearAjuste=N
PosicionColumna2=58
Comentarios=Anexo.Mov+<T> <T>+Anexo.MovID
MovimientosValidos=Gasto<BR>Gasto Prorrateado
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Fecha, Hoy)<BR>Asigna(Info.Concepto, Nulo)
PosicionInicialAlturaCliente=456
MenuPrincipal=(Lista)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Gasto
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=5
FichaEspacioNombres=123
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S
PestanaNombre=Datos Generales
Pestana=S
PestanaOtroNombre=S

[Ficha.Gasto.Mov]
Carpeta=Ficha
Clave=Gasto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.MovID]
Carpeta=Ficha
Clave=Gasto.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Plata
Pegado=S
IgnoraFlujo=S
ColorFuente=Negro

[Ficha.Gasto.FechaEmision]
Carpeta=Ficha
Clave=Gasto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=N
IgnoraFlujo=N
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.Proyecto]
Carpeta=Ficha
Clave=Gasto.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.Moneda]
Carpeta=Ficha
Clave=Gasto.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
IgnoraFlujo=N
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.Observaciones]
Carpeta=Ficha
Clave=Gasto.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.Acreedor]
Carpeta=Ficha
Clave=Gasto.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.Condicion]
Carpeta=Ficha
Clave=Gasto.Condicion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro
Pegado=N

[Ficha.Gasto.Vencimiento]
Carpeta=Ficha
Clave=Gasto.Vencimiento
Editar=S
3D=S
Tamano=15
EditarConBloqueo=N
LineaNueva=N
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=GastoA
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
IconosConPaginas=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Gasto.ID<TAB>(Decendente)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=movimientos
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroAutoCampo=(Validaciones Memoria)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroAutoValidar=Mon
FiltroAplicaEn=Gasto.Moneda
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=GastoA:Gasto.Mov+<T> <T>+GastoA:Gasto.MovID
FiltroGeneral=Gasto.AnexoModulo=<T>{Anexo.Modulo}<T> AND Gasto.AnexoID={Anexo.ID}

[(Carpeta Abrir).Columnas]
0=149
1=95

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Visible=S
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+N
Activo=S

[Acciones.Abrir]
Nombre=Abrir
Boton=2
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
NombreDesplegar=&Abrir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Visible=S
Activo=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+G
NombreDesplegar=&Guardar cambios
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Visible=S
Antes=S
ConCondicion=S
EjecucionConError=S
Activo=S
EjecucionCondicion=ConDatos(Gasto:Gasto.Acreedor)
EjecucionMensaje=<T>Falta Indicar el Acreedor/Responsable<T>
AntesExpresiones=Asigna(Gasto:Gasto.AnexoModulo, Anexo.Modulo)<BR>Asigna(Gasto:Gasto.AnexoID, Anexo.ID)<BR>Si <BR>  MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC)<BR>Entonces<BR>  Asigna(Gasto:Gasto.Importe,   Suma(Redondea(GastoD:GastoD.Importe, 4)))<BR>  Asigna(Gasto:Gasto.Retencion, Suma(Redondea(GastoD:GastoD.Retencion+GastoD:GastoD.Retencion2, 4)))<BR>  Asigna(Gasto:Gasto.Impuestos, Suma(Redondea(GastoD:GastoD.Impuestos, 4)))<BR>Fin

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Visible=S
Activo=S

[Ficha.Gasto.FormaPago]
Carpeta=Ficha
Clave=Gasto.FormaPago
Editar=S
ValidaNombre=N
3D=S
Tamano=15
LineaNueva=N
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=Si
TipoAccion=Herramientas Captura
ClaveAccion=Navegador (Documentos)
Visible=Si
Activo=Si
EspacioPrevio=Si

[Detalle.GastoD.Importe]
Carpeta=Detalle
Clave=GastoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
EditarConBloqueo=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GastoD.Aplica]
Carpeta=Detalle
Clave=GastoD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=N

[Detalle.GastoD.AplicaID]
Carpeta=Detalle
Clave=GastoD.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
EditarConBloqueo=N

[Detalle.Columnas]
Importe=85
Aplica=96
AplicaID=69
Saldo=89
Vencimiento=102
Concepto=134
Referencia=83
Impuestos=69
Total=77
Fecha=72
Retencion=74
CentroCostos=102
ContUso=75
Retencion2=73
Cantidad=48
Precio=64

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=4
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Total<BR>Importe<BR>Impuestos<BR>Retencion
Totalizadores2=Suma( GastoD:Total )<BR>Suma(Redondea(GastoD:GastoD.Importe, 4))<BR>Suma(Redondea(GastoD:GastoD.Impuestos, 4))<BR>Suma(Redondea(GastoD:GastoD.Retencion+GastoD:GastoD.Retencion2, 4))
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Detalle
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CondicionVisible=MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC)

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[(Carpeta Abrir).ImporteTotal]
Carpeta=(Carpeta Abrir)
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
Totalizador=0
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Copiar]
Nombre=Copiar
Boton=0
UsaTeclaRapida=Si
TeclaRapida=F5
NombreDesplegar=Copiar
EnMenu=Si
TipoAccion=Expresion
Expresion=Asigna( GastoD:GastoD.Importe,GastoD:GastoPendiente.Saldo )
Visible=Si
ActivoCondicion=Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
Menu=&Archivo
NombreDesplegar=E&liminar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Documento Eliminar
Visible=S
ActivoCondicion=Vacio(Gasto:Gasto.MovID) y (Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)) y PuedeAfectar(Verdadero, Usuario.ModificarOtrosMovs, Gasto:Gasto.Usuario)

[Acciones.RepPantalla]
Nombre=RepPantalla
Boton=6
Menu=&Archivo
UsaTeclaRapida=S
NombreDesplegar=&Presentacion preliminar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Gasto:Gasto.ID
Visible=S
TeclaRapida=Alt+F11
Expresion=ReportePantalla(ReporteMovPantalla(<T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.Estatus), Gasto:Gasto.ID)
ActivoCondicion=Usuario.PreliminarMovs

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+P
NombreDesplegar=&Imprimir...
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
ListaParametros1=Gasto:Gasto.ID
Visible=S
Activo=
EspacioPrevio=S
GuardarAntes=S
Expresion=ReporteImpresora(ReporteMovImpresora(<T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.Estatus), Gasto:Gasto.ID)
ActivoCondicion=Usuario.ImprimirMovs

[Acciones.Totalizar]
Nombre=Totalizar
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=&Totalizar
EnMenu=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Ultimo
Visible=
Activo=
ActivoCondicion=Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
VisibleCondicion=MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=33
Menu=&Archivo
NombreDesplegar=<T>Cancela&r<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
ConfirmarAntes=S
DialogoMensaje=MovCancelar
Antes=S
RefrescarDespues=S
Expresion=Cancelar(<T>GAS<T>, Gasto:Gasto.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>GAS<T>)
ActivoCondicion=PuedeAfectar(Usuario.Cancelar, Usuario.CancelarOtrosMovs, Gasto:Gasto.Usuario) y ConDatos(Gasto:Gasto.ID) y ConDatos(Gasto:Gasto.MovID) y<BR>(Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusConcluido, EstatusPendiente, EstatusRecurrente)) 
AntesExpresiones=Asigna( Afectar.Mov, Gasto:Gasto.Mov ) <BR>Asigna( Afectar.MovID, Gasto:Gasto.MovID )

[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=<T>&Verificar<T>
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S
EspacioPrevio=S
ConCondicion=S
Expresion=Verificar(<T>GAS<T>, Gasto:Gasto.ID,Gasto:Gasto.Mov,Gasto:Gasto.MovID)
ActivoCondicion=Gasto:Gasto.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
EjecucionCondicion=ConDatos(Gasto:Gasto.Mov)

[Ficha.Prov.Nombre]
Carpeta=Ficha
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=33
ColorFondo=Plata
Efectos=[Negritas]
Pegado=N
ColorFuente=Negro

[Acciones.Infomacion]
Nombre=Infomacion
Boton=34
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+I
NombreDesplegar=&Información del Acreedor
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
Activo=S
ConCondicion=S
Visible=S
ClaveAccion=ProvInfo
Antes=S
EjecucionCondicion=ConDatos(Gasto:Gasto.Acreedor)
AntesExpresiones=Asigna(Info.Proveedor, Gasto:Gasto.Acreedor) <BR>Asigna(Info.Origen, <T>GAS<T>)

[Ficha.Gasto.TipoCambio]
Carpeta=Ficha
Clave=Gasto.TipoCambio
Editar=S
3D=S
Tamano=6
Pegado=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.CtaDinero]
Carpeta=Ficha
Clave=Gasto.CtaDinero
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.InfoCtaDinero]
Nombre=InfoCtaDinero
Boton=0
Menu=&Ver
NombreDesplegar=Información de la Cuenta
EnMenu=S
TipoAccion=Expresion
ConCondicion=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+I
Expresion=Asigna(Info.CtaDinero, Gasto:Gasto.CtaDinero)<BR>Forma(<T>CtaDineroInfo<T>)
ActivoCondicion=(MovTipo(<T>GAS<T>, Gasto:Gasto.Mov)<>GAS.S) y Usuario.CtaDineroInfo
EjecucionCondicion=ConDatos(Gasto:Gasto.CtaDinero)

[Aplica.Gasto.MovAplica]
Carpeta=Aplica
Clave=Gasto.MovAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Aplica.Gasto.MovAplicaID]
Carpeta=Aplica
Clave=Gasto.MovAplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17

[Acciones.Localizar]
Nombre=Localizar
Boton=0
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Mayús+F3
NombreDesplegar=L&ocalizar...
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Localizar
Activo=S
Visible=S

[Acciones.MovPos]
Nombre=MovPos
Boton=0
Menu=&Ver
NombreDesplegar=&Posición del Movimiento
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPos
Antes=S
Visible=S
ActivoCondicion=ConDatos(Gasto:Gasto.MovID)
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)

[(Carpeta Abrir).Gasto.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=Gasto.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Desglose.Columnas]
Concepto=132
Referencia=141
Importe=106
Impuestos=101
Total=111

[(Carpeta Abrir).Gasto.Vencimiento]
Carpeta=(Carpeta Abrir)
Clave=Gasto.Vencimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=10

[Detalle.GastoPendiente.Saldo]
Carpeta=Detalle
Clave=GastoPendiente.Saldo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Gris

[Detalle.GastoPendiente.Vencimiento]
Carpeta=Detalle
Clave=GastoPendiente.Vencimiento
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Gris

[Detalle]
Estilo=Hoja
PestanaNombre=Desglose
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=GastoD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Gasto
LlaveLocal=GastoD.ID
LlaveMaestra=Gasto.ID
ControlRenglon=S
CampoRenglon=GastoD.Renglon
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
PermiteEditar=S
HojaFondoGrisAuto=S
HojaAjustarColumnas=S
CondicionVisible=MovTipo(<T>GAS<T>, Gasto:Gasto.Mov) noen (GAS.DA, GAS.SR, GAS.ASC)

[Detalle.GastoD.Concepto]
Carpeta=Detalle
Clave=GastoD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Detalle.GastoD.Referencia]
Carpeta=Detalle
Clave=GastoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GastoD.Impuestos]
Carpeta=Detalle
Clave=GastoD.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Total]
Carpeta=Detalle
Clave=Total
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.Clase]
Carpeta=Ficha
Clave=Gasto.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.SubClase]
Carpeta=Ficha
Clave=Gasto.SubClase
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GastoD.Fecha]
Carpeta=Detalle
Clave=GastoD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GastoD.Retencion]
Carpeta=Detalle
Clave=GastoD.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Gasto.TieneRetencion]
Carpeta=Ficha
Clave=Gasto.TieneRetencion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=16
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Situacion]
Nombre=Situacion
Boton=71
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Ctrl+F12
NombreDesplegar=&Situación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Antes=S
Visible=S
ActivoCondicion=(ConfigModulo(<T>GAS<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>PuedeAvanzarSituacion(<T>GAS<T>, Gasto:Gasto.Mov, Gasto:Gasto.Estatus, FormaSituacion)
AntesExpresiones=Si(Vacio(Gasto:Gasto.ID),GuardarCambios)

[Acciones.Tiempo]
Nombre=Tiempo
Boton=0
Menu=&Ver
NombreDesplegar=&Tiempos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
ActivoCondicion=ConfigModulo(<T>GAS<T>,<T>Tiempos<T>)=<T>Si<T>
ConCondicion=S
EjecucionCondicion=ConDatos(Gasto:Gasto.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)
Visible=S

[(Carpeta Abrir).Gasto.Acreedor]
Carpeta=(Carpeta Abrir)
Clave=Gasto.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AbrirPropiedades]
Nombre=AbrirPropiedades
Boton=0
NombreDesplegar=P&ropiedades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Antes=S
Visible=S
ActivoCondicion=ConDatos(GastoA:Gasto.ID)
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, GastoA:Gasto.ID)

[Acciones.AbrirImprimir]
Nombre=AbrirImprimir
Boton=0
NombreDesplegar=&Imprimir
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.AbrirPreliminar]
Nombre=AbrirPreliminar
Boton=0
NombreDesplegar=&Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.AbrirExcel]
Nombre=AbrirExcel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.AbrirMostrar]
Nombre=AbrirMostrar
Boton=0
NombreDesplegar=Personalizar &Vista
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.ReasignarUsuario]
Nombre=ReasignarUsuario
Boton=0
Menu=&Archivo
NombreDesplegar=Reasignar &Usuario...
EnMenu=S
TipoAccion=Formas
ClaveAccion=ReasignarUsuario
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Usuario, Gasto:Gasto.Usuario)
VisibleCondicion=Usuario.ModificarUsuario y ConDatos(Gasto:Gasto.ID)

[Detalle.GastoD.ContUso]
Carpeta=Detalle
Clave=GastoD.ContUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Antecedentes.GastoAplica.Aplica]
Carpeta=Antecedentes
Clave=GastoAplica.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Antecedentes.GastoAplica.AplicaID]
Carpeta=Antecedentes
Clave=GastoAplica.AplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Antecedentes.GastoPendiente.Saldo]
Carpeta=Antecedentes
Clave=GastoPendiente.Saldo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Antecedentes.GastoPendiente.Vencimiento]
Carpeta=Antecedentes
Clave=GastoPendiente.Vencimiento
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Antecedentes.Columnas]
Aplica=136
AplicaID=65
Saldo=114
Vencimiento=86
Importe=118

[Antecedentes.GastoAplica.Importe]
Carpeta=Antecedentes
Clave=GastoAplica.Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
GuardarAntes=S
EnMenu=S
TipoAccion=Formas
Activo=S
Visible=S
EnBarraHerramientas=S
EspacioPrevio=S
ClaveAccion=AnexoMov
Antes=S
DespuesGuardar=S
AntesExpresiones=Asigna(Info.Rama, <T>GAS<T>)<BR>Asigna(Info.Fecha, Gasto:Gasto.FechaEmision)<BR>Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.AnexoCfg, (no FormaBloqueada) y (Usuario.ModificarAnexosMovConcluidos o (Gasto:Gasto.Estatus noen (EstatusCancelado, EstatusConcluido))))<BR>Asigna(Info.Descripcion, Gasto:Gasto.Mov+<T> <T>+Gasto:Gasto.MovID)
RefrescarDespues=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=0
Menu=&Archivo
NombreDesplegar=Propie&dades
EnMenu=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(Gasto:Gasto.ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.ID, Gasto:Gasto.ID)
Visible=S

[Acciones.Anterior]
Nombre=Anterior
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+,
NombreDesplegar=Anterior
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Anterior
Activo=S
Visible=S

[Acciones.Siguiente]
Nombre=Siguiente
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+.
NombreDesplegar=Siguiente
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Documento Siguiente
Activo=S
Visible=S

[Detalle.GastoD.Retencion2]
Carpeta=Detalle
Clave=GastoD.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.AbrirLocalizar]
Nombre=AbrirLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Acciones.AbrirLocalizarSiguiente]
Nombre=AbrirLocalizarSiguiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[Acciones.Campos]
Nombre=Campos
Boton=0
Menu=&Edición
NombreDesplegar=&Campos...
RefrescarDespues=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=GastoCampos
ActivoCondicion=no FormaBloqueada
Antes=S
AntesExpresiones=Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Mov, Gasto:Gasto.Mov)<BR>Asigna(Info.MovID, Gasto:Gasto.MovID)
VisibleCondicion=(Gasto:Gasto.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar)) y MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.A, GAS.G, GAS.GP, GAS.CP, GAS.DG, GAS.DGP, GAS.OI))

[Ficha.Gasto.FechaRequerida]
Carpeta=Ficha
Clave=Gasto.FechaRequerida
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Detalle.GastoD.Cantidad]
Carpeta=Detalle
Clave=GastoD.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.GastoD.Precio]
Carpeta=Detalle
Clave=GastoD.Precio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Prov.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Prov.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Gasto.Moneda]
Carpeta=(Carpeta Abrir)
Clave=Gasto.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Regresar]
Nombre=Regresar
Boton=40
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=F12
NombreDesplegar=&Regresar
GuardarAntes=S
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Prorrateo]
Nombre=Prorrateo
Boton=0
Menu=&Edición
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=Tabla &Prorrateo...
EnMenu=S
TipoAccion=Formas
ClaveAccion=GastoDProrrateo
ConCondicion=S
Antes=S
ActivoCondicion=MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.GP, GAS.CP, GAS.DGP))
EjecucionCondicion=ConDatos(GastoD:GastoD.Concepto) y MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.GP, GAS.CP, GAS.DGP))
AntesExpresiones=Asigna(Info.ID, Gasto:Gasto.ID)<BR>Asigna(Info.Renglon, GastoD:GastoD.Renglon)<BR>Asigna(Info.RenglonSub, GastoD:GastoD.RenglonSub)<BR>Asigna(Info.Concepto, GastoD:GastoD.Concepto)<BR>Asigna(Info.Estatus, Gasto:Gasto.Estatus)<BR>Asigna(Info.Importe, GastoD:Total)
VisibleCondicion=MovTipoEn(<T>GAS<T>, Gasto:Gasto.Mov, (GAS.GP, GAS.CP, GAS.DGP))

[Acciones.Politica]
Nombre=Politica
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+O
NombreDesplegar=&Política
EnMenu=S
TipoAccion=Formas
ClaveAccion=PoliticaInfo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Gasto:Gasto.Mov)
AntesExpresiones=Asigna(Info.Rama, <T>GAS<T>)<BR>Asigna(Info.Clave, Gasto:Gasto.Mov)

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Localizar
Localizar=Guardar
Guardar=Propiedades
Propiedades=Imprimir
Imprimir=RepPantalla
RepPantalla=Verificar
Verificar=Situacion
Situacion=Regresar
Regresar=Eliminar
Eliminar=Cancelar
Cancelar=ReasignarUsuario
ReasignarUsuario=Campos
Campos=Totalizar
Totalizar=Anexos
Anexos=Prorrateo
Prorrateo=Anterior
Anterior=Siguiente
Siguiente=Infomacion
Infomacion=InfoCtaDinero
InfoCtaDinero=Tiempo
Tiempo=Politica
Politica=MovPos
MovPos=Navegador
Navegador=Cerrar
Cerrar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edición
&Edición=&Ver
&Ver=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Gasto.Mov
Gasto.Mov=Gasto.MovID
Gasto.MovID=Gasto.Proyecto
Gasto.Proyecto=Gasto.Moneda
Gasto.Moneda=Gasto.TipoCambio
Gasto.TipoCambio=Gasto.FechaEmision
Gasto.FechaEmision=Gasto.CtaDinero
Gasto.CtaDinero=Gasto.FormaPago
Gasto.FormaPago=Gasto.Acreedor
Gasto.Acreedor=Prov.Nombre
Prov.Nombre=Gasto.Observaciones
Gasto.Observaciones=Gasto.FechaRequerida
Gasto.FechaRequerida=Gasto.Clase
Gasto.Clase=Gasto.SubClase
Gasto.SubClase=Gasto.Condicion
Gasto.Condicion=Gasto.Vencimiento
Gasto.Vencimiento=Gasto.TieneRetencion
Gasto.TieneRetencion=(Fin)

[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Gasto.Acreedor
Gasto.Acreedor=Prov.Nombre
Prov.Nombre=Gasto.FechaEmision
Gasto.FechaEmision=Gasto.Vencimiento
Gasto.Vencimiento=ImporteTotal
ImporteTotal=Gasto.Moneda
Gasto.Moneda=(Fin)

[(Carpeta Abrir).ListaAcciones]
(Inicio)=AbrirPropiedades
AbrirPropiedades=AbrirLocalizar
AbrirLocalizar=AbrirLocalizarSiguiente
AbrirLocalizarSiguiente=AbrirImprimir
AbrirImprimir=AbrirPreliminar
AbrirPreliminar=AbrirExcel
AbrirExcel=AbrirMostrar
AbrirMostrar=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=GastoD.Concepto
GastoD.Concepto=GastoD.Fecha
GastoD.Fecha=GastoD.Referencia
GastoD.Referencia=GastoD.Cantidad
GastoD.Cantidad=GastoD.Precio
GastoD.Precio=GastoD.Importe
GastoD.Importe=GastoD.Retencion
GastoD.Retencion=GastoD.Retencion2
GastoD.Retencion2=GastoD.Impuestos
GastoD.Impuestos=Total
Total=GastoD.ContUso
GastoD.ContUso=(Fin)
