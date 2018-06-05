
[Forma]
Clave=PrevencionLD
Icono=0
Modulos=PREV
MovModulo=PREV
Nombre=Prevención de Lavado de Dinero

ListaCarpetas=(Lista)
CarpetaPrincipal=Principal
PosicionInicialIzquierda=276
PosicionInicialArriba=71
PosicionInicialAlturaCliente=503
PosicionInicialAncho=780
Menus=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionSec1=212
ListaAcciones=(Lista)
EsMovimiento=S
MovEspecificos=Todos
TituloAuto=S
AutoGuardarEncabezado=S
DialogoAbrir=S
BarraAyuda=S
BarraAyudaBold=S
MenuPrincipal=(Lista)
[Principal]
Estilo=Ficha
Clave=Principal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PrevencionLD
Fuente={Tahoma, 8, Negro, []}
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

[Principal.PrevencionLD.Mov]
Carpeta=Principal
Clave=PrevencionLD.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Blanco

[Principal.PrevencionLD.MovID]
Carpeta=Principal
Clave=PrevencionLD.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=8
ColorFondo=Blanco

Pegado=S
IgnoraFlujo=S
[Principal.PrevencionLD.FechaEmision]
Carpeta=Principal
Clave=PrevencionLD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


Tamano=20
[Principal.PrevencionLD.Concepto]
Carpeta=Principal
Clave=PrevencionLD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=28
ColorFondo=Blanco

[Principal.PrevencionLD.Proyecto]
Carpeta=Principal
Clave=PrevencionLD.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

Pegado=S
[Principal.PrevencionLD.UEN]
Carpeta=Principal
Clave=PrevencionLD.UEN
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=5
Pegado=S
[Principal.PrevencionLD.Moneda]
Carpeta=Principal
Clave=PrevencionLD.Moneda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Blanco

[Principal.PrevencionLD.TipoCambio]
Carpeta=Principal
Clave=PrevencionLD.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=6
Pegado=S
[Principal.PrevencionLD.Referencia]
Carpeta=Principal
Clave=PrevencionLD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Principal.PrevencionLD.Observaciones]
Carpeta=Principal
Clave=PrevencionLD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50X2
ColorFondo=Blanco

[Principal.PrevencionLD.ActEconomica]
Carpeta=Principal
Clave=PrevencionLD.ActEconomica
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco








[Principal.PrevencionLD.Importe]
Carpeta=Principal
Clave=PrevencionLD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Tamano=25





[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=PrevencionLDD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=PrevencionLD
LlaveLocal=PrevencionLDD.ID
LlaveMaestra=PrevencionLD.ID
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

ControlRenglon=S
CampoRenglon=PrevencionLDD.Renglon
[Detalle.PrevencionLDD.Aplica]
Carpeta=Detalle
Clave=PrevencionLDD.Aplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PrevencionLDD.AplicaId]
Carpeta=Detalle
Clave=PrevencionLDD.AplicaId
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PrevencionLDD.Importe]
Carpeta=Detalle
Clave=PrevencionLDD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.PrevencionLDD.ContactoTipo]
Carpeta=Detalle
Clave=PrevencionLDD.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.PrevencionLDD.Contacto]
Carpeta=Detalle
Clave=PrevencionLDD.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[Detalle.Columnas]
Aplica=72
AplicaId=84
Importe=125
ActEconimica=304
ContactoTipo=124
Contacto=64



