
[Forma]
Clave=WizardEmpresa
Icono=0
Modulos=(Todos)
Nombre=<T>Configuración General<T>

ListaCarpetas=(Lista)
CarpetaPrincipal=MenuGral
PosicionInicialAlturaCliente=569
PosicionInicialAncho=1113
MovModulo=(Todos)
PosicionInicialIzquierda=65
PosicionInicialArriba=51
PosicionCol1=725

VentanaTipoMarco=Normal
VentanaPosicionInicial=Por diseño
VentanaEstadoInicial=Normal
VentanaColor=Plata
PosicionSec1=61
PosicionSec2=310
VentanaCarpetasSinBordes=S

PosicionCol2=582
ExpresionesAlMostrar=Asigna(Temp.TextoTemp01, <T><T>)
[(Carpeta Abrir)]
Estilo=Iconos
Clave=(Carpeta Abrir)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Vista=Empresa
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S

FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=EmpresaZona
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=EmpresaGrupo
FiltroAplicaEn1=Empresa.Zona
FiltroAplicaEn2=Empresa.Grupo
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por grupos)
FiltroEstatus=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=(Todos)
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
[(Carpeta Abrir).Empresa.Empresa]
Carpeta=(Carpeta Abrir)
Clave=Empresa.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[(Carpeta Abrir).Empresa.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[(Carpeta Abrir).Empresa.Grupo]
Carpeta=(Carpeta Abrir)
Clave=Empresa.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[(Carpeta Abrir).Columnas]
0=99
1=96
2=-2








[Lista.Columnas]
SATEstado.Descripcion=129
SATMunicipio.Descripcion=123
SATColonia.Descripcion=296
SATCatCP.ClaveCP=104
SATLocalidad.Descripcion=137






ClaveEstado=115
ClavePais=143
Descripcion=362
Empresa=71
Nombre=229
FiscalRegimen=124
Extranjero=64
0=91
1=267
Almacen=90
Grupo=100
Sucursal=46
Estado=150
Delegacion=129
Colonia=189
CodigoPostal=71
Ruta=67
[Carpeta02.ListaAccionesBB]
(Inicio)=Accion001
Accion001=Accion002
Accion002=(Fin)








[Carpeta02.ListaEnCaptura]
(Inicio)=Sucursal.Sucursal
Sucursal.Sucursal=Sucursal.Nombre
Sucursal.Nombre=(Fin)














[Carpeta01.ListaEnCaptura]
(Inicio)=Empresa.Empresa
Empresa.Empresa=Empresa.Nombre
Empresa.Nombre=Empresa.Direccion
Empresa.Direccion=Empresa.DireccionNumero
Empresa.DireccionNumero=Empresa.DireccionNumeroInt
Empresa.DireccionNumeroInt=Empresa.Colonia
Empresa.Colonia=(Fin)

[Carpeta01.ListaAccionesBB]
(Inicio)=Sucursales
Sucursales=Almacenes
Almacenes=(Fin)



[Empresa]
Estilo=Ficha
Clave=Empresa
PermiteEditar=S
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=WizardEmpresa
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=141
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

ListaAccionesBB=(Lista)
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S


FichaEspacioNombresAuto=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
GuardarPorRegistro=S
GuardarAlSalir=S
FiltroGeneral=Empresa.Empresa = <T>{Info.Clave}<T>
[Empresa.Empresa.Empresa]
Carpeta=Empresa
Clave=Empresa.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Empresa.Empresa.Nombre]
Carpeta=Empresa
Clave=Empresa.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Empresa.Empresa.Direccion]
Carpeta=Empresa
Clave=Empresa.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

EspacioPrevio=N
[Empresa.Empresa.DireccionNumero]
Carpeta=Empresa
Clave=Empresa.DireccionNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Empresa.Empresa.DireccionNumeroInt]
Carpeta=Empresa
Clave=Empresa.DireccionNumeroInt
Editar=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

Pegado=S
LineaNueva=N
[Empresa.Empresa.Colonia]
Carpeta=Empresa
Clave=Empresa.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco



[Sucursales]
Estilo=Ficha
Clave=Sucursales
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=WizardSucursal
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S

CarpetaVisible=S
BarraBotones=S
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
ListaAccionesBB=(Lista)
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
FiltroGeneral=Sucursal.Sucursal = {Info.Numero}
[Sucursales.Sucursal.Sucursal]
Carpeta=Sucursales
Clave=Sucursal.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Sucursales.Sucursal.Nombre]
Carpeta=Sucursales
Clave=Sucursal.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=50
ColorFondo=Blanco





Pegado=N



[Acciones.RegimenFiscal]
Nombre=RegimenFiscal
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Regímenes<BR>Fiscales<T>
TipoAccion=Expresion
Activo=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



















NombreEnBotonX=S
Visible=S
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaRegimenFis<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaRegimenFis<T>)
[Empresa.Empresa.CodigoPostal]
Carpeta=Empresa
Clave=Empresa.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco

Pegado=S
[Empresa.Empresa.Poblacion]
Carpeta=Empresa
Clave=Empresa.Poblacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco

Pegado=S
[Empresa.Empresa.Estado]
Carpeta=Empresa
Clave=Empresa.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Empresa.Empresa.Pais]
Carpeta=Empresa
Clave=Empresa.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Pegado=S
[Empresa.Empresa.Telefonos]
Carpeta=Empresa
Clave=Empresa.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Empresa.Empresa.Fax]
Carpeta=Empresa
Clave=Empresa.Fax
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

































































Pegado=S









[Empresa.Empresa.Delegacion]
Carpeta=Empresa
Clave=Empresa.Delegacion
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=25
ColorFondo=Blanco









LineaNueva=S
























[Empresa.Empresa.Configuracion]
Carpeta=Empresa
Clave=Empresa.Configuracion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco





[Empresa.Empresa.Estatus]
Carpeta=Empresa
Clave=Empresa.Estatus
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=15
ColorFondo=Blanco







LineaNueva=S
[Empresa.Empresa.RFC]
Carpeta=Empresa
Clave=Empresa.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=18
ColorFondo=Blanco

[Empresa.Empresa.RegistroPatronal]
Carpeta=Empresa
Clave=Empresa.RegistroPatronal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

Pegado=S
[Empresa.Empresa.ClaveActividad]
Carpeta=Empresa
Clave=Empresa.ClaveActividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Empresa.Empresa.FiscalRegimen]
Carpeta=Empresa
Clave=Empresa.FiscalRegimen
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=13
ColorFondo=Blanco

Pegado=S
[Empresa.Empresa.FiscalZona]
Carpeta=Empresa
Clave=Empresa.FiscalZona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Empresa.Empresa.Representante]
Carpeta=Empresa
Clave=Empresa.Representante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Empresa.Empresa.RepresentanteRFC]
Carpeta=Empresa
Clave=Empresa.RepresentanteRFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Empresa.Empresa.RepresentanteCURP]
Carpeta=Empresa
Clave=Empresa.RepresentanteCURP
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

Pegado=S
[Empresa.Empresa.ImportadorRegimen]
Carpeta=Empresa
Clave=Empresa.ImportadorRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Empresa.Empresa.ImportadorFechaD]
Carpeta=Empresa
Clave=Empresa.ImportadorFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=21
[Empresa.Empresa.ImportadorRegistro]
Carpeta=Empresa
Clave=Empresa.ImportadorRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Empresa.Empresa.ImportadorFechaA]
Carpeta=Empresa
Clave=Empresa.ImportadorFechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=21
[Empresa.Empresa.CFD]
Carpeta=Empresa
Clave=Empresa.CFD
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Empresa.Empresa.FactorIntegracion]
Carpeta=Empresa
Clave=Empresa.FactorIntegracion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco





























































































Pegado=S
Tamano=10




















[Empresa.Empresa.Controladora]
Carpeta=Empresa
Clave=Empresa.Controladora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

Pegado=N
[Empresa.Empresa.EmpresaLDI]
Carpeta=Empresa
Clave=Empresa.EmpresaLDI
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco

Pegado=S
[Empresa.Controladora.Nombre]
Carpeta=Empresa
Clave=Controladora.Nombre
Editar=N
ValidaNombre=N
3D=S
Pegado=N
Tamano=24
ColorFondo=Plata






















[(Carpeta Abrir).ListaEnCaptura]
(Inicio)=Empresa.Empresa
Empresa.Empresa=Empresa.Nombre
Empresa.Nombre=Empresa.Grupo
Empresa.Grupo=(Fin)

[(Carpeta Abrir).FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=ALTA
ALTA=BLOQUEADO
BLOQUEADO=BAJA
BAJA=(Fin)


























[Acciones.Sucursales.AsignaVSucursal]
Nombre=AsignaVSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.IrCarpeta(<T>Sucursales<T>)



[Grupos.Columnas]
Clave=107
Grupo=223







0=106
1=210
[Acciones.Grupos.AsignaVGrupo]
Nombre=AsignaVGrupo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Forma.ActualizarVista(<T>BtnsGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
[Acciones.Sucursales.ListaAccionesMultiples]
(Inicio)=AsignaVSucursal
AsignaVSucursal=ActualizaSucursal
ActualizaSucursal=(Fin)



[Acciones.Grupos.ListaAccionesMultiples]
(Inicio)=AsignaVGrupo
AsignaVGrupo=ActualizaGrupo
ActualizaGrupo=(Fin)





[Empresa.Empresa.Grupo]
Carpeta=Empresa
Clave=Empresa.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco










[Zona.Columnas]
Zona=304




















[Empresa.Empresa.Zona]
Carpeta=Empresa
Clave=Empresa.Zona
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Blanco





Pegado=S


















[Zonas.Columnas]
Zona=304







[Organizaciones.Columnas]
Organizacion=64
Nombre=135
Descripcion=220



[RegimenesFiscales.Columnas]
FiscalRegimen=62
Nombre=604
Descripcion=386
Extranjero=64







[AlmDetalle.Alm.Sucursal]
Carpeta=AlmDetalle
Clave=Alm.Sucursal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[AlmDetalle.Alm.Almacen]
Carpeta=AlmDetalle
Clave=Alm.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[AlmDetalle.Alm.Nombre]
Carpeta=AlmDetalle
Clave=Alm.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[AlmDetalle.Alm.Rama]
Carpeta=AlmDetalle
Clave=Alm.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[AlmDetalle.Alm.Tipo]
Carpeta=AlmDetalle
Clave=Alm.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco



[AlmDetalle.Columnas]
Sucursal=64
Almacen=34
Nombre=124
Rama=124
Tipo=94





















[Sucursales.Columnas]
Sucursal=82
Nombre=256


































[AlmDetalle.ResumenCampos]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Rama
Alm.Rama=Alm.Nombre
Alm.Nombre=(Fin)

[AlmDetalle.ListaEnCaptura]
(Inicio)=Alm.Sucursal
Alm.Sucursal=Alm.Almacen
Alm.Almacen=Alm.Nombre
Alm.Nombre=Alm.Rama
Alm.Rama=Alm.Tipo
Alm.Tipo=(Fin)























[Acciones.FormaSucursal.AsignaSucursal]
Nombre=AsignaSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Sucursal, Sucursal:Sucursal.Sucursal)<BR>Informacion(Info.Sucursal)
[Acciones.FormaSucursal.FormaSucursal]
Nombre=FormaSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S













Expresion=FormaModal(<T>WizardSucursal<T>)








[Acciones.FormaSucursal.ListaAccionesMultiples]
(Inicio)=AsignaSucursal
AsignaSucursal=FormaSucursal
FormaSucursal=(Fin)



[Acciones.EditarSucursal.AsignaSucursal]
Nombre=AsignaSucursal
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Info.Sucursal,Sucursal:Sucursal.Sucursal)

[Acciones.EditarSucursal.EditaSucursal]
Nombre=EditaSucursal
Boton=0
TipoAccion=Expresion
Expresion=FormaModal(<T>WizardSucursal<T>)


[Acciones.NuevaSucursal.AsignaVariable]
Nombre=AsignaVariable
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Asigna(Info.Sucursal, Nulo )




[Acciones.NuevaSucursal.NuevaSucursal]
Nombre=NuevaSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S








Expresion=FormaModal(<T>WizardSucursal<T>)
[Acciones.EditarSucursal.ListaAccionesMultiples]
(Inicio)=AsignaSucursal
AsignaSucursal=EditaSucursal
EditaSucursal=(Fin)






[Detallesucursal.Columnas]
Almacen=115
Nombre=139





























































[Almacenes]
Estilo=Ficha
Clave=Almacenes
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=WizardAlm
Fuente={Tahoma, 8, Negro, []}
CarpetaVisible=S







Filtros=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaEnCaptura=(Lista)
PermiteEditar=S
BarraBotones=S
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
ListaAccionesBB=(Lista)
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
FiltroGeneral=Alm.Almacen = <T>{Info.Clave}<T>
[Acciones.Prueba]
Nombre=Prueba
Boton=0
NombreDesplegar=Prueba
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro





















[Acciones.PestañaGrupo]
Nombre=PestañaGrupo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

BarraBtnFondo=Negro

Expresion=Asigna(Info.Clave,EmpresaGrupo:EmpresaGrupo.Grupo)<BR>Forma.ActualizarVista(<T>EmpresaGrupos<T>)<BR>BarraIrPagina(<T>EmpresaGrupos<T>,2)            <BR>Forma.IrCarpeta(<T>EmpresaGrupos<T>)
[Acciones.NvoGpo]
Nombre=NvoGpo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40

NombreEnBoton=S
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



























NombreDesplegar=<T>Nuevo Grupo<T>
Expresion=Asigna(Info.Clave, <T><T>)<BR>Forma.ActualizarVista(<T>EmpresaGrupos<T>)<BR>Forma.LimpiarCarpeta(<T>EmpresaGrupos<T>)<BR>BarraIrPagina(<T>EmpresaGrupos<T>,3)<BR>Forma.IrCarpeta(<T>EmpresaGrupos<T>)
[BtnsGrupos.ListaAccionesBB]
(Inicio)=NvoGpo
NvoGpo=ActualizaVistaGpo
ActualizaVistaGpo=(Fin)
































[Acciones.NuevaSucursal.ListaAccionesMultiples]
(Inicio)=AsignaVariable
AsignaVariable=NuevaSucursal
NuevaSucursal=(Fin)



