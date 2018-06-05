
[Forma]
Clave=ContParalelaPoliza
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Contabilidad Paralela - Pólizas
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Maximizado

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=137
PosicionInicialArriba=15
PosicionInicialAlturaCliente=659
PosicionInicialAncho=1091
PosicionSec1=296
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionCol1=526
PosicionCol2=526
Comentarios=Info.Empresa
ExpresionesAlMostrar=Asigna(Info.ID, Nulo)<BR>Asigna(Info.Empresa, Nulo)
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContParalelaPoliza
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

BusquedaRapidaControles=S
FiltroFechas=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasCampo=ContParalelaPoliza.FechaEmision
FiltroFechasDefault=Este Mes
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
MenuLocal=S
ListaAcciones=(Lista)
Pestana=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=ContParalelaPoliza:ContParalelaPoliza.Mov+<T> <T>+ContParalelaPoliza:ContParalelaPoliza.MovID
FiltroGeneral=ContParalelaPoliza.IDEmpresa = ISNULL({Info.ID}, ContParalelaPoliza.IDEmpresa)
[Lista.ContParalelaPoliza.FechaEmision]
Carpeta=Lista
Clave=ContParalelaPoliza.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=84
1=92

2=-2
3=-2
4=-2
5=107
6=-2
7=-2
8=-2
Empresa=75
BaseDatosRemota=145
EmpresaRemota=105
[Detalle]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=ContParalelaPolizaD
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ContParalelaPoliza
LlaveLocal=(Lista)

LlaveMaestra=(Lista)
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S



ValidarCampos=S


ListaEnCaptura=(Lista)
ListaCamposAValidar=ContParalelaCta.Descripcion




[Detalle.ContParalelaPolizaD.Cuenta]
Carpeta=Detalle
Clave=ContParalelaPolizaD.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ContParalelaPolizaD.Debe]
Carpeta=Detalle
Clave=ContParalelaPolizaD.Debe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.ContParalelaPolizaD.Haber]
Carpeta=Detalle
Clave=ContParalelaPolizaD.Haber
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Detalle.Columnas]
Cuenta=87
Debe=116
Haber=119


CuentaAsignada=112
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




[Origen]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Movimiento Origen
Clave=Origen
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=ContParalelaPolizaOrigen
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ContParalelaPoliza
LlaveLocal=(Lista)

LlaveMaestra=(Lista)
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



[Origen.ContParalelaPolizaOrigen.Mov]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Efectos=[Negritas]
[Origen.ContParalelaPolizaOrigen.MovID]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.MovID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=S
Efectos=[Negritas]
[Origen.ContParalelaPolizaOrigen.FechaEmision]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.FechaEmision
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Origen.ContParalelaPolizaOrigen.Concepto]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Origen.ContParalelaPolizaOrigen.Proyecto]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Origen.ContParalelaPolizaOrigen.Moneda]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Origen.ContParalelaPolizaOrigen.TipoCambio]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.TipoCambio
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Pegado=S
Tamano=10
[Origen.ContParalelaPolizaOrigen.Referencia]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco



[Origen.ContParalelaPolizaOrigen.Importe]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
EspacioPrevio=S
[Origen.ContParalelaPolizaOrigen.Impuestos]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Impuestos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=16
Pegado=S


[Origen.ContParalelaPolizaOrigen.UEN]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.UEN
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[Origen.ContParalelaPolizaOrigen.Contacto]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Contacto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

Pegado=N
[Origen.ContParalelaPolizaOrigen.ContactoTipo]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Origen.ContParalelaPolizaOrigen.Vencimiento]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco




Pegado=N
Tamano=15
[Origen.ContParalelaPolizaOrigen.Almacen]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

Pegado=N
[Origen.ContParalelaPolizaOrigen.Condicion]
Carpeta=Origen
Clave=ContParalelaPolizaOrigen.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

























































































EspacioPrevio=S
































[Lista.ContParalelaPoliza.ContactoTipo]
Carpeta=Lista
Clave=ContParalelaPoliza.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ContParalelaPoliza.Contacto]
Carpeta=Lista
Clave=ContParalelaPoliza.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco





[Lista.ModuloNombre]
Carpeta=Lista
Clave=ModuloNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.MovimientoOrigen]
Carpeta=Lista
Clave=MovimientoOrigen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco


[Acciones.ListaExcel]
Nombre=ListaExcel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.ListaPreliminar]
Nombre=ListaPreliminar
Boton=0
NombreDesplegar=Presentación Preliminar
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.ListaImprimir]
Nombre=ListaImprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S



[Origen.LlaveLocal]
(Inicio)=ContParalelaPolizaOrigen.IDEmpresa
ContParalelaPolizaOrigen.IDEmpresa=ContParalelaPolizaOrigen.ID
ContParalelaPolizaOrigen.ID=(Fin)

[Origen.LlaveMaestra]
(Inicio)=ContParalelaPoliza.IDEmpresa
ContParalelaPoliza.IDEmpresa=ContParalelaPoliza.ID
ContParalelaPoliza.ID=(Fin)

[Origen.ListaEnCaptura]
(Inicio)=ContParalelaPolizaOrigen.Mov
ContParalelaPolizaOrigen.Mov=ContParalelaPolizaOrigen.MovID
ContParalelaPolizaOrigen.MovID=ContParalelaPolizaOrigen.FechaEmision
ContParalelaPolizaOrigen.FechaEmision=ContParalelaPolizaOrigen.Moneda
ContParalelaPolizaOrigen.Moneda=ContParalelaPolizaOrigen.TipoCambio
ContParalelaPolizaOrigen.TipoCambio=ContParalelaPolizaOrigen.Proyecto
ContParalelaPolizaOrigen.Proyecto=ContParalelaPolizaOrigen.UEN
ContParalelaPolizaOrigen.UEN=ContParalelaPolizaOrigen.Almacen
ContParalelaPolizaOrigen.Almacen=ContParalelaPolizaOrigen.ContactoTipo
ContParalelaPolizaOrigen.ContactoTipo=ContParalelaPolizaOrigen.Contacto
ContParalelaPolizaOrigen.Contacto=ContParalelaPolizaOrigen.Condicion
ContParalelaPolizaOrigen.Condicion=ContParalelaPolizaOrigen.Vencimiento
ContParalelaPolizaOrigen.Vencimiento=ContParalelaPolizaOrigen.Concepto
ContParalelaPolizaOrigen.Concepto=ContParalelaPolizaOrigen.Referencia
ContParalelaPolizaOrigen.Referencia=ContParalelaPolizaOrigen.Importe
ContParalelaPolizaOrigen.Importe=ContParalelaPolizaOrigen.Impuestos
ContParalelaPolizaOrigen.Impuestos=(Fin)




[Contacto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contacto
Clave=Contacto
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B2
Vista=ContParalelaPolizaContacto
Fuente={Tahoma, 8, Negro, []}
VistaMaestra=ContParalelaPolizaOrigen
LlaveLocal=(Lista)

LlaveMaestra=(Lista)
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



[Contacto.ContParalelaPolizaContacto.Nombre]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco







EspacioPrevio=S
[Contacto.ContParalelaPolizaContacto.Categoria]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

EspacioPrevio=S
[Contacto.ContParalelaPolizaContacto.Familia]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Familia
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.Grupo]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco





[Contacto.ContParalelaPolizaContacto.ContactoTipo]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.ContactoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

Efectos=[Negritas]
[Contacto.ContParalelaPolizaContacto.Contacto]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Contacto
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco





Efectos=[Negritas]








[Contacto.ContParalelaPolizaContacto.RFC]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.CURP]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.CURP
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco













[Contacto.ContParalelaPolizaContacto.Direccion]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=50
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.DireccionNumero]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.DireccionNumeroInt]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=5
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.EntreCalles]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.Delegacion]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.Colonia]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.CodigoPostal]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.Poblacion]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.Estado]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco

[Contacto.ContParalelaPolizaContacto.Pais]
Carpeta=Contacto
Clave=ContParalelaPolizaContacto.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco










[Contacto.LlaveLocal]
(Inicio)=ContParalelaPolizaContacto.ContactoTipo
ContParalelaPolizaContacto.ContactoTipo=ContParalelaPolizaContacto.Contacto
ContParalelaPolizaContacto.Contacto=(Fin)

[Contacto.LlaveMaestra]
(Inicio)=ContParalelaPolizaOrigen.ContactoTipo
ContParalelaPolizaOrigen.ContactoTipo=ContParalelaPolizaOrigen.Contacto
ContParalelaPolizaOrigen.Contacto=(Fin)