[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=Nuevo
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Nuevo
Activo=S
Visible=S


























Menu=&Archivo
EnMenu=S
EsDefault=S
[Acciones.Abrir]
Nombre=Abrir
Boton=2
NombreDesplegar=Abrir
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Documento Abrir
Activo=S
Visible=S





Menu=&Archivo
EsDefault=S
EnMenu=S
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=Guardar
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S





Menu=&Archivo
















EsDefault=S






































[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=PrevencionLDA
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(Situación)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Mov<T>
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S







IconosNombreNumerico=S
ListaEnCaptura=(Lista)
BusquedaRapidaControles=S
IconosSeleccionPorLlave=S
FiltroEstatus=S
FiltroUsuarios=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroMonedas=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroUsuarioDefault=(Usuario)
FiltroFechasNormal=S
FiltroMonedasCampo=PrevencionLD.Moneda
FiltroFechasCancelacion=PrevencionLD.FechaCancelacion
FiltroFechasNombre=&Fecha
FiltroFechas=S
FiltroFechasCampo=PrevencionLD.FechaEmision
FiltroFechasDefault=(Todo)
FiltroModificarEstatus=S
FiltroSucursalesSinTodas=S
IconosConPaginas=S
IconosNombre=PrevencionLDA:PrevencionLD.Mov&<T> <T>&PrevencionLDA:PrevencionLD.MovID
[(Carpeta Abrir).Columnas]
0=222
















1=111
2=93
3=88
4=88
5=-2

[(Carpeta Abrir).PrevencionLD.FechaEmision]
Carpeta=(Carpeta Abrir)
Clave=PrevencionLD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[(Carpeta Abrir).PrevencionLD.Concepto]
Carpeta=(Carpeta Abrir)
Clave=PrevencionLD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).PrevencionLD.Proyecto]
Carpeta=(Carpeta Abrir)
Clave=PrevencionLD.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Carpeta Abrir).PrevencionLD.Moneda]
Carpeta=(Carpeta Abrir)
Clave=PrevencionLD.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[(Carpeta Abrir).PrevencionLD.TipoCambio]
Carpeta=(Carpeta Abrir)
Clave=PrevencionLD.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



























[Detalle.ListaEnCaptura]
(Inicio)=PrevencionLDD.Aplica
PrevencionLDD.Aplica=PrevencionLDD.AplicaId
PrevencionLDD.AplicaId=PrevencionLDD.Importe
PrevencionLDD.Importe=PrevencionLDD.ContactoTipo
PrevencionLDD.ContactoTipo=PrevencionLDD.Contacto
PrevencionLDD.Contacto=(Fin)




















[Lista.Columnas]
0=135
1=192










UEN=44
Nombre=269






[Principal.ListaEnCaptura]
(Inicio)=PrevencionLD.Mov
PrevencionLD.Mov=PrevencionLD.MovID
PrevencionLD.MovID=PrevencionLD.Proyecto
PrevencionLD.Proyecto=PrevencionLD.UEN
PrevencionLD.UEN=PrevencionLD.Moneda
PrevencionLD.Moneda=PrevencionLD.TipoCambio
PrevencionLD.TipoCambio=PrevencionLD.FechaEmision
PrevencionLD.FechaEmision=PrevencionLD.Importe
PrevencionLD.Importe=PrevencionLD.ActEconomica
PrevencionLD.ActEconomica=PrevencionLD.Concepto
PrevencionLD.Concepto=PrevencionLD.Referencia
PrevencionLD.Referencia=PrevencionLD.Observaciones
PrevencionLD.Observaciones=(Fin)









[Acciones.Verificar]
Nombre=Verificar
Boton=41
Menu=&Archivo
NombreDesplegar=Verificar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Verificar(<T>PREV<T>, PrevencionLD:PrevencionLD.ID,PrevencionLD:PrevencionLD.Mov,PrevencionLD:PrevencionLD.MovID)
Activo=S
Visible=S