[Margen]
Estilo=Botones
Clave=Margen
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=Empresa
Fuente={Tahoma, 8, Negro, []}
CarpetaVisible=S









BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesPanelColor=Plata


[Acciones.EditarZonas]
Nombre=EditarZonas
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro









Expresion=Asigna(Info.Zona,EmpresaZona:EmpresaZona.Zona)<BR>Forma.ActualizarVista(<T>EmpresaZonas<T>)<BR>BarraIrPagina(<T>EmpresaZonas<T>,2)<BR>Forma.IrCarpeta(<T>EmpresaZonas<T>)
[Acciones.NvaZona]
Nombre=NvaZona
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata





NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
NombreDesplegar=<T>Nueva Zona<T>
Expresion=Asigna(Info.Zona, <T><T>)<BR>Forma.ActualizarVista(<T>EmpresaZonas<T>)<BR>Forma.LimpiarCarpeta(<T>EmpresaZonas<T>)<BR>BarraIrPagina(<T>EmpresaZonas<T>,1)<BR>Forma.IrCarpeta(<T>EmpresaZonas<T>)
[Acciones.DelGpo.EliminarGpo]
Nombre=EliminarGpo
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.DelGpo.RefreshGpo]
Nombre=RefreshGpo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.ActualizarVista(<T>Grupos<T>)

[Acciones.DelZona.BorraZona]
Nombre=BorraZona
Boton=0
Carpeta=Zonas
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S


[Acciones.DelZona.RefreshZona]
Nombre=RefreshZona
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S







NombreDesplegar=RefreshZona
Expresion=Forma.ActualizarVista(<T>EmpresaZonas<T>)
[Acciones.NuavaOrganizacion]
Nombre=NuavaOrganizacion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


NombreDesplegar=Nueva Organización
Expresion=Asigna(Info.Numero,0)<BR>Forma.ActualizarVista(<T>EmpresaOrganizaciones<T>)
[Acciones.DelOrganizacion.BorrarOrganizacion]
Nombre=BorrarOrganizacion
Boton=0
Carpeta=Organizaciones
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.DelOrganizacion.RefreshOrganizacion]
Nombre=RefreshOrganizacion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>EmpresaOrganizaciones<T>)
[Acciones.DelOrganizacion]
Nombre=DelOrganizacion
Boton=0
NombreEnBoton=S
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado




NombreDesplegar=Eliminar
[Acciones.EditarOrganizacion]
Nombre=EditarOrganizacion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro

Expresion=Asigna(Info.Numero,Organizacion:Organizacion.Organizacion)<BR>Forma.ActualizarVista(<T>EmpresaOrganizaciones<T>)<BR>BarraIrPagina(<T>EmpresaOrganizaciones<T>,1)
[Acciones.NvaOrganizacion]
Nombre=NvaOrganizacion
Boton=0
NombreEnBoton=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
























NombreDesplegar=<T>Nueva Organización<T>

Expresion=Asigna(Info.Numero,0)<BR>Forma.ActualizarVista(<T>EmpresaOrganizaciones<T>)<BR>Forma.LimpiarCarpeta(<T>EmpresaOrganizaciones<T>)<BR>BarraIrPagina(<T>EmpresaOrganizaciones<T>,2)
[Acciones.DelRegimenFis.BorrarRegimenFisc]
Nombre=BorrarRegimenFisc
Boton=0
Carpeta=RegimenesFiscales
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S


[Acciones.DelRegimenFis.RefreshRegimenFis]
Nombre=RefreshRegimenFis
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S








Expresion=Forma.ActualizarVista(<T>EmpresaRegimenesFiscales<T>)
[Acciones.EditarRegimenFis]
Nombre=EditarRegimenFis
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro



Expresion=Asigna(Info.Referencia,FiscalRegimen:FiscalRegimen.FiscalRegimen)<BR>BarraIrPagina(<T>EmpresaRegimenesFiscales<T>,1)<BR>Forma.ActualizarVista(<T>EmpresaRegimenesFiscales<T>)<BR>Forma.IrCarpeta(<T>EmpresaRegimenesFiscales<T>)
[Acciones.NvoRegimenFiscal]
Nombre=NvoRegimenFiscal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado











































NombreDesplegar=<T>Nuevo Regimen<T>
Expresion=Asigna(Info.Referencia, <T><T>)<BR>Forma.ActualizarVista(<T>EmpresaRegimenesFiscales<T>)<BR>Forma.LimpiarCarpeta(<T>EmpresaRegimenesFiscales<T>)<BR>Forma.IrCarpeta(<T>EmpresaRegimenesFiscales<T>)
[Acciones.CancelarOrganizacion]
Nombre=CancelarOrganizacion
Boton=0
NombreEnBoton=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


NombreDesplegar=Cancelar
Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsEmpresaOrganizaciones<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaOrganizaciones<T>)

[Forma.ListaAcciones]
(Inicio)=Nuevo
Nuevo=Abrir
Abrir=(Fin)




[Grupos.ListaEnCaptura]
(Inicio)=EmpresaGrupo.Grupo
EmpresaGrupo.Grupo=EmpresaGrupo.Clave
EmpresaGrupo.Clave=(Fin)

[Grupos.ListaAccionesBB]
(Inicio)=AtrasGpo
AtrasGpo=NuevoGpo
NuevoGpo=DelGpo
DelGpo=CancelarGpo
CancelarGpo=(Fin)

[Zonas.ListaAccionesBB]
(Inicio)=AtrasZona
AtrasZona=NuevaZona
NuevaZona=DelZona
DelZona=CancelarZona
CancelarZona=(Fin)

[Organizaciones.ListaEnCaptura]
(Inicio)=Organizacion.Organizacion
Organizacion.Organizacion=Organizacion.Nombre
Organizacion.Nombre=Organizacion.Descripcion
Organizacion.Descripcion=(Fin)

[Organizaciones.ListaAccionesBB]
(Inicio)=AtrasOrganizacion
AtrasOrganizacion=NuavaOrganizacion
NuavaOrganizacion=DelOrganizacion
DelOrganizacion=CancelarOrganizacion
CancelarOrganizacion=(Fin)

[RegimenesFiscales.ListaEnCaptura]
(Inicio)=FiscalRegimen.FiscalRegimen
FiscalRegimen.FiscalRegimen=FiscalRegimen.Nombre
FiscalRegimen.Nombre=FiscalRegimen.Descripcion
FiscalRegimen.Descripcion=FiscalRegimen.Extranjero
FiscalRegimen.Extranjero=(Fin)

[RegimenesFiscales.ListaAccionesBB]
(Inicio)=AtrasRegimenFis
AtrasRegimenFis=NuevoRegimenFis
NuevoRegimenFis=DelRegimenFis
DelRegimenFis=CancelarRegimenFis
CancelarRegimenFis=(Fin)



[MenuGral]
Estilo=Ficha
Clave=MenuGral
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Negro
ListaAccionesBB=(Lista)
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Arriba
BarraBtnSize=85
BarraBtnSeparacion=4
BarraBtnBisel=2
CarpetaVisible=S






















BarraBtnPaginas=1
[Acciones.MnBtnSucursales]
Nombre=MnBtnSucursales
Boton=0
NombreDesplegar=<T>Sucursales<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
BarraBtnPagina=1
Expresion=Forma.IrCarpeta(<T>BtnsSucursales<T>)<BR>Forma.IrCarpeta(<T>Margen<T>)
[Acciones.MnBtnEmpresas]
Nombre=MnBtnEmpresas
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Empresas<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado






Multiple=S
ListaAccionesMultiples=(Lista)
BarraBtnPagina=1
[Acciones.BtnsSucursal]
Nombre=BtnsSucursal
Boton=0
NombreDesplegar=BtnsSucursal
GuardarAntes=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro

Expresion=Asigna(Info.Clave,Empresa:Empresa.Empresa)<BR>Forma.ActualizarVista(<T>Empresa<T>)<BR>Forma.IrCarpeta(<T>Empresa<T>)
[BtnsEmpresa]
Estilo=Botones
Clave=BtnsEmpresa
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Empresa
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=Empresa:Empresa.Nombre
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAccion=BtnsSucursal
BotonesAncho=77
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=40
BotonesBisel=1
BotonesPanelColor=Plata
BotonesPanelBisel=1
CarpetaVisible=S








BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado








BarraBotones=S
ListaAccionesBB=NvaEmpresa
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BarraBtnPosicion=Abajo
[Acciones.MnBtnAlmacen]
Nombre=MnBtnAlmacen
Boton=0
NombreDesplegar=<T>Almacenes<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



BarraBtnPagina=1
Expresion=Forma.IrCarpeta(<T>BtnsAlmacenes<T>)<BR>Forma.IrCarpeta(<T>Margen<T>)
[BtnsSucursales]
Estilo=Botones
Clave=BtnsSucursales
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Sucursal
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=Sucursal:Sucursal.Nombre
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAncho=77
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=40
BotonesBisel=1
BotonesPanelColor=Plata
BotonesPanelBisel=1
CarpetaVisible=S

BotonesAccion=PestañaSucursal
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
BarraBotones=S
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
ListaAccionesBB=NvaSucursal
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
[Acciones.PestañaSucursal]
Nombre=PestañaSucursal
Boton=0
NombreDesplegar=PestañaSucursal
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro






Expresion=Asigna(Info.Numero,Sucursal:Sucursal.Sucursal)<BR>Forma.ActualizarVista(<T>Sucursales<T>)<BR>Forma.IrCarpeta(<T>Sucursales<T>)
[BtnsAlmacenes]
Estilo=Botones
Clave=BtnsAlmacenes
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=Alm
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=Alm:Alm.Nombre
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAncho=77
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=40
BotonesBisel=1
BotonesPanelColor=Plata
BotonesPanelBisel=1
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
CarpetaVisible=S


























BotonesAccion=PestañaAlmacenes

BarraBotones=S
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BarraBtnPaginas=1
ListaAccionesBB=NvoAlmacen
[Almacenes.Alm.Almacen]
Carpeta=Almacenes
Clave=Alm.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Almacenes.Alm.Rama]
Carpeta=Almacenes
Clave=Alm.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=22
ColorFondo=Blanco




[Acciones.PestañaAlmacenes]
Nombre=PestañaAlmacenes
Boton=0
NombreDesplegar=PestañaAlmacenes
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro
Expresion=Asigna(Info.Clave,Alm:Alm.Almacen)<BR>Forma.ActualizarVista(<T>Almacenes<T>)<BR>Forma.IrCarpeta(<T>Almacenes<T>)











[Sucursales.Sucursal.Prefijo]
Carpeta=Sucursales
Clave=Sucursal.Prefijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco





Efectos=[Negritas]

[Acciones.MnBtnEmpresas.VerEmpresa]
Nombre=VerEmpresa
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>BtnsEmpresa<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresa<T>)
[Acciones.MnBtnEmpresas.VerMargen]
Nombre=VerMargen
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S











Expresion=Forma.IrCarpeta(<T>Margen<T>)
[Acciones.NvaEmpresa]
Nombre=NvaEmpresa
Boton=0
NombreDesplegar=<T>Nueva Empresa<T>
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado













Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.NvaEmpresa.LimpiaCarpetaEmpresa]
Nombre=LimpiaCarpetaEmpresa
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Clave, <T><T>)<BR>Forma.ActualizarVista(<T>Empresa<T>)
[Acciones.NvaEmpresa.IrCarpetaEmpresa]
Nombre=IrCarpetaEmpresa
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.IrCarpeta(<T>Empresa<T>)

[Acciones.EmpresaGuardar]
Nombre=EmpresaGuardar
Boton=0
NombreDesplegar=<T>Guardar<T>
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
EspacioPrevio=S







Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.EmpresaNuevo]
Nombre=EmpresaNuevo
Boton=0
NombreDesplegar=<T>Nueva Empresa<T>
TipoAccion=Controles Captura
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

RefrescarDespues=S
Carpeta=Empresa
ClaveAccion=Registro Insertar
GuardarAntes=S
[Acciones.EmpresaCancelar.EmpresaCancelaCambio]
Nombre=EmpresaCancelaCambio
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>Empresa<T>)<BR>Forma.ActualizarVista(<T>BtnsEmpresa<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresa<T>)
[Acciones.EmpresaCancelar]
Nombre=EmpresaCancelar
Boton=0
NombreDesplegar=<T>Cancelar<T>
Multiple=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
BarraBtnFondo=Plata



NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado














[Acciones.NvaSucursal]
Nombre=NvaSucursal
Boton=0
NombreDesplegar=<T>Nueva Sucursal<T>
Multiple=S
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado






ListaAccionesMultiples=(Lista)

[Acciones.NvaSucursal.LimpiaCarpetaSucursal]
Nombre=LimpiaCarpetaSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Numero, -1)<BR>Forma.ActualizarVista(<T>Sucursales<T>)
[Acciones.NvaSucursal.AgregaRgistroSucursal]
Nombre=AgregaRgistroSucursal
Boton=0
Carpeta=Sucursales
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.NvaSucursal.IrCarpetaSucursal]
Nombre=IrCarpetaSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S





Expresion=Forma.IrCarpeta(<T>Sucursales<T>)



[Acciones.SucursalGuardar.GuardarSucursal]
Nombre=GuardarSucursal
Boton=0

TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Carpeta=Sucursales
[Acciones.SucursalGuardar]
Nombre=SucursalGuardar
Boton=0
NombreEnBoton=S
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
NombreDesplegar=<T>Guardar<T>

[Acciones.SucursalCancelar.CancelarSucursal]
Nombre=CancelarSucursal
Boton=0
TipoAccion=Expresion

Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>Sucursales<T>)    <BR>Forma.ActualizarVista(<T>BtnsSucursales<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursales<T>)
[Acciones.SucursalCancelar]
Nombre=SucursalCancelar
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cancelar<T>
Multiple=S
ListaAccionesMultiples=CancelarSucursal

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
[Acciones.SucursalCancelar.ListaAccionesMultiples]
(Inicio)=CancelarSucursal
CancelarSucursal=NuevaSucursal
NuevaSucursal=(Fin)












[Acciones.SucursalNuevo]
Nombre=SucursalNuevo
Boton=0
Carpeta=Sucursales
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S





















