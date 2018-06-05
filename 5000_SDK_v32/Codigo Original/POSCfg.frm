
[Forma]
Clave=POSCfg
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración POS
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Campos
PosicionInicialAlturaCliente=657
PosicionInicialAncho=994
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=271
PosicionInicialArriba=69
ListaAcciones=(Lista)
Comentarios=Empresa.Empresa
VentanaColor=Plata
[Campos]
Estilo=Ficha
Clave=Campos
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCfg
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

Pestana=S
PestanaOtroNombre=S
PestanaNombre=General
FiltroGeneral=POSCFG.Empresa = <T>{Empresa}<T>
[Campos.POSCFG.ImagenNombreAnexo]
Carpeta=Campos
Clave=POSCFG.ImagenNombreAnexo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

[Campos.POSCFG.AgruparArticulos]
Carpeta=Campos
Clave=POSCFG.AgruparArticulos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Campos.POSCFG.CantidadNotasEnProceso]
Carpeta=Campos
Clave=POSCFG.CantidadNotasEnProceso
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=S


[Campos.POSCFG.DefFormaPagoCambio]
Carpeta=Campos
Clave=POSCFG.DefFormaPagoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
ColorFondo=Blanco





[Campos.POSCFG.ValidarDevolucion]
Carpeta=Campos
Clave=POSCFG.ValidarDevolucion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco




EspacioPrevio=S
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Campos.POSCFG.RedondeoVenta]
Carpeta=Campos
Clave=POSCFG.RedondeoVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
ColorFondo=Blanco




[Campos.POSCFG.RedondeosMonetarios]
Carpeta=Campos
Clave=POSCFG.RedondeosMonetarios
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20

LineaNueva=N
EspacioPrevio=S
[Campos.POSCFG.JuegoComponentes]
Carpeta=Campos
Clave=POSCFG.JuegoComponentes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Campos.POSCFG.CajaOmision]
Carpeta=Campos
Clave=POSCFG.CajaOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Campos.POSCFG.PuertoTorreta]
Carpeta=Campos
Clave=POSCFG.PuertoTorreta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Campos.POSCFG.TieneTorreta]
Carpeta=Campos
Clave=POSCFG.TieneTorreta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Campos.POSCFG.Publicidad]
Carpeta=Campos
Clave=POSCFG.Publicidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=75
ColorFondo=Blanco





[Acciones.POSSucursal]
Nombre=POSSucursal
Boton=16
NombreEnBoton=S
NombreDesplegar=&Sucursales
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSSucursal
Activo=S
Visible=S



EspacioPrevio=S












[Monedero]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Monedero
Clave=Monedero
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PosCfg
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=POSCFG.Empresa = <T>{Empresa}<T>
CondicionVisible=POSCfg:POSCFG.Monedero y (no Info.MonederoCB)
[Monedero.POSCFG.TipoMonedero]
Carpeta=Monedero
Clave=POSCFG.TipoMonedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Monedero.POSCFG.MonederoLDI]
Carpeta=Monedero
Clave=POSCFG.MonederoLDI
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco




Tamano=50

[Monedero.POSCFG.MovEmision]
Carpeta=Monedero
Clave=POSCFG.MovEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Monedero.POSCFG.MovCancelacion]
Carpeta=Monedero
Clave=POSCFG.MovCancelacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Campos.POSCFG.ImpuestoIncluido]
Carpeta=Campos
Clave=POSCFG.ImpuestoIncluido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Campos.POSCFG.ArtOfertaFP]
Carpeta=Campos
Clave=POSCFG.ArtOfertaFP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Blanco



[Lista.Columnas]
Articulo=131
Descripcion1=244














0=181
1=111
2=-2
[Campos.POSCFG.MatrizOpciones]
Carpeta=Campos
Clave=POSCFG.MatrizOpciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco













[Campos.POSCFG.MovFactura]
Carpeta=Campos
Clave=POSCFG.MovFactura
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




