[Contacto.ListaEnCaptura]
(Inicio)=ContParalelaPolizaContacto.ContactoTipo
ContParalelaPolizaContacto.ContactoTipo=ContParalelaPolizaContacto.Contacto
ContParalelaPolizaContacto.Contacto=ContParalelaPolizaContacto.Nombre
ContParalelaPolizaContacto.Nombre=ContParalelaPolizaContacto.RFC
ContParalelaPolizaContacto.RFC=ContParalelaPolizaContacto.CURP
ContParalelaPolizaContacto.CURP=ContParalelaPolizaContacto.Categoria
ContParalelaPolizaContacto.Categoria=ContParalelaPolizaContacto.Familia
ContParalelaPolizaContacto.Familia=ContParalelaPolizaContacto.Grupo
ContParalelaPolizaContacto.Grupo=ContParalelaPolizaContacto.Direccion
ContParalelaPolizaContacto.Direccion=ContParalelaPolizaContacto.DireccionNumero
ContParalelaPolizaContacto.DireccionNumero=ContParalelaPolizaContacto.DireccionNumeroInt
ContParalelaPolizaContacto.DireccionNumeroInt=ContParalelaPolizaContacto.EntreCalles
ContParalelaPolizaContacto.EntreCalles=ContParalelaPolizaContacto.Delegacion
ContParalelaPolizaContacto.Delegacion=ContParalelaPolizaContacto.Colonia
ContParalelaPolizaContacto.Colonia=ContParalelaPolizaContacto.CodigoPostal
ContParalelaPolizaContacto.CodigoPostal=ContParalelaPolizaContacto.Poblacion
ContParalelaPolizaContacto.Poblacion=ContParalelaPolizaContacto.Estado
ContParalelaPolizaContacto.Estado=ContParalelaPolizaContacto.Pais
ContParalelaPolizaContacto.Pais=(Fin)





[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Impri
Activo=S
Visible=S



[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S



[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S



[Acciones.Movimiento]
Nombre=Movimiento
Boton=58
NombreEnBoton=S
NombreDesplegar=Movimiento
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=ContParalelaPoliza
ListaParametros1=ContParalelaPoliza:ContParalelaPoliza.ID
ListaParametros=S
Activo=S
Visible=S







ConCondicion=S
EjecucionCondicion=ConDatos(ContParalelaPoliza:ContParalelaPoliza.ID)
[Acciones.MostrarCampos]
Nombre=MostrarCampos
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S








[Acciones.Filtro]
Nombre=Filtro
Boton=107
NombreEnBoton=S
NombreDesplegar=Empresa Remota
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S

























Expresion=Forma(<T>ContParalelaEmpresaFiltro<T>)<BR>ActualizarForma<BR>ActualizarVista






[Detalle.LlaveLocal]
(Inicio)=ContParalelaPolizaD.ID
ContParalelaPolizaD.ID=ContParalelaPolizaD.IDEmpresa
ContParalelaPolizaD.IDEmpresa=(Fin)

[Detalle.LlaveMaestra]
(Inicio)=ContParalelaPoliza.ID
ContParalelaPoliza.ID=ContParalelaPoliza.IDEmpresa
ContParalelaPoliza.IDEmpresa=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=ContParalelaPolizaD.Cuenta
ContParalelaPolizaD.Cuenta=ContParalelaCta.CuentaAsignada
ContParalelaCta.CuentaAsignada=ContParalelaPolizaD.Debe
ContParalelaPolizaD.Debe=ContParalelaPolizaD.Haber
ContParalelaPolizaD.Haber=(Fin)

[Detalle.ContParalelaCta.CuentaAsignada]
Carpeta=Detalle
Clave=ContParalelaCta.CuentaAsignada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
Efectos=[Negritas]





[Lista.ListaEnCaptura]
(Inicio)=ContParalelaPoliza.FechaEmision
ContParalelaPoliza.FechaEmision=ContParalelaPoliza.ContactoTipo
ContParalelaPoliza.ContactoTipo=ContParalelaPoliza.Contacto
ContParalelaPoliza.Contacto=ModuloNombre
ModuloNombre=MovimientoOrigen
MovimientoOrigen=(Fin)

[Lista.ListaAcciones]
(Inicio)=ListaExcel
ListaExcel=ListaPreliminar
ListaPreliminar=ListaImprimir
ListaImprimir=(Fin)

























[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Origen
Origen=Contacto
Contacto=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Movimiento
Movimiento=Filtro
Filtro=MostrarCampos
MostrarCampos=(Fin)