NombreDesplegar=<T>Nueva Sucursal<T>
[Sucursales.Sucursal.EnLinea]
Carpeta=Sucursales
Clave=Sucursal.EnLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=N
Tamano=10
OcultaNombre=N
[Sucursales.Sucursal.SucursalPrincipal]
Carpeta=Sucursales
Clave=Sucursal.SucursalPrincipal
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=15
OcultaNombre=N
[Sucursales.SucursalDestino.Prefijo]
Carpeta=Sucursales
Clave=SucursalDestino.Prefijo
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=14
ColorFondo=Plata

Pegado=S

[Sucursales.Sucursal.IP]
Carpeta=Sucursales
Clave=Sucursal.IP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

EspacioPrevio=S
Pegado=N
[Sucursales.Sucursal.UltimaSincronizacion]
Carpeta=Sucursales
Clave=Sucursal.UltimaSincronizacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=20
[Sucursales.Sucursal.IPPuerto]
Carpeta=Sucursales
Clave=Sucursal.IPPuerto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=24
[Sucursales.Sucursal.IPDinamica]
Carpeta=Sucursales
Clave=Sucursal.IPDinamica
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco















































































































Pegado=N















[Sucursales.Sucursal.Direccion]
Carpeta=Sucursales
Clave=Sucursal.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco

[Sucursales.Sucursal.DireccionNumero]
Carpeta=Sucursales
Clave=Sucursal.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco

[Sucursales.Sucursal.DireccionNumeroInt]
Carpeta=Sucursales
Clave=Sucursal.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco












[Sucursales.Sucursal.Delegacion]
Carpeta=Sucursales
Clave=Sucursal.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=27
ColorFondo=Blanco






Pegado=S
[Sucursales.Sucursal.GLN]
Carpeta=Sucursales
Clave=Sucursal.GLN
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco



LineaNueva=N

[Sucursales.Sucursal.Colonia]
Carpeta=Sucursales
Clave=Sucursal.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

Pegado=N


[Sucursales.Sucursal.CodigoPostal]
Carpeta=Sucursales
Clave=Sucursal.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=S
[Sucursales.Sucursal.Poblacion]
Carpeta=Sucursales
Clave=Sucursal.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Sucursal.Estado]
Carpeta=Sucursales
Clave=Sucursal.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

Pegado=S
[Sucursales.Sucursal.Pais]
Carpeta=Sucursales
Clave=Sucursal.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

































[Sucursales.Sucursal.Region]
Carpeta=Sucursales
Clave=Sucursal.Region
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Sucursal.ZonaImpuesto]
Carpeta=Sucursales
Clave=Sucursal.ZonaImpuesto
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=24
ColorFondo=Blanco












[Sucursales.Sucursal.Grupo]
Carpeta=Sucursales
Clave=Sucursal.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Sucursal.ZonaEconomica]
Carpeta=Sucursales
Clave=Sucursal.ZonaEconomica
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Sucursal.Categoria]
Carpeta=Sucursales
Clave=Sucursal.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Sucursal.Alta]
Carpeta=Sucursales
Clave=Sucursal.Alta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Sucursal.FechaApertura]
Carpeta=Sucursales
Clave=Sucursal.FechaApertura
Editar=S
ValidaNombre=S
3D=S
Pegado=S
ColorFondo=Blanco













Tamano=24






[Sucursales.Sucursal.Tipo]
Carpeta=Sucursales
Clave=Sucursal.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=32
ColorFondo=Blanco

Pegado=S
[Sucursales.Sucursal.Estatus]
Carpeta=Sucursales
Clave=Sucursal.Estatus
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=24
ColorFondo=Blanco



LineaNueva=S












[Sucursales.Sucursal.RFC]
Carpeta=Sucursales
Clave=Sucursal.RFC
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=32
ColorFondo=Blanco

Pegado=S
[Sucursales.Sucursal.RegistroPatronal]
Carpeta=Sucursales
Clave=Sucursal.RegistroPatronal
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=24
ColorFondo=Blanco

LineaNueva=S
EspacioPrevio=S
[Sucursales.Sucursal.FiscalRegimen]
Carpeta=Sucursales
Clave=Sucursal.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Sucursal.FiscalZona]
Carpeta=Sucursales
Clave=Sucursal.FiscalZona
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=27
ColorFondo=Blanco
























[Sucursales.Sucursal.CentroCostos]
Carpeta=Sucursales
Clave=Sucursal.CentroCostos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=24
ColorFondo=Blanco

[Sucursales.CentroCostos.Descripcion]
Carpeta=Sucursales
Clave=CentroCostos.Descripcion
Editar=N
ValidaNombre=N
3D=S
Pegado=S
Tamano=37
ColorFondo=Plata















[Sucursales.Sucursal.AlmacenPrincipal]
Carpeta=Sucursales
Clave=Sucursal.AlmacenPrincipal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Alm.Nombre]
Carpeta=Sucursales
Clave=Alm.Nombre
Editar=N
3D=S
Pegado=S
Tamano=37
ColorFondo=Plata






[Sucursales.Sucursal.CajaCentral]
Carpeta=Sucursales
Clave=Sucursal.CajaCentral
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24

ColorFondo=Blanco
[Sucursales.CtaDinero.Descripcion]
Carpeta=Sucursales
Clave=CtaDinero.Descripcion
Editar=N
3D=S
Pegado=S
Tamano=37
ColorFondo=Plata

[Sucursales.Sucursal.Acreedor]
Carpeta=Sucursales
Clave=Sucursal.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Sucursales.Acreedor.Nombre]
Carpeta=Sucursales
Clave=Acreedor.Nombre
Editar=N
3D=S
Pegado=S
Tamano=37
ColorFondo=Plata












[Almacenes.Alm.Tipo]
Carpeta=Almacenes
Clave=Alm.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

Pegado=S
[Almacenes.Alm.Nombre]
Carpeta=Almacenes
Clave=Alm.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=58
ColorFondo=Blanco

[Almacenes.AlmLista.Nombre]
Carpeta=Almacenes
Clave=AlmLista.Nombre
Editar=N
3D=S
Pegado=S
Tamano=36
ColorFondo=Plata

[Almacenes.Alm.Sucursal]
Carpeta=Almacenes
Clave=Alm.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

EspacioPrevio=S
[Almacenes.Sucursal.Nombre]
Carpeta=Almacenes
Clave=Sucursal.Nombre
Editar=S
3D=S
Pegado=S
Tamano=34
ColorFondo=Plata





















[Almacenes.Alm.Ruta]
Carpeta=Almacenes
Clave=Alm.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Almacenes.Alm.Grupo]
Carpeta=Almacenes
Clave=Alm.Grupo
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=27
ColorFondo=Blanco

[Almacenes.Alm.Exclusivo]
Carpeta=Almacenes
Clave=Alm.Exclusivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Almacenes.Alm.Estatus]
Carpeta=Almacenes
Clave=Alm.Estatus
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=26
ColorFondo=Blanco













[Almacenes.Alm.Direccion]
Carpeta=Almacenes
Clave=Alm.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=41
ColorFondo=Blanco

[Almacenes.Alm.DireccionNumero]
Carpeta=Almacenes
Clave=Alm.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=8
ColorFondo=Blanco

[Almacenes.Alm.DireccionNumeroInt]
Carpeta=Almacenes
Clave=Alm.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=9
ColorFondo=Blanco









[Almacenes.Alm.Colonia]
Carpeta=Almacenes
Clave=Alm.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Almacenes.Alm.Delegacion]
Carpeta=Almacenes
Clave=Alm.Delegacion
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=24
ColorFondo=Blanco

[Almacenes.Alm.Poblacion]
Carpeta=Almacenes
Clave=Alm.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Almacenes.Alm.Estado]
Carpeta=Almacenes
Clave=Alm.Estado
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=27
ColorFondo=Blanco

[Almacenes.Alm.Pais]
Carpeta=Almacenes
Clave=Alm.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco

[Almacenes.Alm.CodigoPostal]
Carpeta=Almacenes
Clave=Alm.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=10
ColorFondo=Blanco











[Almacenes.Alm.wMostrar]
Carpeta=Almacenes
Clave=Alm.wMostrar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco


[Almacenes.Alm.ExcluirPlaneacion]
Carpeta=Almacenes
Clave=Alm.ExcluirPlaneacion
Editar=S
ValidaNombre=S
3D=S
Pegado=N
ColorFondo=Blanco

LineaNueva=N
[Almacenes.Alm.Segundas]
Carpeta=Almacenes
Clave=Alm.Segundas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Almacenes.Alm.CEDIS]
Carpeta=Almacenes
Clave=Alm.CEDIS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Almacenes.Alm.CompraDirecta]
Carpeta=Almacenes
Clave=Alm.CompraDirecta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco






























[Almacenes.Alm.wUnicamenteDisponibles]
Carpeta=Almacenes
Clave=Alm.wUnicamenteDisponibles
Editar=S
ValidaNombre=S
3D=S
Pegado=N
ColorFondo=Blanco









[Acciones.SucursalRegion]
Nombre=SucursalRegion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


NombreDesplegar=<T>Regiones<T>
Expresion=Forma.ActualizarVista(<T>BtnsSucursalRegion<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalRegion<T>)
[Acciones.AlmacenNuevo]
Nombre=AlmacenNuevo
Boton=0
NombreDesplegar=<T>Nuevo Almacén<T>
Multiple=S
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
ListaAccionesMultiples=InsNvoAlm
[Acciones.AlmacenCancelar]
Nombre=AlmacenCancelar
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>Almacenes<T>)<BR>Forma.ActualizarVista(<T>BtnsAlmacenes<T>)<BR>Forma.IrCarpeta(<T>BtnsAlmacenes<T>)
[Acciones.AlmacenGuardar]
Nombre=AlmacenGuardar
Boton=0
NombreDesplegar=<T>Guardar<T>
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado




Multiple=S
ListaAccionesMultiples=(Lista)
[EmpresaGrupos]
Estilo=Ficha
Clave=EmpresaGrupos
Filtros=S
MenuLocal=S
PermiteEditar=S
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardempresaGrupo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaAccionesBB=(Lista)
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S


BarraBtnPaginas=3
GuardarPorRegistro=S
FiltroGeneral=EmpresaGrupo.Grupo = <T>{Info.Clave}<T>
[EmpresaGrupos.EmpresaGrupo.Grupo]
Carpeta=EmpresaGrupos
Clave=EmpresaGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[EmpresaGrupos.EmpresaGrupo.Clave]
Carpeta=EmpresaGrupos
Clave=EmpresaGrupo.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco





[BtnsEmpresaGrupos]
Estilo=Botones
Clave=BtnsEmpresaGrupos
OtroOrden=S
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=EmpresaGrupo
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=EmpresaGrupo:EmpresaGrupo.Grupo
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAccion=PestañaGrupo
BotonesAncho=80
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=80
BotonesBisel=1
BotonesPanelColor=Plata
BotonesPanelBisel=1
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
BotonesImagenAlineacion=Izquierda
BotonesImagenPosicion=Arriba
ListaOrden=EmpresaGrupo.Grupo<TAB>(Acendente)
Paginacion=S
PaginacionTamano=25
ListaAccionesBB=NvoGpo
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S





BarraBtnPaginas=1
[Acciones.EmpresaGrupos]
Nombre=EmpresaGrupos
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Grupos<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
[Acciones.EmpresaZonas]
Nombre=EmpresaZonas
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Zonas<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

Expresion=Forma.ActualizarVista(<T>BtnsEmpresaZonas<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaZonas<T>)
[Acciones.EmpresaOrganizaciones]
Nombre=EmpresaOrganizaciones
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Organizaciones<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado




Expresion=Forma.ActualizarVista(<T>BtnsEmpresaOrganizaciones<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaOrganizaciones<T>)
[EmpresaZonas]
Estilo=Ficha
Clave=EmpresaZonas
Filtros=S
PermiteEditar=S
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardEmpresaZona
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=EmpresaZona.Zona
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaAccionesBB=(Lista)

BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S

BarraBtnPaginas=2
GuardarPorRegistro=S
FiltroGeneral=EmpresaZona.Zona = <T>{Info.Zona}<T>
[EmpresaZonas.EmpresaZona.Zona]
Carpeta=EmpresaZonas
Clave=EmpresaZona.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco


[BtnsEmpresaZonas]
Estilo=Botones
Clave=BtnsEmpresaZonas
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=EmpresaZona
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=EmpresaZona:EmpresaZona.Zona
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAccion=EditarZonas
BotonesAncho=80
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=80
BotonesBisel=1
BotonesPanelColor=Plata
BotonesPanelBisel=1
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
ListaAccionesBB=NvaZona
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S



PermiteEditar=S

[EmpresaOrganizaciones.Organizacion.Organizacion]
Carpeta=EmpresaOrganizaciones
Clave=Organizacion.Organizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[EmpresaOrganizaciones.Organizacion.Nombre]
Carpeta=EmpresaOrganizaciones
Clave=Organizacion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[EmpresaOrganizaciones.Organizacion.Descripcion]
Carpeta=EmpresaOrganizaciones
Clave=Organizacion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco






[BtnsEmpresaOrganizaciones]
Estilo=Botones
Clave=BtnsEmpresaOrganizaciones
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=Organizacion
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=Organizacion:Organizacion.Nombre
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAccion=EditarOrganizacion
BotonesAncho=80
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=80
BotonesBisel=1
BotonesPanelColor=Plata
BotonesPanelBisel=1
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
ListaAccionesBB=NvaOrganizacion
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S




BarraBtnPaginas=1
[EmpresaRegimenesFiscales]
Estilo=Ficha
Clave=EmpresaRegimenesFiscales
Filtros=S
PermiteEditar=S
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardFiscalRegimen
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=113
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ListaAccionesBB=(Lista)
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S


BarraBtnPaginas=2
FiltroGeneral=FiscalRegimen.FiscalRegimen = <T>{Info.Referencia}<T>
[EmpresaRegimenesFiscales.FiscalRegimen.FiscalRegimen]
Carpeta=EmpresaRegimenesFiscales
Clave=FiscalRegimen.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[EmpresaRegimenesFiscales.FiscalRegimen.Nombre]
Carpeta=EmpresaRegimenesFiscales
Clave=FiscalRegimen.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[EmpresaRegimenesFiscales.FiscalRegimen.Descripcion]
Carpeta=EmpresaRegimenesFiscales
Clave=FiscalRegimen.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[EmpresaRegimenesFiscales.FiscalRegimen.Extranjero]
Carpeta=EmpresaRegimenesFiscales
Clave=FiscalRegimen.Extranjero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=25
[BtnsEmpresaRegimenFis]
Estilo=Botones
Clave=BtnsEmpresaRegimenFis
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=FiscalRegimen
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=FiscalRegimen:FiscalRegimen.Descripcion
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAccion=EditarRegimenFis
BotonesAncho=80
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=80
BotonesBisel=1
BotonesPanelColor=Plata
BotonesPanelBisel=1
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
ListaAccionesBB=NvoRegimenFiscal
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S