LineaNueva=S
[Campos.POSCFG.MovSustitutos]
Carpeta=Campos
Clave=POSCFG.MovSustitutos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco














[Monedero.POSCFG.ConsecutivoMonedero]
Carpeta=Monedero
Clave=POSCFG.ConsecutivoMonedero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco














[Campos.POSCFG.ArtOfertaImporte]
Carpeta=Campos
Clave=POSCFG.ArtOfertaImporte
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
















[Web Service.ListaEnCaptura]
(Inicio)=POSCFG.WSServidorSQL
POSCFG.WSServidorSQL=POSCFG.WSPuertoSQL
POSCFG.WSPuertoSQL=POSCFG.WSUsuarioSQL
POSCFG.WSUsuarioSQL=POSCFG.WSContrasenaSQL
POSCFG.WSContrasenaSQL=POSCFG.WSUbicacion
POSCFG.WSUbicacion=(Fin)







[Campos.POSCFG.WebService]
Carpeta=Campos
Clave=POSCFG.WebService
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[WebService]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Web Service
Clave=WebService
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCfg
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


PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSCFG.Empresa = <T>{Empresa}<T>
CondicionVisible=POSCfg:POSCFG.WebService
[WebService.POSCFG.WSServidorSQL]
Carpeta=WebService
Clave=POSCFG.WSServidorSQL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[WebService.POSCFG.WSPuertoSQL]
Carpeta=WebService
Clave=POSCFG.WSPuertoSQL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[WebService.POSCFG.WSUsuarioSQL]
Carpeta=WebService
Clave=POSCFG.WSUsuarioSQL
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Pegado=S
[WebService.POSCFG.WSContrasenaSQL]
Carpeta=WebService
Clave=POSCFG.WSContrasenaSQL
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Pegado=S
[WebService.POSCFG.WSUbicacion]
Carpeta=WebService
Clave=POSCFG.WSUbicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco













[WebService.POSCFG.WSBaseDatos]
Carpeta=WebService
Clave=POSCFG.WSBaseDatos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
































[Campos.POSCFG.DesgloseCC]
Carpeta=Campos
Clave=POSCFG.DesgloseCC
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco

Tamano=50









[Campos.POSCFG.RefPedidoSinWS]
Carpeta=Campos
Clave=POSCFG.RefPedidoSinWS
Editar=S
3D=S
ColorFondo=Blanco

ValidaNombre=S








[CodigoExtendido]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Código Extendido
Clave=CodigoExtendido
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCfg
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
CarpetaVisible=S

ListaEnCaptura=(Lista)

[CodigoExtendido.POSCFG.CodigoExtendido]
Carpeta=CodigoExtendido
Clave=POSCFG.CodigoExtendido
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=30
[CodigoExtendido.POSCFG.CodigoExtendidoLetraCodigo]
Carpeta=CodigoExtendido
Clave=POSCFG.CodigoExtendidoLetraCodigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[CodigoExtendido.POSCFG.CodigoExtendidoLetraPeso]
Carpeta=CodigoExtendido
Clave=POSCFG.CodigoExtendidoLetraPeso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[CodigoExtendido.POSCFG.CodigoExtendidoDecimalesPeso]
Carpeta=CodigoExtendido
Clave=POSCFG.CodigoExtendidoDecimalesPeso
Editar=S
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco

[CodigoExtendido.POSCFG.CodigoExtendidoMascara]
Carpeta=CodigoExtendido
Clave=POSCFG.CodigoExtendidoMascara
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=38
ColorFondo=Blanco

















[Campos.POSCFG.CondicionPedidoContado]
Carpeta=Campos
Clave=POSCFG.CondicionPedidoContado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco















[CodigoExtendido.ListaEnCaptura]
(Inicio)=POSCFG.CodigoExtendido
POSCFG.CodigoExtendido=POSCFG.CodigoExtendidoLetraCodigo
POSCFG.CodigoExtendidoLetraCodigo=POSCFG.CodigoExtendidoLetraPeso
POSCFG.CodigoExtendidoLetraPeso=POSCFG.CodigoExtendidoDecimalesPeso
POSCFG.CodigoExtendidoDecimalesPeso=POSCFG.CodigoExtendidoMascara
POSCFG.CodigoExtendidoMascara=(Fin)












































































[Campos.POSCFG.FormaPagoSaldoAFavor]
Carpeta=Campos
Clave=POSCFG.FormaPagoSaldoAFavor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco




















[Monedero.POSCFG.MovTraspasoVale]
Carpeta=Monedero
Clave=POSCFG.MovTraspasoVale
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




























[Campos.POSCFG.CfgCierreDia]
Carpeta=Campos
Clave=POSCFG.CfgCierreDia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[CierreDia]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Cierre Dia
Clave=CierreDia
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCfg
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


CondicionVisible=POSCfg:POSCFG.CfgCierreDia
[CierreDia.POSCFG.ValidarCajasCerradas]
Carpeta=CierreDia
Clave=POSCFG.ValidarCajasCerradas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20

[CierreDia.POSCFG.HoraCierreDia]
Carpeta=CierreDia
Clave=POSCFG.HoraCierreDia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[CierreDia.POSCFG.SugerirFechaCierre]
Carpeta=CierreDia
Clave=POSCFG.SugerirFechaCierre
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[CierreDia.POSCFG.DiasHabiles]
Carpeta=CierreDia
Clave=POSCFG.DiasHabiles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco














[Campos.POSCFG.CierreiSyncNivel]
Carpeta=Campos
Clave=POSCFG.CierreiSyncNivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Campos.POSCFG.POSDiasDev]
Carpeta=Campos
Clave=POSCFG.POSDiasDev
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










LineaNueva=S
[Campos.POSCFG.POSDefMovServ]
Carpeta=Campos
Clave=POSCFG.POSDefMovServ
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

LineaNueva=S






[Campos.POSCFG.POSMonedaAct]
Carpeta=Campos
Clave=POSCFG.POSMonedaAct
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Campos.POSCFG.POSDefMovDev]
Carpeta=Campos
Clave=POSCFG.POSDefMovDev
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


































[Campos.POSCFG.POSAgenteDetalle]
Carpeta=Campos
Clave=POSCFG.POSAgenteDetalle
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



Pegado=N






LineaNueva=N
[Campos.POSCFG.POSDutyFree]
Carpeta=Campos
Clave=POSCFG.POSDutyFree
Editar=S
ValidaNombre=S
3D=S
Pegado=N
ColorFondo=Blanco







LineaNueva=S

[Otros]
Estilo=Ficha
Pestana=S
Clave=Otros
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSCfg
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
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Otros
ListaEnCaptura=(Lista)


PermiteEditar=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSCFG.Empresa = <T>{Empresa}<T>
[Otros.POSCFG.AutoAjuste]
Carpeta=Otros
Clave=POSCFG.AutoAjuste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
[Otros.POSCFG.VenderSinExistencia]
Carpeta=Otros
Clave=POSCFG.VenderSinExistencia
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Otros.POSCFG.AutoAjusteUsuario]
Carpeta=Otros
Clave=POSCFG.AutoAjusteUsuario
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

LineaNueva=S
[Otros.POSCFG.AutoAjusteConcepto]
Carpeta=Otros
Clave=POSCFG.AutoAjusteConcepto
Editar=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco











[Campos.POSCFG.ActivaBascula]
Carpeta=Campos
Clave=POSCFG.ActivaBascula
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








































[Campos.POSCFG.PanelAMostrar]
Carpeta=Campos
Clave=POSCFG.PanelAMostrar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


























































































