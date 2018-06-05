[Forma]
Clave=ExplorarIVAFiscalDinero
Nombre=Explorando - IVA Fiscal (Bancos)
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=81
PosicionInicialArriba=161
PosicionInicialAlturaCliente=412
PosicionInicialAncho=862
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Caso Info.Base<BR>  Es <T>S<T> Entonces <T>Movimientos Conciliados<T><BR>  Es <T>N<T> Entonces <T>Movimientos Sin Conciliar<T><BR>Sino<BR>  <T>Todos los Movimientos<T><BR>Fin
ExpresionesAlMostrar=Asigna(Info.Base, <T>S<T>)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AuxiliarDinero
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
FiltroFechasCampo=Auxiliar.Fecha
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
FiltroMonedas=S
FiltroMonedasCampo=Auxiliar.Moneda
PestanaOtroNombre=S
PestanaNombre=Movimientos
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroTodo=S
FiltroSucursales=S
BusquedaRapida=S
BusquedaEnLinea=S
BusquedaAncho=20

IconosNombre=AuxiliarDinero:Auxiliar.Mov+<T> <T>+AuxiliarDinero:Auxiliar.MovID
FiltroGeneral=Auxiliar.Rama = <T>DIN<T> AND Auxiliar.Empresa=<T>{Empresa}<T> AND Dinero.IVAFiscal<>0        <BR>AND Auxiliar.Fecha>=<T>{FechaFormatoServidor(Config.FiscalInicioIVA)}<T><BR>AND CtaDinero.Tipo=<T>Banco<T><BR>{Si(Info.Base=<T>S<T>, <T> AND Auxiliar.Conciliado = 1<T>, <T><T>)}<BR>{Si(Info.Base=<T>N<T>, <T> AND Auxiliar.Conciliado = 0<T>, <T><T>)}
[Lista.Columnas]
0=95
1=84

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

[Lista.Dinero.FechaEmision]
Carpeta=Lista
Clave=Dinero.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Dinero.Concepto]
Carpeta=Lista
Clave=Dinero.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Dinero.Referencia]
Carpeta=Lista
Clave=Dinero.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Auxiliar.FechaConciliacion]
Carpeta=Lista
Clave=Auxiliar.FechaConciliacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IVAIngreso]
Carpeta=Lista
Clave=IVAIngreso
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.IVAEgreso]
Carpeta=Lista
Clave=IVAEgreso
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Auxiliar.Cargo]
Carpeta=Lista
Clave=Auxiliar.Cargo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Auxiliar.Abono]
Carpeta=Lista
Clave=Auxiliar.Abono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Acciones.Movimientos]
Nombre=Movimientos
Boton=55
NombreEnBoton=S
NombreDesplegar=&Todos/Conciliados
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Base, <BR>Caso Info.Base<BR>  Es <T>S<T> Entonces <T>N<T><BR>  Es <T>N<T> Entonces Nulo<BR>Sino<BR>  <T>S<T><BR>Fin)

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(AuxiliarDinero:Auxiliar.ModuloID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, AuxiliarDinero:Auxiliar.Modulo)<BR>Asigna(Info.ID, AuxiliarDinero:Auxiliar.ModuloID)
Visible=S

[Lista.IVA]
Carpeta=Lista
Clave=IVA
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=Propiedades
Propiedades=Movimientos
Movimientos=(Fin)



[Lista.ListaEnCaptura]
(Inicio)=Dinero.FechaEmision
Dinero.FechaEmision=Dinero.Referencia
Dinero.Referencia=Dinero.Concepto
Dinero.Concepto=Auxiliar.FechaConciliacion
Auxiliar.FechaConciliacion=Auxiliar.Cargo
Auxiliar.Cargo=Auxiliar.Abono
Auxiliar.Abono=IVAIngreso
IVAIngreso=IVAEgreso
IVAEgreso=IVA
IVA=(Fin)