[Acciones.Situaciones]
Nombre=Situaciones
Boton=71
Menu=&Archivo
NombreDesplegar=Situaciones
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=Si  fnMovSituacionTipoFlujo(Empresa, <T>PREV<T>, PrevencionLD:PrevencionLD.Mov, PrevencionLD:PrevencionLD.Estatus) = <T>Condicional<T><BR>Entonces<BR>  Forma(<T>MovSituacionBinariaSiguiente<T>)<BR>  ActualizarVista<BR>Sino<BR>  Forma.Accion(<T>WizardSituaciones<T>)<BR>Fin
ActivoCondicion=(ConfigModulo(<T>PREV<T>,<T>Situaciones<T>)=<T>Si<T>) y Usuario.ModificarSituacion y<BR>fnPuedeAvanzarSituacion(Empresa, <T>PREV<T>, PrevencionLD:PrevencionLD.Mov, PrevencionLD:PrevencionLD.Estatus, FormaSituacion, Usuario)
Antes=S
AntesExpresiones=Si(Vacio(PrevencionLD:PrevencionLD.ID),GuardarCambios)<BR><BR>Asigna(Info.Modulo, <T>PREV<T>)<BR>Asigna(Info.ID, PrevencionLD:PrevencionLD.ID)<BR>Asigna(Info.Mov, PrevencionLD:PrevencionLD.Mov)<BR>Asigna(Info.Estatus, PrevencionLD:PrevencionLD.Estatus)<BR>Asigna(Info.Situacion, PrevencionLD:PrevencionLD.Situacion)
Visible=S































[Acciones.WizardSituaciones]
Nombre=WizardSituaciones
Boton=22
NombreDesplegar=Wizard Situaciones
TipoAccion=Controles Captura
ClaveAccion=Cambiar Situacion
Activo=S
Visible=S




























[Acciones.Afectar]
Nombre=Afectar
Boton=7
Menu=&Archivo
NombreDesplegar=Afectar
EnBarraHerramientas=S
EnMenu=S
EspacioPrevio=S
TipoAccion=Expresion
ConCondicion=S
Antes=S
Visible=S

















































GuardarAntes=S



























Expresion=Asigna(Afectar.Id, PrevencionLD:PrevencionLD.ID)<BR>Asigna(Afectar.Mov, PrevencionLD:PrevencionLD.Mov)<BR>Asigna(Afectar.MovID, PrevencionLD:PrevencionLD.MovID)<BR>Asigna(Afectar.Fecha,PrevencionLD:PrevencionLD.FechaEmision)<BR>Afectar(<T>PREV<T>, Afectar.ID,Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, <T>PrevencionLD<T>)<BR>Forma.ActualizarForma( <T>PrevencionLD<T>)
ActivoCondicion=PuedeAfectar(Usuario.Afectar, Usuario.AfectarOtrosMovs, PrevencionLD:PrevencionLD.Usuario) y<BR>(PrevencionLD:PrevencionLD.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y<BR>fnPuedeAvanzarEstatus(Empresa, <T>PREV<T>, PrevencionLD:PrevencionLD.Mov, PrevencionLD:PrevencionLD.Estatus, FormaSituacion, Usuario)
EjecucionCondicion=ConDatos(PrevencionLD:PrevencionLD.Mov)
AntesExpresiones=Si<BR>  General.CamposExtras=<T>Campos Extras<T> y (PrevencionLD:PrevencionLD.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)) y SQL(<T>SELECT CEAntesAfectar FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov AND CE=1<T>, <T>PREV<T>, PrevencionLD:PrevencionLD.Mov)<BR>Entonces<BR>  Si(no CamposExtrasMovimiento(<T>PREV<T>, PrevencionLD:PrevencionLD.Mov, PrevencionLD:PrevencionLD.ID, Verdadero, PrevencionLD:PrevencionLD.Estatus noen (EstatusSinAfectar, EstatusPorConfirmar, EstatusBorrador)), AbortarOperacion)<BR>FIn





























































[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=PrevencionLD.FechaEmision
PrevencionLD.FechaEmision=PrevencionLD.Concepto
PrevencionLD.Concepto=PrevencionLD.Proyecto
PrevencionLD.Proyecto=PrevencionLD.Moneda
PrevencionLD.Moneda=PrevencionLD.TipoCambio
PrevencionLD.TipoCambio=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=SINAFECTAR
SINAFECTAR=CONFIRMAR
CONFIRMAR=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)




[Forma.ListaCarpetas]
(Inicio)=Principal
Principal=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=Guardar
Guardar=Verificar
Verificar=Situaciones
Situaciones=WizardSituaciones
WizardSituaciones=Afectar
Afectar=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Archivo
&Archivo=&Edicion
&Edicion=(Fin)