[Otros.POSCFG.MensajeLimiteCajaT]
Carpeta=Otros
Clave=POSCFG.MensajeLimiteCajaT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco



EspacioPrevio=S



[Campos.POSCFG.POSAgenteDetMaestro]
Carpeta=Campos
Clave=POSCFG.POSAgenteDetMaestro
Editar=S
3D=S
Tamano=15
ColorFondo=Blanco












ValidaNombre=S
[Redondeo]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Redondeo
Clave=Redondeo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
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
PermiteEditar=S
Vista=POSCfg
ListaEnCaptura=POSCFG.RedondeoVentaCodigo

Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=POSCFG.Empresa = <T>{Empresa}<T>
CondicionVisible=POSCfg:POSCFG.RedondeoVenta
[Redondeo.POSCFG.RedondeoVentaCodigo]
Carpeta=Redondeo
Clave=POSCFG.RedondeoVentaCodigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco




[WebService.ListaEnCaptura]
(Inicio)=POSCFG.WSServidorSQL
POSCFG.WSServidorSQL=POSCFG.WSPuertoSQL
POSCFG.WSPuertoSQL=POSCFG.WSUsuarioSQL
POSCFG.WSUsuarioSQL=POSCFG.WSContrasenaSQL
POSCFG.WSContrasenaSQL=POSCFG.WSBaseDatos
POSCFG.WSBaseDatos=POSCFG.WSUbicacion
POSCFG.WSUbicacion=(Fin)

[CierreDia.ListaEnCaptura]
(Inicio)=POSCFG.HoraCierreDia
POSCFG.HoraCierreDia=POSCFG.DiasHabiles
POSCFG.DiasHabiles=POSCFG.ValidarCajasCerradas
POSCFG.ValidarCajasCerradas=POSCFG.SugerirFechaCierre
POSCFG.SugerirFechaCierre=(Fin)






[Campos.POSCFG.MultiMoneda]
Carpeta=Campos
Clave=POSCFG.MultiMoneda
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Otros.POSCFG.POSSeriesLotesAutoOrden]
Carpeta=Otros
Clave=POSCFG.POSSeriesLotesAutoOrden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco






























[Campos.POSCFG.Monedero]
Carpeta=Campos
Clave=POSCFG.Monedero
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Otros.POSCFG.SinAutorizarEditarEncabezado]
Carpeta=Otros
Clave=POSCFG.SinAutorizarEditarEncabezado
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

EspacioPrevio=N
Tamano=40
[Otros.POSCFG.SinAutorizarEditarDetalle]
Carpeta=Otros
Clave=POSCFG.SinAutorizarEditarDetalle
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco









Tamano=40






[Otros.POSCFG.POSUsuarioAutoriza]
Carpeta=Otros
Clave=POSCFG.POSUsuarioAutoriza
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco



[POSUsuarioAccion.Columnas]
Accion=736

[POSUsuarioMov.Columnas]
Mov=658
PuedeAutorizar=81

[(Carpeta Abrir).Columnas]
0=98
1=378
2=-2
















[Otros.POSCFG.SinAutorizarReferenciaOrigen]
Carpeta=Otros
Clave=POSCFG.SinAutorizarReferenciaOrigen
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarCancelarPartida]
Carpeta=Otros
Clave=POSCFG.SinAutorizarCancelarPartida
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarEliminarCaptura]
Carpeta=Otros
Clave=POSCFG.SinAutorizarEliminarCaptura
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40