[Acciones.DelOrganizacion.ListaAccionesMultiples]
(Inicio)=BorrarOrganizacion
BorrarOrganizacion=RefreshOrganizacion
RefreshOrganizacion=(Fin)



[Acciones.DelRegimenFis.ListaAccionesMultiples]
(Inicio)=BorrarRegimenFisc
BorrarRegimenFisc=RefreshRegimenFis
RefreshRegimenFis=(Fin)


[Acciones.SucRegionNueva]
Nombre=SucRegionNueva
Boton=0
NombreEnBoton=S
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

NombreDesplegar=<T>Nueva Región<T>
GuardarAntes=S
GuardarConfirmar=S
BarraBtnPagina=1
Multiple=S
ListaAccionesMultiples=(Lista)
[SucursalRegion]
Estilo=Ficha
Clave=SucursalRegion
PermiteEditar=S
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardSucursalRegion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SucursalRegion.Region
ListaAccionesBB=(Lista)
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
GuardarPorRegistro=S
OtroOrden=S
ListaOrden=SucursalRegion.Region<TAB>(Acendente)
BarraBtnPaginas=2
FiltroGeneral=SucursalRegion.Region = <T>{Info.Clave}<T>
[SucursalRegion.SucursalRegion.Region]
Carpeta=SucursalRegion
Clave=SucursalRegion.Region
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco





[BtnsSucursalRegion]
Estilo=Botones
Clave=BtnsSucursalRegion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=SucursalRegion
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=SucursalRegion:SucursalRegion.Region
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAncho=80
BotonesSeparacion=1
BotonesMargen=1
BotonesAlto=80
BotonesBisel=1
BotonesPanelColor=Plata
BotonesPanelBisel=1
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
CarpetaVisible=S

BotonesAccion=RegionSucursal
BarraBotones=S
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
ListaAccionesBB=NvaSucRegion


[Acciones.RegionSucursal]
Nombre=RegionSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro










Expresion=Asigna(Info.Clave,SucursalRegion:SucursalRegion.Region)<BR>Forma.ActualizarVista(<T>SucursalRegion<T>)<BR>BarraIrPagina(<T>SucursalRegion<T>,1)
[Acciones.AgregaRegion]
Nombre=AgregaRegion
Boton=0
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S














[Acciones.SucRegionElimina]
Nombre=SucRegionElimina
Boton=0
NombreEnBoton=S
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

NombreDesplegar=<T>Eliminar<T>
GuardarConfirmar=S
BarraBtnPagina=1
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.SucRegionCancela]
Nombre=SucRegionCancela
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S



NombreDesplegar=<T>Cancelar<T>
BarraBtnPagina=1
Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsSucursalRegion<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalRegion<T>)
[Acciones.NvaSucRegion]
Nombre=NvaSucRegion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata







NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


NombreDesplegar=<T>Nueva Región<T>




Expresion=Asigna(Info.Referencia, <T><T>)<BR>Forma.ActualizarVista(<T>SucursalRegion<T>)<BR>Forma.LimpiarCarpeta(<T>SucursalRegion<T>)<BR>BarraIrPagina(<T>SucursalRegion<T>,2)
[BtnsSucursalGrupo]
Estilo=Botones
Clave=BtnsSucursalGrupo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=SucursalGrupo
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=SucursalGrupo:SucursalGrupo.Grupo
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAncho=80
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=80
BotonesPanelColor=Plata
BotonesPanelBisel=1
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
CarpetaVisible=S

BarraBotones=S
ListaAccionesBB=NvoSucGrupo
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BotonesAccion=GrupoSucursal
[Acciones.NvoSucGrupo.NvoGpoSucursal]
Nombre=NvoGpoSucursal
Boton=0
NombreDesplegar=NvoGpoSucursal
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Referencia, <T><T>)<BR>Forma.ActualizarVista(<T>SucursalGrupo<T>)<BR>Forma.LimpiarCarpeta(<T>SucursalGrupo<T>)<BR>BarraIrPagina(<T>SucursalGrupo<T>,2)
[Acciones.NvoSucGrupo]
Nombre=NvoSucGrupo
Boton=0
Multiple=S
ListaAccionesMultiples=NvoGpoSucursal
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

NombreDesplegar=<T>Nuevo Grupo<T>
[Acciones.NvoGrupo]
Nombre=NvoGrupo
Boton=0
NombreDesplegar=Nuevo Grupo
GuardarAntes=S
GuardarConfirmar=S
Carpeta=SucursalGrupo
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


[Acciones.SucursalGrupo]
Nombre=SucursalGrupo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado





NombreDesplegar=<T>Grupos<T>
Expresion=Forma.ActualizarVista(<T>BtnsSucursalGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalGrupo<T>)
[Acciones.GrupoSucursal]
Nombre=GrupoSucursal
Boton=0
NombreEnBoton=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado








Expresion=Asigna(Info.Referencia,SucursalGrupo:SucursalGrupo.Grupo)<BR>Forma.ActualizarVista(<T>SucursalGrupo<T>)<BR>BarraIrPagina(<T>SucursalGrupo<T>,1)
[SucursalGrupo]
Estilo=Ficha
Clave=SucursalGrupo
PermiteEditar=S
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardSucursalGrupo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaAccionesBB=(Lista)
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
CarpetaVisible=S











ListaEnCaptura=SucursalGrupo.Grupo

BarraBtnPosicion=Abajo
GuardarPorRegistro=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
BarraBtnPaginas=2
FiltroGeneral=SucursalGrupo.Grupo = <T>{Info.Referencia}<T>
[SucursalGrupo.SucursalGrupo.Grupo]
Carpeta=SucursalGrupo
Clave=SucursalGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco


















[Acciones.EliminaGpoSuc]
Nombre=EliminaGpoSuc
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Eliminar<T>
GuardarConfirmar=S
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


BarraBtnPagina=1
Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.CancelaGpoSuc]
Nombre=CancelaGpoSuc
Boton=0
NombreEnBoton=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado







NombreDesplegar=<T>Cancelar<T>
BarraBtnPagina=1
Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsSucursalGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalGrupo<T>)
[Acciones.NuevoGrupoSucursal]
Nombre=NuevoGrupoSucursal
Boton=0
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
Activo=S
Visible=S







NombreDesplegar=<T>Nuevo Grupo<T>



BarraBtnPagina=1
Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Separador]
Nombre=Separador
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro
BarraBtnAncho=5
BarraBtnAlto=77
BarraBtnPagina=1










[Acciones.DelGpo.ListaAccionesMultiples]
(Inicio)=EliminarGpo
EliminarGpo=RefreshGpo
RefreshGpo=(Fin)






[Acciones.EliminarGpo.BorraGpo]
Nombre=BorraGpo
Boton=0
NombreDesplegar=Borrar
Carpeta=EmpresaGrupos
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.EliminarGpo.RegresaGrupo]
Nombre=RegresaGrupo
Boton=0
NombreDesplegar=Grupo
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
[Acciones.NuevoGpo.ListaAccionesMultiples]
(Inicio)=InsertaGpo
InsertaGpo=RegresarGpo
RegresarGpo=(Fin)




[Acciones.GuardarGpo.GuardarGrupo]
Nombre=GuardarGrupo
Boton=0
NombreDesplegar=GuardarGrupo
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.GuardarGpo.RegresaBtns]
Nombre=RegresaBtns
Boton=0
NombreDesplegar=RegresaBtns
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)

[Acciones.GuardarGpo.ListaAccionesMultiples]
(Inicio)=GuardarGrupo
GuardarGrupo=RegresaBtns
RegresaBtns=(Fin)

[Acciones.GuardarGpo2.GpoGuardar2]
Nombre=GpoGuardar2
Boton=0
NombreDesplegar=GpoGuardar2
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.GuardarGpo2.Actualizar2]
Nombre=Actualizar2
Boton=0
NombreDesplegar=Actualizar2
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)

[Acciones.NuevoGrupo.GpoNuevo]
Nombre=GpoNuevo
Boton=0
NombreDesplegar=GpoNuevo
Carpeta=EmpresaGrupos
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.NuevoGrupo.MuestraPagina1]
Nombre=MuestraPagina1
Boton=0
NombreDesplegar=MuestraPagina1
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=BarraIrPagina(<T>EmpresaGrupos<T>,3)

[Acciones.GuardarGpo3.GpoGuardar3]
Nombre=GpoGuardar3
Boton=0
NombreDesplegar=GpoGuardar3
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.GuardarGpo3.IrPagina3]
Nombre=IrPagina3
Boton=0
NombreDesplegar=IrPagina3
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>BarraIrPagina(<T>EmpresaGrupos<T>,3)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
Activo=S
Visible=S


[Acciones.NuevoGrupo.ListaAccionesMultiples]
(Inicio)=GpoNuevo
GpoNuevo=MuestraPagina1
MuestraPagina1=(Fin)

[Acciones.CancelarGpo3.GrupoCancelar3]
Nombre=GrupoCancelar3
Boton=0
NombreDesplegar=GrupoCancelar3
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.CancelarGpo3.IrPagina3]
Nombre=IrPagina3
Boton=0
NombreDesplegar=IrPagina3
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=BarraIrPagina(<T>EmpresaGrupos<T>,1)<BR>Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)

[Acciones.CancelarGpo3.ListaAccionesMultiples]
(Inicio)=GrupoCancelar3
GrupoCancelar3=IrPagina3
IrPagina3=(Fin)




[Acciones.NuevoGrupo2.GpoNuevo]
Nombre=GpoNuevo
Boton=0
NombreDesplegar=GpoNuevo
Carpeta=EmpresaGrupos
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar

[Acciones.NuevoGrupo2.MuestraPagina1]
Nombre=MuestraPagina1
Boton=0
NombreDesplegar=MuestraPagina1
TipoAccion=Expresion





Expresion=Forma.ActualizarVista(<T>EmpresaGrupos<T>)<BR>BarraIrPagina(<T>EmpresaGrupos<T>,3)




[Acciones.NuevoGrupo2.ListaAccionesMultiples]
(Inicio)=MuestraPagina1
MuestraPagina1=GpoNuevo
GpoNuevo=(Fin)




[Acciones.GuardarGpo2.ListaAccionesMultiples]
(Inicio)=GpoGuardar2
GpoGuardar2=Actualizar2
Actualizar2=(Fin)




[Acciones.GuardarGpo3.ListaAccionesMultiples]
(Inicio)=GpoGuardar3
GpoGuardar3=IrPagina3
IrPagina3=(Fin)




[Acciones.EliminarGpo.ListaAccionesMultiples]
(Inicio)=BorraGpo
BorraGpo=RegresaGrupo
RegresaGrupo=(Fin)

[Acciones.GuardarGpoP1]
Nombre=GuardarGpoP1
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


[Acciones.CancelarGpoP1]
Nombre=CancelarGpoP1
Boton=0
NombreEnBoton=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

NombreDesplegar=<T>Cancelar<T>
Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
[Acciones.NuevoGrupoP2]
Nombre=NuevoGrupoP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Nuevo Grupo<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

GuardarAntes=S
[Acciones.GuardarGpoP2]
Nombre=GuardarGpoP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.CancelarGpoP2]
Nombre=CancelarGpoP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
[Acciones.GuardarGpoP3]
Nombre=GuardarGpoP3
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=3
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.CancelarGpoP3]
Nombre=CancelarGpoP3
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cancelar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=3
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.EliminarGpoP1.BorraGpo]
Nombre=BorraGpo
Boton=0
NombreDesplegar=BorraGpo
Carpeta=EmpresaGrupos
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar

[Acciones.EliminarGpoP1.RegresaGrupo]
Nombre=RegresaGrupo
Boton=0
NombreDesplegar=RegresaGrupo
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)






[Acciones.GuardarGpoP1.GuardarGrupo]
Nombre=GuardarGrupo
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar

Carpeta=EmpresaGrupos
[Acciones.GuardarGpoP1.RegresaBtns]
Nombre=RegresaBtns
Boton=0
NombreDesplegar=RegresaBtns
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)


[Acciones.GuardarGpoP2.GpoGuardar2]
Nombre=GpoGuardar2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar

Carpeta=EmpresaGrupos
[Acciones.GuardarGpoP2.Actualizar2]
Nombre=Actualizar2
Boton=0
TipoAccion=Expresion


Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
[Acciones.GuardarGpoP3.GpoGuardar3]
Nombre=GpoGuardar3
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar

Carpeta=EmpresaGrupos
[Acciones.GuardarGpoP3.IrPagina3]
Nombre=IrPagina3
Boton=0
TipoAccion=Expresion


Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
[Acciones.CancelarGpoP3.GrupoCancelar3]
Nombre=GrupoCancelar3
Boton=0
NombreDesplegar=GrupoCancelar3
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios

[Acciones.CancelarGpoP3.IrPagina3]
Nombre=IrPagina3
Boton=0
NombreDesplegar=IrPagina3
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)


[Acciones.NuevoGrupoP2.MuestraPagina1]
Nombre=MuestraPagina1
Boton=0
NombreDesplegar=MuestraPagina1
TipoAccion=Expresion

Expresion=Forma.ActualizarVista(<T>EmpresaGrupos<T>)<BR>BarraIrPagina(<T>EmpresaGrupos<T>,1)
[Acciones.NuevoGrupoP2.GpoNuevo]
Nombre=GpoNuevo
Boton=0
NombreDesplegar=GpoNuevo
Carpeta=EmpresaGrupos
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar






[Acciones.EliminarGpoP1.ListaAccionesMultiples]
(Inicio)=BorraGpo
BorraGpo=RegresaGrupo
RegresaGrupo=(Fin)




[Acciones.EliminarGpoP2]
Nombre=EliminarGpoP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Eliminar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



GuardarAntes=S
[Acciones.DelZona.ListaAccionesMultiples]
(Inicio)=BorraZona
BorraZona=RefreshZona
RefreshZona=(Fin)



