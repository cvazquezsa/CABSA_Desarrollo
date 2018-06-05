[Forma]
Clave=ExplorarIVAFiscalConciliado
Nombre=Explorando - IVA Fiscal (Cxc/Cxp) / Movimientos Conciliados
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=49
PosicionInicialArriba=161
PosicionInicialAlturaCliente=412
PosicionInicialAncho=925
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IVAFiscal
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
BusquedaRapidaControles=S
ListaEnCaptura=(Lista)
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=IVAFiscal.FechaConciliacion
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=C&onciliación
FiltroMonedas=S
FiltroMonedasCampo=IVAFiscal.Moneda
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=IVAFiscal.Modulo
FiltroValida1=Modulo.Nombre
FiltroTodo=S
FiltroSucursales=S
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaAncho=20
FiltroGrupo2=IVAFiscal.Mov
FiltroValida2=IVAFiscal.Mov

IconosNombre=IVAFiscal:IVAFiscal.Mov+<T> <T>+IVAFiscal:IVAFiscal.MovID
FiltroGeneral=IVAFiscal.Empresa=<T>{Empresa}<T> <BR>AND IVAFiscal.IVAFiscalImporte<>0 <BR>AND IVAFiscal.FechaEmision>=<T>{FechaFormatoServidor(Config.FiscalInicioIVA)}<T><BR>AND IVAFiscal.Conciliado = 1
[Lista.Columnas]
0=95
1=96

[Lista.IVAFiscal.Contacto]
Carpeta=Lista
Clave=IVAFiscal.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.IVAFiscal.Nombre]
Carpeta=Lista
Clave=IVAFiscal.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Aplicacion]
Carpeta=Lista
Clave=Aplicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Lista.Importe]
Carpeta=Lista
Clave=Importe
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

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

[Lista.IVAFiscal.Referencia]
Carpeta=Lista
Clave=IVAFiscal.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.IVAFiscal.AplicaFecha]
Carpeta=Lista
Clave=IVAFiscal.AplicaFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.IVAFiscal.FechaEmision]
Carpeta=Lista
Clave=IVAFiscal.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.IVAFiscal.AplicaImporte]
Carpeta=Lista
Clave=IVAFiscal.AplicaImporte
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.MovPropiedades]
Nombre=MovPropiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Modulo, IVAFiscal:IVAFiscal.Modulo)<BR>Asigna(Info.ID, IVAFiscal:IVAFiscal.ID)
Visible=S




[Lista.ListaEnCaptura]
(Inicio)=IVAFiscal.AplicaFecha
IVAFiscal.AplicaFecha=IVAFiscal.Contacto
IVAFiscal.Contacto=IVAFiscal.Nombre
IVAFiscal.Nombre=IVAFiscal.Referencia
IVAFiscal.Referencia=Aplicacion
Aplicacion=IVAFiscal.AplicaImporte
IVAFiscal.AplicaImporte=IVAFiscal.FechaEmision
IVAFiscal.FechaEmision=Importe
Importe=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=MovPropiedades
MovPropiedades=Personalizar
Personalizar=(Fin)
