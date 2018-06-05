
[Forma]
Clave=DIOTCfg
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=DPIVA - Configuración
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=Configuracion
CarpetaPrincipal=Configuracion
PosicionInicialIzquierda=433
PosicionInicialArriba=245
PosicionInicialAlturaCliente=199
PosicionInicialAncho=500
Menus=S

MenuPrincipal=(Lista)
[Acciones.Rubros]
Nombre=Rubros
Boton=18
NombreEnBoton=S
NombreDesplegar=&Rubros
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=DIOTIVARubro
Activo=S
Visible=S



EspacioPrevio=S







[Acciones.ClavesPagos]
Nombre=ClavesPagos
Boton=30
NombreEnBoton=S
Menu=&Pagos
NombreDesplegar=&Claves de Afectación Pagos
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DIOTPagoClave
Activo=S
Visible=S














[Acciones.ExcepcionarPagos]
Nombre=ExcepcionarPagos
Boton=0
NombreDesplegar=&Excepcionar Pagos
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTPagoExcepcion
Activo=S
Visible=S





Menu=&Pagos













EspacioPrevio=S
[Acciones.AdicionarPagos]
Nombre=AdicionarPagos
Boton=0
NombreDesplegar=&Adicionar Pagos
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTPagoAdicion
Activo=S
Visible=S





Menu=&Pagos








[Acciones.DIOTArt]
Nombre=DIOTArt
Boton=0
Menu=&Conceptos
NombreDesplegar=Artículos
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTArt
Activo=S
Visible=S



[Acciones.DIOTConcepto]
Nombre=DIOTConcepto
Boton=0
Menu=&Conceptos
NombreDesplegar=&Conceptos Gastos
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTConcepto
Activo=S
Visible=S





















EspacioPrevio=S




[Acciones.DIOTConceptoImportacion]
Nombre=DIOTConceptoImportacion
Boton=0
NombreDesplegar=Conceptos de Importación
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTConceptoImportacion
Activo=S
Visible=S



Menu=&Conceptos






[Configuracion]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Variables
Clave=Configuracion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=3
FichaEspacioNombres=0
FichaColorFondo=Plata
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
FiltroGeneral=DIOTCfg.Empresa = <T>{Empresa}<T>
[Configuracion.DIOTCfg.CalcularBaseImportacion]
Carpeta=Configuracion
Clave=DIOTCfg.CalcularBaseImportacion
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=50
























[Acciones.DIOTConceptoIVAImportacion]
Nombre=DIOTConceptoIVAImportacion
Boton=0
Menu=&Conceptos
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTConceptoIVAImportacion
Activo=S
Visible=S







NombreDesplegar=Conceptos IVA de Importación










[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S





















[Acciones.DIOTProvTipoOperacion]
Nombre=DIOTProvTipoOperacion
Boton=60
NombreEnBoton=S
NombreDesplegar=Tipo de Operación
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DIOTProvTipoOperacion
Activo=S
Visible=S







Menu=&Proveedores
EnMenu=S






[Acciones.DIOTPais]
Nombre=DIOTPais
Boton=17
NombreEnBoton=S
NombreDesplegar=&País
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTPais
Activo=S
Visible=S



EspacioPrevio=S




Menu=&Maestros
































[Acciones.DIOTPagoConciliado]
Nombre=DIOTPagoConciliado
Boton=0
Menu=&Pagos
NombreDesplegar=Por Fecha de Conciliación
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DIOTPagoConciliado
Activo=S
Visible=S










[Configuracion.DIOTCfg.CxpAnticiposPagadosPeriodo]
Carpeta=Configuracion
Clave=DIOTCfg.CxpAnticiposPagadosPeriodo
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco












EspacioPrevio=S
[Configuracion.DIOTCfg.GASIncluirComprobantes]
Carpeta=Configuracion
Clave=DIOTCfg.GASIncluirComprobantes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=50






EspacioPrevio=S
[Configuracion.DIOTCfg.GASIncluirMovSinCxp]
Carpeta=Configuracion
Clave=DIOTCfg.GASIncluirMovSinCxp
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco







[Acciones.DIOTGastoAdicion]
Nombre=DIOTGastoAdicion
Boton=0
Menu=&Gastos
NombreDesplegar=Movimientos sin Cxp
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTGastoAdicion



















Visible=S




ActivoCondicion=DIOTCfg:DIOTCfg.GASIncluirMovSinCxp






















[Acciones.FiscalRegimen]
Nombre=FiscalRegimen
Boton=0
Menu=&Proveedores
NombreDesplegar=Regímenes Fiscales
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=FiscalRegimen
Activo=S
Visible=S








[Configuracion.DIOTCfg.COMSIVAImportacionAnticipado]
Carpeta=Configuracion
Clave=DIOTCfg.COMSIVAImportacionAnticipado
Editar=S
LineaNueva=S
3D=S
Tamano=50
ColorFondo=Blanco






[Configuracion.ListaEnCaptura]
(Inicio)=DIOTCfg.CalcularBaseImportacion
DIOTCfg.CalcularBaseImportacion=DIOTCfg.COMSIVAImportacionAnticipado
DIOTCfg.COMSIVAImportacionAnticipado=DIOTCfg.CxpAnticiposPagadosPeriodo
DIOTCfg.CxpAnticiposPagadosPeriodo=DIOTCfg.GASIncluirComprobantes
DIOTCfg.GASIncluirComprobantes=DIOTCfg.GASIncluirMovSinCxp
DIOTCfg.GASIncluirMovSinCxp=(Fin)





















[Acciones.Periodicidad]
Nombre=Periodicidad
Boton=0
Menu=&Maestros
NombreDesplegar=&Periodicidad
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTCatPeriodicidad
Activo=S
Visible=S





[Acciones.Periodos]
Nombre=Periodos
Boton=0
Menu=&Maestros
NombreDesplegar=Periodos
EnMenu=S
TipoAccion=Formas
ClaveAccion=DIOTCatPeriodo
Activo=S
Visible=S





































[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Rubros
Rubros=ClavesPagos
ClavesPagos=ExcepcionarPagos
ExcepcionarPagos=AdicionarPagos
AdicionarPagos=DIOTArt
DIOTArt=DIOTConcepto
DIOTConcepto=DIOTConceptoImportacion
DIOTConceptoImportacion=DIOTConceptoIVAImportacion
DIOTConceptoIVAImportacion=DIOTProvTipoOperacion
DIOTProvTipoOperacion=DIOTPais
DIOTPais=DIOTPagoConciliado
DIOTPagoConciliado=DIOTGastoAdicion
DIOTGastoAdicion=FiscalRegimen
FiscalRegimen=Periodicidad
Periodicidad=Periodos
Periodos=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Pagos
&Pagos=&Conceptos
&Conceptos=&Proveedores
&Proveedores=&Maestros
&Maestros=&Gastos
&Gastos=(Fin)
