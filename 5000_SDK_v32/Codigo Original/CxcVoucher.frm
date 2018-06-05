[Forma]
Clave=CxcVoucher
Nombre=Voucher
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=286
PosicionInicialArriba=249
PosicionInicialAlturaCliente=492
PosicionInicialAncho=708
Totalizadores=S
PosicionSeccion1=92
Comentarios=Lista(Info.Cliente, Info.Moneda)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
ExpresionesAlMostrar=Asigna(Info.Mov, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CxcVoucher
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
ValidarCampos=S
ListaCamposAValidar=(Lista)
FiltroGeneral=CxcVoucher.ID={Info.ID}

[Lista.CxcVoucher.Mov]
Carpeta=Lista
Clave=CxcVoucher.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcVoucher.Referencia]
Carpeta=Lista
Clave=CxcVoucher.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcVoucher.Concepto]
Carpeta=Lista
Clave=CxcVoucher.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcVoucher.EnviarA]
Carpeta=Lista
Clave=CxcVoucher.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcVoucher.Nuevo]
Carpeta=Lista
Clave=CxcVoucher.Nuevo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Mov=125
Referencia=111
Concepto=110
ImporteTotal=90
Impuestos=88
EnviarA=46
Nuevo=36
Aplicar=36
GenerarMov=101
GenerarConcepto=106
Cargo=99
Abono=93
Aceptar=42

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
GuardarAntes=S
EspacioPrevio=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[Lista.CxcVoucher.Cargo]
Carpeta=Lista
Clave=CxcVoucher.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CxcVoucher.Abono]
Carpeta=Lista
Clave=CxcVoucher.Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Totalizadores1=Cargos<BR>Abonos<BR>Neto<BR>Diferencia
Totalizadores2=Suma(CxcVoucher:CxcVoucher.Cargo)<BR>Suma(CxcVoucher:CxcVoucher.Abono)<BR>Suma(CxcVoucher:CxcVoucher.Cargo)-Suma(CxcVoucher:CxcVoucher.Abono)<BR>Info.Importe-(Suma(CxcVoucher:CxcVoucher.Cargo)-Suma(CxcVoucher:CxcVoucher.Abono))
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Cargos]
Carpeta=(Carpeta Totalizadores)
Clave=Cargos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Abonos]
Carpeta=(Carpeta Totalizadores)
Clave=Abonos
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Neto]
Carpeta=(Carpeta Totalizadores)
Clave=Neto
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.CxcVoucher.Aceptar]
Carpeta=Lista
Clave=CxcVoucher.Aceptar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)

[(Carpeta Totalizadores).Diferencia]
Carpeta=(Carpeta Totalizadores)
Clave=Diferencia
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]

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

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Afectar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar)
AntesExpresiones=ProcesarSQL(<T>spCxcVoucherAfectar :nID<T>, Info.ID)

[Forma.ListaAcciones]
(Inicio)=Afectar
Afectar=Cancelar
Cancelar=Guardar
Guardar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CxcVoucher.Mov
CxcVoucher.Mov=CxcVoucher.Referencia
CxcVoucher.Referencia=CxcVoucher.Cargo
CxcVoucher.Cargo=CxcVoucher.Abono
CxcVoucher.Abono=CxcVoucher.Nuevo
CxcVoucher.Nuevo=CxcVoucher.EnviarA
CxcVoucher.EnviarA=CxcVoucher.Aceptar
CxcVoucher.Aceptar=CxcVoucher.Concepto
CxcVoucher.Concepto=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Clave
CteEnviarA.Clave=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Cargos
Cargos=Abonos
Abonos=Neto
Neto=Diferencia
Diferencia=(Fin)