[Acciones.CancelarZonaP1]
Nombre=CancelarZonaP1
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

BarraBtnPagina=1
Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsEmpresaZonas<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaZonas<T>)
[Acciones.GuardarZonaP1]
Nombre=GuardarZonaP1
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Guardar<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.NuevaZonaP2]
Nombre=NuevaZonaP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Nueva Zona<T>
GuardarAntes=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado





Expresion=Asigna(Info.Zona, <T><T>)     <BR>BarraIrPagina(<T>EmpresaZonas<T>,1)<BR>Forma.ActualizarVista(<T>EmpresaZonas<T>)
[Acciones.DelZonaP1.BorraZona]
Nombre=BorraZona
Boton=0
NombreDesplegar=BorraZona
Carpeta=EmpresaZonas
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar

[Acciones.DelZonaP1.RefreshZona]
Nombre=RefreshZona
Boton=0
NombreDesplegar=RefreshZona
TipoAccion=Expresion


















Expresion=Forma.ActualizarVista(<T>BtnsEmpresaZonas<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaZonas<T>)





[Acciones.DelZonaP1.ListaAccionesMultiples]
(Inicio)=BorraZona
BorraZona=RefreshZona
RefreshZona=(Fin)



[Acciones.BorraZonaP1.ZonaBorrar]
Nombre=ZonaBorrar
Boton=0
NombreDesplegar=ZonaBorrar
Carpeta=EmpresaZonas
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.BorraZonaP1.ActualizaZonaBtns]
Nombre=ActualizaZonaBtns
Boton=0
NombreDesplegar=ActualizaZonaBtns
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaZonas<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaZonas<T>)
Activo=S
Visible=S


[Acciones.BorraZonaP1.ListaAccionesMultiples]
(Inicio)=ZonaBorrar
ZonaBorrar=ActualizaZonaBtns
ActualizaZonaBtns=(Fin)




[Acciones.BorraZonaP2.ZonaBorrar]
Nombre=ZonaBorrar
Boton=0
NombreDesplegar=ZonaBorrar
Carpeta=EmpresaZonas
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar



[Acciones.BorraZonaP2.ActualizaBtnsZona]
Nombre=ActualizaBtnsZona
Boton=0
NombreDesplegar=ActualizaBtnsZona
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Forma.ActualizarVista(<T>BtnsEmpresaZonas<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaZonas<T>)
[Acciones.BorraZonaP3.ListaAccionesMultiples]
(Inicio)=ZonaBorrar
ZonaBorrar=ActualizaBtnsZona
ActualizaBtnsZona=(Fin)



[Acciones.BorraZonaP2]
Nombre=BorraZonaP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Eliminar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado















[Acciones.GuardarZonaP2.ZonaGuardaP2]
Nombre=ZonaGuardaP2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

Carpeta=EmpresaZonas
[Acciones.GuardarZonaP2.RegresaBtnsZona]
Nombre=RegresaBtnsZona
Boton=0
NombreDesplegar=RegresaBtnsZona
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaZonas<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaZonas<T>)
Activo=S
Visible=S

[Acciones.GuardarZonaP2]
Nombre=GuardarZonaP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.CancelarZonaP2]
Nombre=CancelarZonaP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado







Expresion=Forma.CancelarCambios           <BR>Forma.ActualizarVista(<T>BtnsEmpresaZonas<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaZonas<T>)

[Acciones.EliminarGpoP2.BorraGpo]
Nombre=BorraGpo
Boton=0
NombreDesplegar=BorraGpo
Carpeta=EmpresaGrupos
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar

[Acciones.EliminarGpoP2.RegresaGrupo]
Nombre=RegresaGrupo
Boton=0
TipoAccion=Expresion











Expresion=Forma.ActualizarVista(<T>BtnsEmpresaGrupos<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaGrupos<T>)
[EmpresaOrganizaciones]
Estilo=Ficha
Clave=EmpresaOrganizaciones
Zona=B2
Vista=WizardOrganizacion
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

PermiteEditar=S
GuardarPorRegistro=S
BarraBotones=S


BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata

ListaAccionesBB=(Lista)
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BarraBtnPaginas=3

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Organizacion.Organizacion = <T>{Info.Numero}<T>
[Acciones.NvaOrgP1]
Nombre=NvaOrgP1
Boton=0
NombreDesplegar=<T>Nueva Organización<T>
Activo=S
Visible=S
BarraBtnFondo=Plata


NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
Multiple=S
ListaAccionesMultiples=(Lista)
GuardarAntes=S
[Acciones.GuardarOrgP1]
Nombre=GuardarOrgP1
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Guardar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado




ListaAccionesMultiples=(Lista)
[Acciones.EliminarOrgP1]
Nombre=EliminarOrgP1
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Eliminar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

ListaAccionesMultiples=(Lista)
[Acciones.CancelarOrgP1]
Nombre=CancelarOrgP1
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado









Expresion=Forma.CancelarCambios           <BR>Forma.ActualizarVista(<T>BtnsEmpresaOrganizaciones<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaOrganizaciones<T>)
[Acciones.GuardarOrgP1.OrgGuardarP1]
Nombre=OrgGuardarP1
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

Carpeta=EmpresaOrganizaciones
[Acciones.GuardarOrgP1.RegresaBtnsOrgP1]
Nombre=RegresaBtnsOrgP1
Boton=0
NombreDesplegar=RegresaBtnsOrgP1
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>BtnsEmpresaOrganizaciones<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaOrganizaciones<T>)



[Acciones.EliminarOrgP1.BorraOrgP1]
Nombre=BorraOrgP1
Boton=0
NombreDesplegar=BorraOrgP1
Carpeta=EmpresaOrganizaciones
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.EliminarOrgP1.RegresaBtnsOrgP1]
Nombre=RegresaBtnsOrgP1
Boton=0
NombreDesplegar=RegresaBtnsOrgP1
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>BtnsEmpresaOrganizaciones<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaOrganizaciones<T>)





[Acciones.GuardarOrgP2]
Nombre=GuardarOrgP2
Boton=0
NombreDesplegar=<T>Guardar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnFondo=Plata

ListaAccionesMultiples=(Lista)
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
[Acciones.GuardarOrgP2.OrgGuardarP2]
Nombre=OrgGuardarP2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

Carpeta=EmpresaOrganizaciones
[Acciones.GuardarOrgP2.RegresaBtnsOrgP2]
Nombre=RegresaBtnsOrgP2
Boton=0
NombreDesplegar=RegresaBtnsOrgP2
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Forma.ActualizarVista(<T>BtnsEmpresaOrganizaciones<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaOrganizaciones<T>)
[Acciones.CancelarOrgP2]
Nombre=CancelarOrgP2
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado








Expresion=Forma.CancelarCambios           <BR>Forma.ActualizarVista(<T>BtnsEmpresaOrganizaciones<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaOrganizaciones<T>)
[Acciones.NvaOrgP1.Registro Insertar]
Nombre=Registro Insertar
Boton=0
NombreDesplegar=Registro Insertar
Carpeta=EmpresaOrganizaciones
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.NvaOrgP1.PaginacionP1]
Nombre=PaginacionP1
Boton=0
NombreDesplegar=PaginacionP1
TipoAccion=Expresion
Activo=S
Visible=S



























Expresion=BarraIrPagina(<T>EmpresaOrganizaciones<T>,2)

[Acciones.NuevoRegFisP1]
Nombre=NuevoRegFisP1
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Nuevo Regimen Fiscal<T>
Multiple=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



[Acciones.GuardaRegFisP1]
Nombre=GuardaRegFisP1
Boton=0
NombreDesplegar=<T>Guardar<T>
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
GuardarAntes=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado






Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.EliminaRegFisP1]
Nombre=EliminaRegFisP1
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Eliminar<T>
GuardarAntes=S
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



[Acciones.EliminaRegFisP1.RegresaRegFisBtnsP1]
Nombre=RegresaRegFisBtnsP1
Boton=0
TipoAccion=Expresion





Expresion=GuardarCambios<BR>Forma.ActualizarVista(<T>BtnsEmpresaRegimenFis<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaRegimenFis<T>)
[Acciones.NuevoRegFisP1.NvoRegFiscalP1]
Nombre=NvoRegFiscalP1
Boton=0
NombreDesplegar=NvoRegFiscalP1
Carpeta=EmpresaRegimenesFiscales
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar

[Acciones.CancelarRegFisP1]
Nombre=CancelarRegFisP1
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado





Expresion=Forma.CancelarCambios           <BR>Forma.ActualizarVista(<T>BtnsEmpresaRegimenFis<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaRegimenFis<T>)
[Acciones.GuardarRegFisP2]
Nombre=GuardarRegFisP2
Boton=0
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S


BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.GuardarRegFisP2.RegresaBtnsRegFisP2]
Nombre=RegresaBtnsRegFisP2
Boton=0
NombreDesplegar=RegresaBtnsRegFisP2
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaRegimenFis<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaRegimenFis<T>)
Activo=S
Visible=S


[Acciones.CancelarRegFisP2]
Nombre=CancelarRegFisP2
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsEmpresaRegimenFis<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaRegimenFis<T>)
[Acciones.NuevoRegFisP1.CambiaPaginaP1]
Nombre=CambiaPaginaP1
Boton=0
NombreDesplegar=CambiaPaginaP1
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=BarraIrPagina(<T>EmpresaRegimenesFiscales<T>,2)




[Acciones.SeparaSucursal]
Nombre=SeparaSucursal
Boton=0
NombreDesplegar=<T>SeparaSucursal<T>
EsSeparador=S
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Negro
BarraBtnPagina=1



[Acciones.SucRegionGuarda]
Nombre=SucRegionGuarda
Boton=0
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S


BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado





[Acciones.SucRegionGuardaP2]
Nombre=SucRegionGuardaP2
Boton=0
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S

BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


[Acciones.SucRegionCancelaP2]
Nombre=SucRegionCancelaP2
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

Expresion=Forma.CancelarCambios           <BR>Forma.ActualizarVista(<T>BtnsSucursalRegion<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalRegion<T>)
[Acciones.SucRegionNueva.PagNueSucRegion]
Nombre=PagNueSucRegion
Boton=0
NombreDesplegar=PagNueSucRegion
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=BarraIrPagina(<T>SucursalRegion<T>,2)
[Acciones.SucRegionNueva.NuevaSucRegion]
Nombre=NuevaSucRegion
Boton=0
NombreDesplegar=NuevaSucRegion
Carpeta=SucursalRegion
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S








[Acciones.SucRegionGuardaP2.GuardaSucRegionP2]
Nombre=GuardaSucRegionP2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar

Carpeta=SucursalRegion
[Acciones.SucRegionGuardaP2.PagGuardarSucRegionP2]
Nombre=PagGuardarSucRegionP2
Boton=0
NombreDesplegar=PagGuardarSucRegionP2
TipoAccion=Expresion


Expresion=Forma.ActualizarVista(<T>BtnsSucursalRegion<T>)<BR>BarraIrPagina(<T>BtnsSucursalRegion<T>,1)
[Acciones.SucRegionGuarda.PagGuardarSucRegionP1]
Nombre=PagGuardarSucRegionP1
Boton=0
NombreDesplegar=PagGuardarSucRegionP1
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>BtnsSucursalRegion<T>)<BR>BarraIrPagina(<T>BtnsSucursalRegion<T>,1)


[Acciones.SucRegionElimina.BorraSucRegion]
Nombre=BorraSucRegion
Boton=0
NombreDesplegar=BorraSucRegion
Carpeta=SucursalRegion
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.SucRegionElimina.CambiaPaginaBorrar]
Nombre=CambiaPaginaBorrar
Boton=0
NombreDesplegar=CambiaPaginaBorrar
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Forma.ActualizarVista(<T>BtnsSucursalRegion<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalRegion<T>)


[Acciones.SucRegionGuarda.GuardaSucRegion]
Nombre=GuardaSucRegion
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar






Carpeta=SucursalRegion
[Acciones.NuevoGrupoSucursal.GpoSucNuevo]
Nombre=GpoSucNuevo
Boton=0
NombreDesplegar=GpoSucNuevo
Carpeta=SucursalGrupo
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.NuevoGrupoSucursal.PagNvoGpoSuc]
Nombre=PagNvoGpoSuc
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=BarraIrPagina(<T>SucursalGrupo<T>,2)
[Acciones.EliminaGpoSuc.BorraGpoSuc]
Nombre=BorraGpoSuc
Boton=0
NombreDesplegar=BorraGpoSuc
Carpeta=SucursalGrupo
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.EliminaGpoSuc.PaginaBorraGpoSuc]
Nombre=PaginaBorraGpoSuc
Boton=0
NombreDesplegar=PaginaBorraGpoSuc
TipoAccion=Expresion
Activo=S
Visible=S






Expresion=Forma.ActualizarVista(<T>BtnsSucursalGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalGrupo<T>)
[Acciones.GuardaGpoSuc]
Nombre=GuardaGpoSuc
Boton=0
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S


BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


[Acciones.GuardaGpoSuc.GuardaGrupoSuc]
Nombre=GuardaGrupoSuc
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar

Carpeta=SucursalGrupo
[Acciones.GuardaGpoSuc.PaginaGuardaGpoSuc]
Nombre=PaginaGuardaGpoSuc
Boton=0
TipoAccion=Expresion





Expresion=Forma.ActualizarVista(<T>BtnsSucursalGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalGrupo<T>)
[Acciones.GuardaGpoSucP2]
Nombre=GuardaGpoSucP2
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



[Acciones.CancelarGpoSucP2]
Nombre=CancelarGpoSucP2
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado




Expresion=Forma.CancelarCambios           <BR>Forma.ActualizarVista(<T>BtnsSucursalGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalGrupo<T>)
[Acciones.GuardaGpoSucP2.PaginaGuardaGpoSucP2]
Nombre=PaginaGuardaGpoSucP2
Boton=0
TipoAccion=Expresion


Expresion=Forma.ActualizarVista(<T>BtnsSucursalGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalGrupo<T>)
[Acciones.SeparadorAlmacen]
Nombre=SeparadorAlmacen
Boton=0
NombreDesplegar=<T>Separador<T>
EsSeparador=S
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=5
BarraBtnAlto=40
BarraBtnFondo=Negro
BarraBtnPagina=1

[Acciones.AlmGrupo]
Nombre=AlmGrupo
Boton=0
NombreDesplegar=<T>Grupos<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado




Expresion=Forma.IrCarpeta(<T>BtnsAlmGrupo<T>)
[BtnsAlmGrupo]
Estilo=Botones
Clave=BtnsAlmGrupo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=AlmGrupo
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=AlmGrupo:AlmGrupo.Grupo
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAncho=80
BotonesSeparacion=1
BotonesMargen=1
BotonesAlto=80
BotonesPanelColor=Plata
BotonesPanelBisel=1
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
CarpetaVisible=S

BotonesAccion=BotonAlmGrupo
BarraBotones=S
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BarraBtnPaginas=2
ListaAccionesBB=NvoAlmGrupo


[Acciones.BotonAlmGrupo]
Nombre=BotonAlmGrupo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro












Expresion=Asigna(Info.Referencia,AlmGrupo:AlmGrupo.Grupo)<BR>Forma.ActualizarVista(<T>AlmGrupo<T>)<BR>BarraIrPagina(<T>AlmGrupo<T>,1)
[AlmGrupo]
Estilo=Ficha
Clave=AlmGrupo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardAlmGrupo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=AlmGrupo.Grupo
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
BarraBotones=S
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BarraBtnPaginas=2
ListaAccionesBB=(Lista)
GuardarPorRegistro=S
FiltroGeneral=AlmGrupo.Grupo = <T>{Info.Referencia}<T>
[AlmGrupo.AlmGrupo.Grupo]
Carpeta=AlmGrupo
Clave=AlmGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco












[Acciones.NvoAlmGpo]
Nombre=NvoAlmGpo
Boton=0
NombreEnBoton=S
NombreDesplegar=<T>Nuevo Grupo<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.GuardaAlmGpo]
Nombre=GuardaAlmGpo
Boton=0
NombreDesplegar=<T>Guardar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.EliminaAlmGpo]
Nombre=EliminaAlmGpo
Boton=0
NombreDesplegar=<T>Eliminar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnFondo=Plata

NombreEnBoton=S
ListaAccionesMultiples=(Lista)
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


GuardarConfirmar=S
[Acciones.EliminaAlmGpo.BorraAlmGpoP1]
Nombre=BorraAlmGpoP1
Boton=0
NombreDesplegar=BorraAlmGpoP1
Carpeta=AlmGrupo
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.EliminaAlmGpo.PaginaBorraAlmGpoP1]
Nombre=PaginaBorraAlmGpoP1
Boton=0
NombreDesplegar=PaginaBorraAlmGpoP1
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.ActualizarVista(<T>BtnsAlmGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsAlmGrupo<T>)
[Acciones.NvoAlmGrupo]
Nombre=NvoAlmGrupo
Boton=0
NombreDesplegar=<T>Nuevo Grupo<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado










Expresion=Asigna(Info.Referencia, <T><T>)<BR>Forma.ActualizarVista(<T>AlmGrupo<T>)<BR>Forma.LimpiarCarpeta(<T>AlmGrupo<T>)<BR>BarraIrPagina(<T>AlmGrupo<T>,2)
[Acciones.CancelaAlmGpo]
Nombre=CancelaAlmGpo
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsAlmGrupo<T>)<BR>BarraIrPagina(<T>BtnsAlmGrupo<T>,1)
[Acciones.GuardaAlmGpoP2]
Nombre=GuardaAlmGpoP2
Boton=0
NombreDesplegar=<T>Guardar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.CancelaAlmGpoP2]
Nombre=CancelaAlmGpoP2
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Plata
NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado









Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsAlmGrupo<T>)<BR>BarraIrPagina(<T>BtnsAlmGrupo<T>,1)
[Acciones.NvoAlmGpo.NvoAlmGpoP1]
Nombre=NvoAlmGpoP1
Boton=0
NombreDesplegar=NvoAlmGpoP1
Carpeta=AlmGrupo
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar

[Acciones.NvoAlmGpo.PagNvoAlmGpoP1]
Nombre=PagNvoAlmGpoP1
Boton=0
NombreDesplegar=PagNvoAlmGpoP1
TipoAccion=Expresion
Expresion=BarraIrPagina(<T>AlmGrupo<T>,2)



[Acciones.NvoAlmacen]
Nombre=NvoAlmacen
Boton=0
NombreDesplegar=<T>Nuevo Almacén<T>
Multiple=S
Activo=S
Visible=S
BarraBtnFondo=Plata

ListaAccionesMultiples=(Lista)

NombreEnBoton=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
[Acciones.NvoAlmacen.NvoRegAlm]
Nombre=NvoRegAlm
Boton=0
NombreDesplegar=NvoRegAlm
Carpeta=Almacenes
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.NvoAlmacen.IrCarpetaAlm]
Nombre=IrCarpetaAlm
Boton=0
NombreDesplegar=IrCarpetaAlm
TipoAccion=Expresion
Expresion=Forma.IrCarpeta(<T>Almacenes<T>)
Activo=S
Visible=S




[Acciones.AlmacenNuevo.InsNvoAlm]
Nombre=InsNvoAlm
Boton=0
NombreDesplegar=Nuevo Almacén
Carpeta=Almacenes
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S








[Acciones.NvaSucursal.ListaAccionesMultiples]
(Inicio)=LimpiaCarpetaSucursal
LimpiaCarpetaSucursal=AgregaRgistroSucursal
AgregaRgistroSucursal=IrCarpetaSucursal
IrCarpetaSucursal=(Fin)




[Acciones.NvaOrgP1.ListaAccionesMultiples]
(Inicio)=Registro Insertar
Registro Insertar=PaginacionP1
PaginacionP1=(Fin)


[Acciones.EliminarOrgP1.ListaAccionesMultiples]
(Inicio)=BorraOrgP1
BorraOrgP1=RegresaBtnsOrgP1
RegresaBtnsOrgP1=(Fin)





[Acciones.NuevoGrupoP2.ListaAccionesMultiples]
(Inicio)=MuestraPagina1
MuestraPagina1=GpoNuevo
GpoNuevo=(Fin)



[Acciones.CancelarGpoP3.ListaAccionesMultiples]
(Inicio)=GrupoCancelar3
GrupoCancelar3=IrPagina3
IrPagina3=(Fin)




[Acciones.BorraZonaP2.ListaAccionesMultiples]
(Inicio)=ZonaBorrar
ZonaBorrar=ActualizaBtnsZona
ActualizaBtnsZona=(Fin)





[Acciones.SucRegionNueva.ListaAccionesMultiples]
(Inicio)=NuevaSucRegion
NuevaSucRegion=PagNueSucRegion
PagNueSucRegion=(Fin)

[Acciones.SucRegionElimina.ListaAccionesMultiples]
(Inicio)=BorraSucRegion
BorraSucRegion=CambiaPaginaBorrar
CambiaPaginaBorrar=(Fin)




[Acciones.EliminaGpoSuc.ListaAccionesMultiples]
(Inicio)=BorraGpoSuc
BorraGpoSuc=PaginaBorraGpoSuc
PaginaBorraGpoSuc=(Fin)


[Acciones.NvoAlmGpo.ListaAccionesMultiples]
(Inicio)=NvoAlmGpoP1
NvoAlmGpoP1=PagNvoAlmGpoP1
PagNvoAlmGpoP1=(Fin)

[Acciones.EliminaAlmGpo.ListaAccionesMultiples]
(Inicio)=BorraAlmGpoP1
BorraAlmGpoP1=PaginaBorraAlmGpoP1
PaginaBorraAlmGpoP1=(Fin)



[Acciones.EliminarGpoP2.ListaAccionesMultiples]
(Inicio)=BorraGpo
BorraGpo=RegresaGrupo
RegresaGrupo=(Fin)




[Acciones.EmpresaGuardar.EmpresaGuardaEmp]
Nombre=EmpresaGuardaEmp
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

Carpeta=Empresa
[Acciones.EmpresaGuardar.EmpresaCambiaVista]
Nombre=EmpresaCambiaVista
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresa<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresa<T>)
Activo=S
Visible=S


[Acciones.EliminaRegFisP1.BorraRegFisP1]
Nombre=BorraRegFisP1
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar

Carpeta=EmpresaRegimenesFiscales








[Acciones.EliminaRegFisP1.ListaAccionesMultiples]
(Inicio)=BorraRegFisP1
BorraRegFisP1=RegresaRegFisBtnsP1
RegresaRegFisBtnsP1=(Fin)



[Acciones.EmpresaCancelar.EmpCancela]
Nombre=EmpCancela
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S




[Acciones.SucursalGuardar.SucursalRegresaBtns]
Nombre=SucursalRegresaBtns
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Forma.ActualizarVista(<T>BtnsSucursales<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursales<T>)


[Acciones.EmpresaCancelar.ListaAccionesMultiples]
(Inicio)=EmpCancela
EmpCancela=EmpresaCancelaCambio
EmpresaCancelaCambio=(Fin)






[Acciones.SucursalCategoria]
Nombre=SucursalCategoria
Boton=0
NombreDesplegar=<T>Categorías<T>
Activo=S
Visible=S
BarraBtnFondo=Plata
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

TipoAccion=Expresion



Expresion=Forma.ActualizarVista(<T>BtnsSucursalCat<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalCat<T>)
[Acciones.SucursalTipo]
Nombre=SucursalTipo
Boton=0
NombreDesplegar=<T>Tipos<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado






Expresion=Forma.ActualizarVista(<T>BtnsSucursalTipo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalTipo<T>)
[BtnsSucursalCat]
Estilo=Botones
Clave=BtnsSucursalCat
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardSucursalCat
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=WizardSucursalCat:SucursalCat.Categoria
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesPanelColor=Plata
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado
CarpetaVisible=S
BotonesAncho=80
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=80
BotonesPanelBisel=1

BotonesAccion=CatSucursal
BarraBotones=S
ListaAccionesBB=NvaSucCat
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnPaginas=1
BarraBtnBisel=1
[Acciones.CatSucursal]
Nombre=CatSucursal
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro


Expresion=Asigna(Info.Referencia,WizardSucursalCat:SucursalCat.Categoria)<BR>Forma.ActualizarVista(<T>SucursalCat<T>)<BR>BarraIrPagina(<T>SucursalCat<T>,1)
[SucursalCat]
Estilo=Ficha
Clave=SucursalCat
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardSucursalCat
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SucursalCat.Categoria
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
BarraBotones=S
ListaAccionesBB=(Lista)
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BarraBtnPaginas=2
GuardarPorRegistro=S
FiltroGeneral=SucursalCat.Categoria = <T>{Info.Referencia}<T>
[SucursalCat.SucursalCat.Categoria]
Carpeta=SucursalCat
Clave=SucursalCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[SucursalCat.Columnas]
Categoria=304



[Acciones.NvaSucCat]
Nombre=NvaSucCat
Boton=0
NombreDesplegar=<T>Nueva Categoría<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=2
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado
















Expresion=Asigna(Info.Referencia, <T><T>)<BR>Forma.ActualizarVista(<T>SucursalCat<T>)<BR>Forma.LimpiarCarpeta(<T>SucursalCat<T>)<BR>BarraIrPagina(<T>SucursalCat<T>,2)
[Acciones.NvaSucCategoria]
Nombre=NvaSucCategoria
Boton=0
NombreDesplegar=<T>Nueva Categoría<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.GuardaSucCategoria]
Nombre=GuardaSucCategoria
Boton=0
NombreDesplegar=<T>Guardar<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.EliminarSucCategoria]
Nombre=EliminarSucCategoria
Boton=0
NombreDesplegar=<T>Eliminar<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado



Multiple=S
ListaAccionesMultiples=(Lista)
GuardarConfirmar=S
[Acciones.CancelaSucCategoria]
Nombre=CancelaSucCategoria
Boton=0
NombreDesplegar=<T>Cancelar<T>
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1



Expresion=Forma.CancelarCambios<BR>Forma.ActualizarVista(<T>BtnsSucursalCat<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalCat<T>)
[Acciones.GuardaSucCategoria2]
Nombre=GuardaSucCategoria2
Boton=0
NombreDesplegar=<T>Guardar<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.CancelaSucCategoria2]
Nombre=CancelaSucCategoria2
Boton=0
NombreDesplegar=<T>Cancelar<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado


Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.NvaSucCategoria.SucCategoriaNva]
Nombre=SucCategoriaNva
Boton=0
Carpeta=SucursalCat
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.NvaSucCategoria.PagNvaSucCategoria]
Nombre=PagNvaSucCategoria
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=BarraIrPagina(<T>SucursalCat<T>,2)
[Acciones.NuevoGrupoSucursal.ListaAccionesMultiples]
(Inicio)=GpoSucNuevo
GpoSucNuevo=PagNvoGpoSuc
PagNvoGpoSuc=(Fin)


[Acciones.GuardaSucCategoria.SucCategoriaGuarda]
Nombre=SucCategoriaGuarda
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

Carpeta=SucursalCat
[Acciones.GuardaSucCategoria.SucCategoriaGuardaPag]
Nombre=SucCategoriaGuardaPag
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Forma.ActualizarVista(<T>BtnsSucursalCat<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalCat<T>)
[Acciones.EliminarSucCategoria.SucCategoriaEliminar]
Nombre=SucCategoriaEliminar
Boton=0
Carpeta=SucursalCat
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.EliminarSucCategoria.SucCategoriaEliminarPag]
Nombre=SucCategoriaEliminarPag
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsSucursalCat<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalCat<T>)
Activo=S
Visible=S


[Acciones.GuardaSucCategoria2.SucCategoriaGuarda2]
Nombre=SucCategoriaGuarda2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

Carpeta=SucursalCat
[Acciones.GuardaSucCategoria2.SucCategoriaGuardaPag]
Nombre=SucCategoriaGuardaPag
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsSucursalCat<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalCat<T>)
Activo=S
Visible=S


[Acciones.CancelaSucCategoria2.SucCategoriaCancela2]
Nombre=SucCategoriaCancela2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.CancelaSucCategoria2.SucCategoriaCancelaPag2]
Nombre=SucCategoriaCancelaPag2
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsSucursalCat<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalCat<T>)
Activo=S
Visible=S

[Acciones.CancelaSucCategoria2.ListaAccionesMultiples]
(Inicio)=SucCategoriaCancela2
SucCategoriaCancela2=SucCategoriaCancelaPag2
SucCategoriaCancelaPag2=(Fin)