[Otros.POSCFG.SinAutorizarListaMov]
Carpeta=Otros
Clave=POSCFG.SinAutorizarListaMov
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarReversarPago]
Carpeta=Otros
Clave=POSCFG.SinAutorizarReversarPago
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarConsultaInv]
Carpeta=Otros
Clave=POSCFG.SinAutorizarConsultaInv
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarFacturaAnticipo]
Carpeta=Otros
Clave=POSCFG.SinAutorizarFacturaAnticipo
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarFacturaCredito]
Carpeta=Otros
Clave=POSCFG.SinAutorizarFacturaCredito
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarCobroCredito]
Carpeta=Otros
Clave=POSCFG.SinAutorizarCobroCredito
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarDevolucion]
Carpeta=Otros
Clave=POSCFG.SinAutorizarDevolucion
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarDevolucionParcial]
Carpeta=Otros
Clave=POSCFG.SinAutorizarDevolucionParcial
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarFormaEnvio]
Carpeta=Otros
Clave=POSCFG.SinAutorizarFormaEnvio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarLlamarPedidos]
Carpeta=Otros
Clave=POSCFG.SinAutorizarLlamarPedidos
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarDatosCliente]
Carpeta=Otros
Clave=POSCFG.SinAutorizarDatosCliente
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarAgregarCliente]
Carpeta=Otros
Clave=POSCFG.SinAutorizarAgregarCliente
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarVerValores]
Carpeta=Otros
Clave=POSCFG.SinAutorizarVerValores
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarAperturaCaja]
Carpeta=Otros
Clave=POSCFG.SinAutorizarAperturaCaja
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarAumentoCaja]
Carpeta=Otros
Clave=POSCFG.SinAutorizarAumentoCaja
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarCorteParcial]
Carpeta=Otros
Clave=POSCFG.SinAutorizarCorteParcial
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarCorteCaja]
Carpeta=Otros
Clave=POSCFG.SinAutorizarCorteCaja
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarEgreso]
Carpeta=Otros
Clave=POSCFG.SinAutorizarEgreso
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarIngreso]
Carpeta=Otros
Clave=POSCFG.SinAutorizarIngreso
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarAperturaCajaMM]
Carpeta=Otros
Clave=POSCFG.SinAutorizarAperturaCajaMM
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarCorteParcialMM]
Carpeta=Otros
Clave=POSCFG.SinAutorizarCorteParcialMM
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarCorteCajaMM]
Carpeta=Otros
Clave=POSCFG.SinAutorizarCorteCajaMM
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40
[Otros.POSCFG.SinAutorizarRecoleccionMM]
Carpeta=Otros
Clave=POSCFG.SinAutorizarRecoleccionMM
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco





Tamano=40
[Redondeo.ListaEnCaptura]
(Inicio)=POSCFG.RedondeoVentaCodigo
POSCFG.RedondeoVentaCodigo=POSCFG.RedondeoVentaMov
POSCFG.RedondeoVentaMov=POSCFG.RedondeoVentaProv
POSCFG.RedondeoVentaProv=RedondeoVentaProvNombre
RedondeoVentaProvNombre=POSCFG.RedondeoVentaConcepto
POSCFG.RedondeoVentaConcepto=POSCFG.RedondeoVentaCtaDinero
POSCFG.RedondeoVentaCtaDinero=POSCFG.RedondeoVentaCondicion
POSCFG.RedondeoVentaCondicion=POSCFG.CodigoArtComision
POSCFG.CodigoArtComision=(Fin)











[Otros.POSCFG.SinAutorizarLlamarAnticipo]
Carpeta=Otros
Clave=POSCFG.SinAutorizarLlamarAnticipo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40



[Campos.POSCFG.GenerarEmbarques]
Carpeta=Campos
Clave=POSCFG.GenerarEmbarques
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
Pegado=N
[Campos.POSCFG.POSDefMovEmbarque]
Carpeta=Campos
Clave=POSCFG.POSDefMovEmbarque
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco




Pegado=S








[Otros.ListaEnCaptura]
(Inicio)=POSCFG.POSSeriesLotesAutoOrden
POSCFG.POSSeriesLotesAutoOrden=POSCFG.AutoAjuste
POSCFG.AutoAjuste=POSCFG.VenderSinExistencia
POSCFG.VenderSinExistencia=POSCFG.AutoAjusteUsuario
POSCFG.AutoAjusteUsuario=POSCFG.AutoAjusteConcepto
POSCFG.AutoAjusteConcepto=POSCFG.MensajeLimiteCajaT
POSCFG.MensajeLimiteCajaT=POSCFG.POSUsuarioAutoriza
POSCFG.POSUsuarioAutoriza=POSCFG.SinAutorizarEditarEncabezado
POSCFG.SinAutorizarEditarEncabezado=POSCFG.SinAutorizarEditarDetalle
POSCFG.SinAutorizarEditarDetalle=POSCFG.SinAutorizarReferenciaOrigen
POSCFG.SinAutorizarReferenciaOrigen=POSCFG.SinAutorizarCancelarPartida
POSCFG.SinAutorizarCancelarPartida=POSCFG.SinAutorizarEliminarCaptura
POSCFG.SinAutorizarEliminarCaptura=POSCFG.SinAutorizarListaMov
POSCFG.SinAutorizarListaMov=POSCFG.SinAutorizarReversarPago
POSCFG.SinAutorizarReversarPago=POSCFG.SinAutorizarConsultaInv
POSCFG.SinAutorizarConsultaInv=POSCFG.SinAutorizarFacturaAnticipo
POSCFG.SinAutorizarFacturaAnticipo=POSCFG.SinAutorizarFacturaCredito
POSCFG.SinAutorizarFacturaCredito=POSCFG.SinAutorizarCobroCredito
POSCFG.SinAutorizarCobroCredito=POSCFG.SinAutorizarDevolucion
POSCFG.SinAutorizarDevolucion=POSCFG.SinAutorizarDevolucionParcial
POSCFG.SinAutorizarDevolucionParcial=POSCFG.SinAutorizarFormaEnvio
POSCFG.SinAutorizarFormaEnvio=POSCFG.SinAutorizarLlamarPedidos
POSCFG.SinAutorizarLlamarPedidos=POSCFG.SinAutorizarLlamarAnticipo
POSCFG.SinAutorizarLlamarAnticipo=POSCFG.SinAutorizarDatosCliente
POSCFG.SinAutorizarDatosCliente=POSCFG.SinAutorizarAgregarCliente
POSCFG.SinAutorizarAgregarCliente=POSCFG.SinAutorizarVerValores
POSCFG.SinAutorizarVerValores=POSCFG.SinAutorizarAperturaCaja
POSCFG.SinAutorizarAperturaCaja=POSCFG.SinAutorizarAumentoCaja
POSCFG.SinAutorizarAumentoCaja=POSCFG.SinAutorizarCorteParcial
POSCFG.SinAutorizarCorteParcial=POSCFG.SinAutorizarCorteCaja
POSCFG.SinAutorizarCorteCaja=POSCFG.SinAutorizarEgreso
POSCFG.SinAutorizarEgreso=POSCFG.SinAutorizarIngreso
POSCFG.SinAutorizarIngreso=POSCFG.SinAutorizarAperturaCajaMM
POSCFG.SinAutorizarAperturaCajaMM=POSCFG.SinAutorizarCorteParcialMM
POSCFG.SinAutorizarCorteParcialMM=POSCFG.SinAutorizarCorteCajaMM
POSCFG.SinAutorizarCorteCajaMM=POSCFG.SinAutorizarRecoleccionMM
POSCFG.SinAutorizarRecoleccionMM=(Fin)