[Acciones.NvaSucCategoria.ListaAccionesMultiples]
(Inicio)=SucCategoriaNva
SucCategoriaNva=PagNvaSucCategoria
PagNvaSucCategoria=(Fin)






[Acciones.EliminarSucCategoria.ListaAccionesMultiples]
(Inicio)=SucCategoriaEliminar
SucCategoriaEliminar=SucCategoriaEliminarPag
SucCategoriaEliminarPag=(Fin)






[Acciones.Accion]
Nombre=Accion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
BarraBtnFondo=Negro

Expresion=Asigna(Info.Referencia,WizardSucursalTipo:SucursalTipo.Tipo)<BR>Forma.ActualizarVista(<T>SucursalTipo<T>)<BR>BarraIrPagina(<T>SucursalTipo<T>,1)
[BtnsSucursalTipo]
Estilo=Botones
Clave=BtnsSucursalTipo
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardSucursalTipo
Fuente={Tahoma, 8, Negro, []}
BotonesTexto=WizardSucursalTipo:SucursalTipo.Tipo
BotonesTextoFuente={MS Sans Serif, 8, Negro, []}
BotonesColor=Plata
BotonesAccion=Accion
BotonesAncho=80
BotonesSeparacion=2
BotonesMargen=1
BotonesAlto=80
BotonesPanelColor=Plata
BotonesPanelBisel=1
ListaAccionesBB=NvoSucTipo
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BarraBtnPaginas=1
CarpetaVisible=S
BotonesTextoPosicion=Centrado
BotonesTextoAlineacion=Centrado


[SucursalTipo]
Estilo=Ficha
Clave=SucursalTipo
BarraBotones=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=WizardSucursalTipo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaAlineacionDerecha=S
FichaColorFondo=Plata
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SucursalTipo.Tipo
BarraBtnFuente={MS Sans Serif, 8, Negro, []}
BarraBtnFondo=Plata
CarpetaVisible=S

ListaAccionesBB=(Lista)
BarraBtnPosicion=Abajo
BarraBtnSize=50
BarraBtnSeparacion=1
BarraBtnBisel=1
BarraBtnPaginas=2
PermiteEditar=S
GuardarPorRegistro=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=SucursalTipo.Tipo = <T>{Info.Referencia}<T>
[SucursalTipo.SucursalTipo.Tipo]
Carpeta=SucursalTipo
Clave=SucursalTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco












[Acciones.NvoSucTipo.NvoSucTipo]
Nombre=NvoSucTipo
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=Asigna(Info.Referencia, <T><T>)<BR>Forma.ActualizarVista(<T>SucursalTipo<T>)<BR>Forma.LimpiarCarpeta(<T>SucursalTipo<T>)<BR>BarraIrPagina(<T>SucursalTipo<T>,2)
[Acciones.NvoSucTipo1]
Nombre=NvoSucTipo1
Boton=0
NombreDesplegar=<T>NuevoTipo<T>
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.GuardaSucTipo2]
Nombre=GuardaSucTipo2
Boton=0
NombreDesplegar=<T>Guardar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

ListaAccionesMultiples=(Lista)
[Acciones.GuardaSucTipo2.SucTipoGuardar2]
Nombre=SucTipoGuardar2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

Carpeta=SucursalTipo
[Acciones.GuardaSucTipo2.SucTipoGuardar2Pag]
Nombre=SucTipoGuardar2Pag
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsSucursalTipo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalTipo<T>)
Activo=S
Visible=S




[Acciones.NvoSucTipo]
Nombre=NvoSucTipo
Boton=0
NombreDesplegar=<T>Nuevo Tipo<T>
TipoAccion=Expresion
BarraBtnFondo=Plata

BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado





Expresion=Asigna(Info.Referencia, <T><T>)<BR>Forma.ActualizarVista(<T>SucursalTipo<T>)<BR>Forma.LimpiarCarpeta(<T>SucursalTipo<T>)<BR>BarraIrPagina(<T>SucursalTipo<T>,2)
[Acciones.GuardaSucTipo1.SucTipoGuarda2]
Nombre=SucTipoGuarda2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

Carpeta=SucursalTipo
[Acciones.GuardaSucTipo1.SucTipoGuarda2Pag]
Nombre=SucTipoGuarda2Pag
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsSucursalTipo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalTipo<T>)
Activo=S
Visible=S

[Acciones.GuardaSucTipo1]
Nombre=GuardaSucTipo1
Boton=0
NombreDesplegar=<T>Guardar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnFondo=Plata


BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.EliminaSucTipo1]
Nombre=EliminaSucTipo1
Boton=0
NombreDesplegar=<T>Eliminar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

ListaAccionesMultiples=(Lista)
[Acciones.EliminaSucTipo1.SucTipoElimina]
Nombre=SucTipoElimina
Boton=0
Carpeta=SucursalTipo
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.EliminaSucTipo1.SucTipoEliminaPag]
Nombre=SucTipoEliminaPag
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsSucursalTipo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalTipo<T>)
Activo=S
Visible=S


[Acciones.CancelaSucTipo.SucTipoCancela1]
Nombre=SucTipoCancela1
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.CancelaSucTipo.SucTipoCancela1Pag]
Nombre=SucTipoCancela1Pag
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Forma.ActualizarVista(<T>BtnsSucursalTipo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalTipo<T>)
[Acciones.CancelaSucTipo]
Nombre=CancelaSucTipo
Boton=0
NombreDesplegar=<T>Cancelar<T>
Multiple=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=1
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

[Acciones.CancelaSucTipo2]
Nombre=CancelaSucTipo2
Boton=0
NombreDesplegar=<T>Cancelar<T>
Multiple=S
Activo=S
Visible=S
BarraBtnAncho=77
BarraBtnMargen=1
BarraBtnAlto=40
BarraBtnFondo=Plata
NombreEnBotonX=S
BarraBtnPagina=2
BarraBtnTxtPos=Centrado
BarraBtnTxtAlign=Centrado

ListaAccionesMultiples=(Lista)
[Acciones.CancelaSucTipo2.SucTipoCancela2]
Nombre=SucTipoCancela2
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S


[Acciones.CancelaSucTipo2.SucTipoCancela2Pag]
Nombre=SucTipoCancela2Pag
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Forma.ActualizarVista(<T>BtnsSucursalTipo<T>)<BR>Forma.IrCarpeta(<T>BtnsSucursalTipo<T>)

[Acciones.SucursalGuardar.ListaAccionesMultiples]
(Inicio)=GuardarSucursal
GuardarSucursal=SucursalRegresaBtns
SucursalRegresaBtns=(Fin)

[Sucursales.ListaEnCaptura]
(Inicio)=Sucursal.Sucursal
Sucursal.Sucursal=Sucursal.Nombre
Sucursal.Nombre=Sucursal.Prefijo
Sucursal.Prefijo=Sucursal.EnLinea
Sucursal.EnLinea=Sucursal.SucursalPrincipal
Sucursal.SucursalPrincipal=SucursalDestino.Prefijo
SucursalDestino.Prefijo=Sucursal.IP
Sucursal.IP=Sucursal.UltimaSincronizacion
Sucursal.UltimaSincronizacion=Sucursal.IPPuerto
Sucursal.IPPuerto=Sucursal.IPDinamica
Sucursal.IPDinamica=Sucursal.Direccion
Sucursal.Direccion=Sucursal.DireccionNumero
Sucursal.DireccionNumero=Sucursal.DireccionNumeroInt
Sucursal.DireccionNumeroInt=Sucursal.Colonia
Sucursal.Colonia=Sucursal.Delegacion
Sucursal.Delegacion=Sucursal.Poblacion
Sucursal.Poblacion=Sucursal.Estado
Sucursal.Estado=Sucursal.Pais
Sucursal.Pais=Sucursal.CodigoPostal
Sucursal.CodigoPostal=Sucursal.GLN
Sucursal.GLN=Sucursal.Region
Sucursal.Region=Sucursal.ZonaImpuesto
Sucursal.ZonaImpuesto=Sucursal.Grupo
Sucursal.Grupo=Sucursal.ZonaEconomica
Sucursal.ZonaEconomica=Sucursal.Categoria
Sucursal.Categoria=Sucursal.Alta
Sucursal.Alta=Sucursal.FechaApertura
Sucursal.FechaApertura=Sucursal.Estatus
Sucursal.Estatus=Sucursal.Tipo
Sucursal.Tipo=Sucursal.RegistroPatronal
Sucursal.RegistroPatronal=Sucursal.RFC
Sucursal.RFC=Sucursal.FiscalRegimen
Sucursal.FiscalRegimen=Sucursal.FiscalZona
Sucursal.FiscalZona=Sucursal.CentroCostos
Sucursal.CentroCostos=CentroCostos.Descripcion
CentroCostos.Descripcion=Sucursal.AlmacenPrincipal
Sucursal.AlmacenPrincipal=Alm.Nombre
Alm.Nombre=Sucursal.CajaCentral
Sucursal.CajaCentral=CtaDinero.Descripcion
CtaDinero.Descripcion=Sucursal.Acreedor
Sucursal.Acreedor=Acreedor.Nombre
Acreedor.Nombre=(Fin)

[Sucursales.ListaAccionesBB]
(Inicio)=SucursalGuardar
SucursalGuardar=SucursalCancelar
SucursalCancelar=SucursalNuevo
SucursalNuevo=SeparaSucursal
SeparaSucursal=SucursalRegion
SucursalRegion=SucursalGrupo
SucursalGrupo=SucursalCategoria
SucursalCategoria=SucursalTipo
SucursalTipo=(Fin)

[Acciones.AlmacenGuardar.GuardarAlmacen]
Nombre=GuardarAlmacen
Boton=0
Carpeta=Almacenes
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

[Acciones.AlmacenGuardar.ActualizaCarpeta]
Nombre=ActualizaCarpeta
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsAlmacenes<T>)<BR>Forma.IrCarpeta(<T>BtnsAlmacenes<T>)
Activo=S
Visible=S






[Acciones.GuardarZonaP1.GuardaZona]
Nombre=GuardaZona
Boton=0
Carpeta=EmpresaZonas
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

[Acciones.GuardarZonaP1.ExpresionZona]
Nombre=ExpresionZona
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaZonas<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaZonas<T>)
Activo=S
Visible=S








[Acciones.NuevoRegFisP1.ListaAccionesMultiples]
(Inicio)=NvoRegFiscalP1
NvoRegFiscalP1=CambiaPaginaP1
CambiaPaginaP1=(Fin)

[Acciones.GuardaRegFisP1.GuardaRegFisP1]
Nombre=GuardaRegFisP1
Boton=0
Carpeta=EmpresaRegimenesFiscales
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

[Acciones.GuardaRegFisP1.ExpresionGuardaRegFisP1]
Nombre=ExpresionGuardaRegFisP1
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsEmpresaRegimenFis<T>)<BR>Forma.IrCarpeta(<T>BtnsEmpresaRegimenFis<T>)
Activo=S
Visible=S

[Acciones.GuardaRegFisP1.ListaAccionesMultiples]
(Inicio)=GuardaRegFisP1
GuardaRegFisP1=ExpresionGuardaRegFisP1
ExpresionGuardaRegFisP1=(Fin)

[Acciones.GuardarRegFisP2.GuardaRegimenFisP2]
Nombre=GuardaRegimenFisP2
Boton=0
Carpeta=EmpresaRegimenesFiscales
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar





[Acciones.GuardarRegFisP2.ListaAccionesMultiples]
(Inicio)=GuardaRegimenFisP2
GuardaRegimenFisP2=RegresaBtnsRegFisP2
RegresaBtnsRegFisP2=(Fin)

[EmpresaRegimenesFiscales.ListaEnCaptura]
(Inicio)=FiscalRegimen.FiscalRegimen
FiscalRegimen.FiscalRegimen=FiscalRegimen.Nombre
FiscalRegimen.Nombre=FiscalRegimen.Descripcion
FiscalRegimen.Descripcion=FiscalRegimen.Extranjero
FiscalRegimen.Extranjero=(Fin)

[EmpresaRegimenesFiscales.ListaAccionesBB]
(Inicio)=NuevoRegFisP1
NuevoRegFisP1=GuardaRegFisP1
GuardaRegFisP1=EliminaRegFisP1
EliminaRegFisP1=CancelarRegFisP1
CancelarRegFisP1=GuardarRegFisP2
GuardarRegFisP2=CancelarRegFisP2
CancelarRegFisP2=(Fin)


[Acciones.SucRegionGuarda.ListaAccionesMultiples]
(Inicio)=GuardaSucRegion
GuardaSucRegion=PagGuardarSucRegionP1
PagGuardarSucRegionP1=(Fin)

[Acciones.SucRegionGuardaP2.ListaAccionesMultiples]
(Inicio)=GuardaSucRegionP2
GuardaSucRegionP2=PagGuardarSucRegionP2
PagGuardarSucRegionP2=(Fin)

[SucursalRegion.ListaAccionesBB]
(Inicio)=SucRegionNueva
SucRegionNueva=SucRegionGuarda
SucRegionGuarda=SucRegionElimina
SucRegionElimina=SucRegionCancela
SucRegionCancela=SucRegionGuardaP2
SucRegionGuardaP2=SucRegionCancelaP2
SucRegionCancelaP2=(Fin)




[Acciones.GuardaGpoSuc.ListaAccionesMultiples]
(Inicio)=GuardaGrupoSuc
GuardaGrupoSuc=PaginaGuardaGpoSuc
PaginaGuardaGpoSuc=(Fin)




[Acciones.GuardaGpoSucP2.GuardaGrupoSuc2]
Nombre=GuardaGrupoSuc2
Boton=0
Carpeta=SucursalGrupo
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar




[Acciones.GuardaGpoSucP2.ListaAccionesMultiples]
(Inicio)=GuardaGrupoSuc2
GuardaGrupoSuc2=PaginaGuardaGpoSucP2
PaginaGuardaGpoSucP2=(Fin)

[SucursalGrupo.ListaAccionesBB]
(Inicio)=NuevoGrupoSucursal
NuevoGrupoSucursal=GuardaGpoSuc
GuardaGpoSuc=EliminaGpoSuc
EliminaGpoSuc=CancelaGpoSuc
CancelaGpoSuc=GuardaGpoSucP2
GuardaGpoSucP2=CancelarGpoSucP2
CancelarGpoSucP2=(Fin)