[Campos.ListaEnCaptura]
(Inicio)=POSCFG.ImagenNombreAnexo
POSCFG.ImagenNombreAnexo=POSCFG.AgruparArticulos
POSCFG.AgruparArticulos=POSCFG.CantidadNotasEnProceso
POSCFG.CantidadNotasEnProceso=POSCFG.DefFormaPagoCambio
POSCFG.DefFormaPagoCambio=POSCFG.GenerarEmbarques
POSCFG.GenerarEmbarques=POSCFG.POSDefMovEmbarque
POSCFG.POSDefMovEmbarque=POSCFG.ImpuestoIncluido
POSCFG.ImpuestoIncluido=POSCFG.ValidarDevolucion
POSCFG.ValidarDevolucion=POSCFG.MovFactura
POSCFG.MovFactura=POSCFG.MovSustitutos
POSCFG.MovSustitutos=POSCFG.POSDefMovServ
POSCFG.POSDefMovServ=POSCFG.POSDefMovDev
POSCFG.POSDefMovDev=POSCFG.RedondeoVenta
POSCFG.RedondeoVenta=POSCFG.RedondeosMonetarios
POSCFG.RedondeosMonetarios=POSCFG.POSToleranciaVta
POSCFG.POSToleranciaVta=POSCFG.JuegoComponentes
POSCFG.JuegoComponentes=POSCFG.CajaOmision
POSCFG.CajaOmision=POSCFG.PanelAMostrar
POSCFG.PanelAMostrar=POSCFG.Publicidad
POSCFG.Publicidad=POSCFG.TieneTorreta
POSCFG.TieneTorreta=POSCFG.PuertoTorreta
POSCFG.PuertoTorreta=POSCFG.ArtOfertaFP
POSCFG.ArtOfertaFP=POSCFG.ArtOfertaImporte
POSCFG.ArtOfertaImporte=POSCFG.MatrizOpciones
POSCFG.MatrizOpciones=POSCFG.DesgloseCC
POSCFG.DesgloseCC=POSCFG.RefPedidoSinWS
POSCFG.RefPedidoSinWS=POSCFG.WebService
POSCFG.WebService=POSCFG.CondicionPedidoContado
POSCFG.CondicionPedidoContado=POSCFG.FormaPagoSaldoAFavor
POSCFG.FormaPagoSaldoAFavor=POSCFG.CierreiSyncNivel
POSCFG.CierreiSyncNivel=POSCFG.POSDiasDev
POSCFG.POSDiasDev=POSCFG.POSAgenteDetMaestro
POSCFG.POSAgenteDetMaestro=POSCFG.CfgCierreDia
POSCFG.CfgCierreDia=POSCFG.POSMonedaAct
POSCFG.POSMonedaAct=POSCFG.MultiMoneda
POSCFG.MultiMoneda=POSCFG.Monedero
POSCFG.Monedero=POSCFG.POSDutyFree
POSCFG.POSDutyFree=POSCFG.ActivaBascula
POSCFG.ActivaBascula=POSCFG.POSAgenteDetalle
POSCFG.POSAgenteDetalle=(Fin)

[Campos.POSCFG.POSToleranciaVta]
Carpeta=Campos
Clave=POSCFG.POSToleranciaVta
Editar=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco










[Monedero.ListaEnCaptura]
(Inicio)=POSCFG.TipoMonedero
POSCFG.TipoMonedero=POSCFG.MonederoLDI
POSCFG.MonederoLDI=POSCFG.MovEmision
POSCFG.MovEmision=POSCFG.MovCancelacion
POSCFG.MovCancelacion=POSCFG.MovTraspasoVale
POSCFG.MovTraspasoVale=POSCFG.ConsecutivoMonedero
POSCFG.ConsecutivoMonedero=(Fin)







[Acciones.POSCteFacCred]
Nombre=POSCteFacCred
Boton=0
NombreEnBoton=S
NombreDesplegar=Clientes Exluidos de la Fact Credito
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSCteFacCred
Visible=S

ActivoCondicion=POSCfg:POSCFG.WebService








[Forma.ListaCarpetas]
(Inicio)=Campos
Campos=Redondeo
Redondeo=Monedero
Monedero=CodigoExtendido
CodigoExtendido=WebService
WebService=CierreDia
CierreDia=Otros
Otros=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=POSSucursal
POSSucursal=POSCteFacCred
POSCteFacCred=(Fin)