[Acciones.GuardaAlmGpo.GuardaAlmGpoP1]
Nombre=GuardaAlmGpoP1
Boton=0
Carpeta=AlmGrupo
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

[Acciones.GuardaAlmGpo.ExpresionGuardaAlmGpoP1]
Nombre=ExpresionGuardaAlmGpoP1
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsAlmGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsAlmGrupo<T>)
Activo=S
Visible=S


[Acciones.GuardaAlmGpoP2.GuardaAlmGpoP2]
Nombre=GuardaAlmGpoP2
Boton=0
Carpeta=AlmGrupo
TipoAccion=Controles Captura
ClaveAccion=Carpeta Registro Guardar
Activo=S
Visible=S

[Acciones.GuardaAlmGpoP2.ExpGuardaAlmGpoP2]
Nombre=ExpGuardaAlmGpoP2
Boton=0
TipoAccion=Expresion
Expresion=Forma.ActualizarVista(<T>BtnsAlmGrupo<T>)<BR>Forma.IrCarpeta(<T>BtnsAlmGrupo<T>)
Activo=S
Visible=S



[Acciones.GuardaSucTipo1.ListaAccionesMultiples]
(Inicio)=SucTipoGuarda2
SucTipoGuarda2=SucTipoGuarda2Pag
SucTipoGuarda2Pag=(Fin)

[Acciones.GuardaSucTipo2.ListaAccionesMultiples]
(Inicio)=SucTipoGuardar2
SucTipoGuardar2=SucTipoGuardar2Pag
SucTipoGuardar2Pag=(Fin)


[Acciones.GuardaSucCategoria.ListaAccionesMultiples]
(Inicio)=SucCategoriaGuarda
SucCategoriaGuarda=SucCategoriaGuardaPag
SucCategoriaGuardaPag=(Fin)

[Acciones.GuardaSucCategoria2.ListaAccionesMultiples]
(Inicio)=SucCategoriaGuarda2
SucCategoriaGuarda2=SucCategoriaGuardaPag
SucCategoriaGuardaPag=(Fin)

[SucursalCat.ListaAccionesBB]
(Inicio)=NvaSucCategoria
NvaSucCategoria=GuardaSucCategoria
GuardaSucCategoria=EliminarSucCategoria
EliminarSucCategoria=CancelaSucCategoria
CancelaSucCategoria=GuardaSucCategoria2
GuardaSucCategoria2=CancelaSucCategoria2
CancelaSucCategoria2=(Fin)

[Acciones.GuardaAlmGpo.ListaAccionesMultiples]
(Inicio)=GuardaAlmGpoP1
GuardaAlmGpoP1=ExpresionGuardaAlmGpoP1
ExpresionGuardaAlmGpoP1=(Fin)

[Acciones.GuardaAlmGpoP2.ListaAccionesMultiples]
(Inicio)=GuardaAlmGpoP2
GuardaAlmGpoP2=ExpGuardaAlmGpoP2
ExpGuardaAlmGpoP2=(Fin)

[AlmGrupo.ListaAccionesBB]
(Inicio)=NvoAlmGpo
NvoAlmGpo=GuardaAlmGpo
GuardaAlmGpo=EliminaAlmGpo
EliminaAlmGpo=CancelaAlmGpo
CancelaAlmGpo=GuardaAlmGpoP2
GuardaAlmGpoP2=CancelaAlmGpoP2
CancelaAlmGpoP2=(Fin)

[Acciones.GuardarZonaP1.ListaAccionesMultiples]
(Inicio)=GuardaZona
GuardaZona=ExpresionZona
ExpresionZona=(Fin)

[Acciones.GuardarZonaP2.ListaAccionesMultiples]
(Inicio)=ZonaGuardaP2
ZonaGuardaP2=RegresaBtnsZona
RegresaBtnsZona=(Fin)

[EmpresaZonas.ListaAccionesBB]
(Inicio)=GuardarZonaP1
GuardarZonaP1=CancelarZonaP1
CancelarZonaP1=NuevaZonaP2
NuevaZonaP2=GuardarZonaP2
GuardarZonaP2=BorraZonaP2
BorraZonaP2=CancelarZonaP2
CancelarZonaP2=(Fin)

[Acciones.GuardarGpoP1.ListaAccionesMultiples]
(Inicio)=GuardarGrupo
GuardarGrupo=RegresaBtns
RegresaBtns=(Fin)

[Acciones.GuardarGpoP2.ListaAccionesMultiples]
(Inicio)=GpoGuardar2
GpoGuardar2=Actualizar2
Actualizar2=(Fin)

[Acciones.GuardarGpoP3.ListaAccionesMultiples]
(Inicio)=GpoGuardar3
GpoGuardar3=IrPagina3
IrPagina3=(Fin)



[Acciones.GuardarOrgP1.ListaAccionesMultiples]
(Inicio)=OrgGuardarP1
OrgGuardarP1=RegresaBtnsOrgP1
RegresaBtnsOrgP1=(Fin)

[Acciones.GuardarOrgP2.ListaAccionesMultiples]
(Inicio)=OrgGuardarP2
OrgGuardarP2=RegresaBtnsOrgP2
RegresaBtnsOrgP2=(Fin)

[EmpresaOrganizaciones.ListaEnCaptura]
(Inicio)=Organizacion.Organizacion
Organizacion.Organizacion=Organizacion.Nombre
Organizacion.Nombre=Organizacion.Descripcion
Organizacion.Descripcion=(Fin)

[EmpresaOrganizaciones.ListaAccionesBB]
(Inicio)=NvaOrgP1
NvaOrgP1=GuardarOrgP1
GuardarOrgP1=EliminarOrgP1
EliminarOrgP1=CancelarOrgP1
CancelarOrgP1=GuardarOrgP2
GuardarOrgP2=CancelarOrgP2
CancelarOrgP2=(Fin)




[Acciones.NvoAlmacen.ListaAccionesMultiples]
(Inicio)=NvoRegAlm
NvoRegAlm=IrCarpetaAlm
IrCarpetaAlm=(Fin)

[Acciones.EmpresaGuardar.ListaAccionesMultiples]
(Inicio)=EmpresaGuardaEmp
EmpresaGuardaEmp=EmpresaCambiaVista
EmpresaCambiaVista=(Fin)

[Empresa.ListaEnCaptura]
(Inicio)=Empresa.Empresa
Empresa.Empresa=Empresa.Nombre
Empresa.Nombre=Empresa.Direccion
Empresa.Direccion=Empresa.DireccionNumero
Empresa.DireccionNumero=Empresa.DireccionNumeroInt
Empresa.DireccionNumeroInt=Empresa.Colonia
Empresa.Colonia=Empresa.CodigoPostal
Empresa.CodigoPostal=Empresa.Delegacion
Empresa.Delegacion=Empresa.Poblacion
Empresa.Poblacion=Empresa.Estado
Empresa.Estado=Empresa.Pais
Empresa.Pais=Empresa.Telefonos
Empresa.Telefonos=Empresa.Fax
Empresa.Fax=Empresa.RFC
Empresa.RFC=Empresa.RegistroPatronal
Empresa.RegistroPatronal=Empresa.ClaveActividad
Empresa.ClaveActividad=Empresa.FiscalRegimen
Empresa.FiscalRegimen=Empresa.FiscalZona
Empresa.FiscalZona=Empresa.Representante
Empresa.Representante=Empresa.RepresentanteRFC
Empresa.RepresentanteRFC=Empresa.RepresentanteCURP
Empresa.RepresentanteCURP=Empresa.ImportadorRegimen
Empresa.ImportadorRegimen=Empresa.ImportadorFechaD
Empresa.ImportadorFechaD=Empresa.ImportadorFechaA
Empresa.ImportadorFechaA=Empresa.ImportadorRegistro
Empresa.ImportadorRegistro=Empresa.FactorIntegracion
Empresa.FactorIntegracion=Empresa.Estatus
Empresa.Estatus=Empresa.CFD
Empresa.CFD=Empresa.Configuracion
Empresa.Configuracion=Empresa.EmpresaLDI
Empresa.EmpresaLDI=Empresa.Controladora
Empresa.Controladora=Controladora.Nombre
Controladora.Nombre=Empresa.Grupo
Empresa.Grupo=Empresa.Zona
Empresa.Zona=(Fin)

[Empresa.ListaAccionesBB]
(Inicio)=EmpresaGuardar
EmpresaGuardar=EmpresaCancelar
EmpresaCancelar=EmpresaNuevo
EmpresaNuevo=Separador
Separador=EmpresaGrupos
EmpresaGrupos=EmpresaZonas
EmpresaZonas=EmpresaOrganizaciones
EmpresaOrganizaciones=RegimenFiscal
RegimenFiscal=(Fin)


[Acciones.MnBtnEmpresas.ListaAccionesMultiples]
(Inicio)=VerEmpresa
VerEmpresa=VerMargen
VerMargen=(Fin)

[MenuGral.ListaAccionesBB]
(Inicio)=MnBtnEmpresas
MnBtnEmpresas=MnBtnSucursales
MnBtnSucursales=MnBtnAlmacen
MnBtnAlmacen=(Fin)





[EmpresaGrupos.ListaEnCaptura]
(Inicio)=EmpresaGrupo.Grupo
EmpresaGrupo.Grupo=EmpresaGrupo.Clave
EmpresaGrupo.Clave=(Fin)

[EmpresaGrupos.ListaAccionesBB]
(Inicio)=GuardarGpoP1
GuardarGpoP1=CancelarGpoP1
CancelarGpoP1=NuevoGrupoP2
NuevoGrupoP2=GuardarGpoP2
GuardarGpoP2=EliminarGpoP2
EliminarGpoP2=CancelarGpoP2
CancelarGpoP2=GuardarGpoP3
GuardarGpoP3=CancelarGpoP3
CancelarGpoP3=(Fin)

[Acciones.AlmacenGuardar.ListaAccionesMultiples]
(Inicio)=GuardarAlmacen
GuardarAlmacen=ActualizaCarpeta
ActualizaCarpeta=(Fin)

[Almacenes.ListaEnCaptura]
(Inicio)=Alm.Almacen
Alm.Almacen=Alm.Tipo
Alm.Tipo=Alm.Nombre
Alm.Nombre=Alm.Rama
Alm.Rama=AlmLista.Nombre
AlmLista.Nombre=Alm.Sucursal
Alm.Sucursal=Sucursal.Nombre
Sucursal.Nombre=Alm.Ruta
Alm.Ruta=Alm.Grupo
Alm.Grupo=Alm.Exclusivo
Alm.Exclusivo=Alm.Estatus
Alm.Estatus=Alm.Direccion
Alm.Direccion=Alm.DireccionNumero
Alm.DireccionNumero=Alm.DireccionNumeroInt
Alm.DireccionNumeroInt=Alm.Colonia
Alm.Colonia=Alm.Delegacion
Alm.Delegacion=Alm.Poblacion
Alm.Poblacion=Alm.Estado
Alm.Estado=Alm.Pais
Alm.Pais=Alm.CodigoPostal
Alm.CodigoPostal=Alm.wMostrar
Alm.wMostrar=Alm.wUnicamenteDisponibles
Alm.wUnicamenteDisponibles=Alm.ExcluirPlaneacion
Alm.ExcluirPlaneacion=Alm.CEDIS
Alm.CEDIS=Alm.Segundas
Alm.Segundas=Alm.CompraDirecta
Alm.CompraDirecta=(Fin)

[Almacenes.ListaAccionesBB]
(Inicio)=AlmacenGuardar
AlmacenGuardar=AlmacenCancelar
AlmacenCancelar=AlmacenNuevo
AlmacenNuevo=SeparadorAlmacen
SeparadorAlmacen=AlmGrupo
AlmGrupo=(Fin)






[Acciones.NvaEmpresa.ListaAccionesMultiples]
(Inicio)=LimpiaCarpetaEmpresa
LimpiaCarpetaEmpresa=IrCarpetaEmpresa
IrCarpetaEmpresa=(Fin)








[Acciones.EliminaSucTipo1.ListaAccionesMultiples]
(Inicio)=SucTipoElimina
SucTipoElimina=SucTipoEliminaPag
SucTipoEliminaPag=(Fin)


[Acciones.CancelaSucTipo2.ListaAccionesMultiples]
(Inicio)=SucTipoCancela2
SucTipoCancela2=SucTipoCancela2Pag
SucTipoCancela2Pag=(Fin)

[Acciones.CancelaSucTipo.ListaAccionesMultiples]
(Inicio)=SucTipoCancela1
SucTipoCancela1=SucTipoCancela1Pag
SucTipoCancela1Pag=(Fin)

[SucursalTipo.ListaAccionesBB]
(Inicio)=NvoSucTipo1
NvoSucTipo1=GuardaSucTipo1
GuardaSucTipo1=EliminaSucTipo1
EliminaSucTipo1=CancelaSucTipo
CancelaSucTipo=GuardaSucTipo2
GuardaSucTipo2=CancelaSucTipo2
CancelaSucTipo2=(Fin)









[Forma.ListaCarpetas]
(Inicio)=MenuGral
MenuGral=BtnsEmpresa
BtnsEmpresa=Empresa
Empresa=BtnsSucursales
BtnsSucursales=Sucursales
Sucursales=BtnsAlmacenes
BtnsAlmacenes=Almacenes
Almacenes=EmpresaOrganizaciones
EmpresaOrganizaciones=EmpresaGrupos
EmpresaGrupos=BtnsEmpresaGrupos
BtnsEmpresaGrupos=EmpresaZonas
EmpresaZonas=BtnsEmpresaZonas
BtnsEmpresaZonas=BtnsEmpresaOrganizaciones
BtnsEmpresaOrganizaciones=EmpresaRegimenesFiscales
EmpresaRegimenesFiscales=BtnsEmpresaRegimenFis
BtnsEmpresaRegimenFis=SucursalRegion
SucursalRegion=BtnsSucursalRegion
BtnsSucursalRegion=BtnsSucursalGrupo
BtnsSucursalGrupo=BtnsSucursalCat
BtnsSucursalCat=BtnsSucursalTipo
BtnsSucursalTipo=SucursalGrupo
SucursalGrupo=SucursalCat
SucursalCat=SucursalTipo
SucursalTipo=BtnsAlmGrupo
BtnsAlmGrupo=AlmGrupo
AlmGrupo=Margen
Margen=(Fin)
