[Forma]
Clave=CFDFlexLista
Icono=4
BarraHerramientas=S
Modulos=(Todos)
MovModulo=CFDFlex
Nombre=<T>CFDI<T>
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=234
PosicionInicialArriba=93
PosicionInicialAlturaCliente=514
PosicionInicialAncho=914
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Info.Accion, <T>Todos<T>)<BR>Asigna(Info.Copiar, Falso)
[Lista]
Estilo=Iconos
Clave=Lista
Filtros=S
BusquedaRapidaControles=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDFlex
Fuente={Tahoma, 8, Negro, []}
IconosCampo=CFDFlex.Icono
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
ElementosPorPaginaEsp=500
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
CarpetaVisible=S
ListaEnCaptura=(Lista)

FiltroFechas=S
FiltroFechasCampo=CFDFlex.Fecha
FiltroFechasDefault=Este Mes
BusquedaRapida=S
BusquedaEnLinea=S
IconosSubTitulo=<T>Empresa<T>

FiltroGrupo1=CFDFlex.Serie
FiltroValida1=CFDFlex.Serie
FiltroTodo=S
IconosConSenales=S
FiltroEstatus=S
FiltroListaEstatus=(Lista)
FiltroEstatusDefault=PENDIENTE
IconosConPaginas=S
PestanaOtroNombre=S
PestanaNombre=CFDI
BusquedaAncho=20
IconosNombre=CFDFlex:CFDFlex.Empresa
FiltroGeneral=CFDFlex.Empresa = {Comillas(Empresa)}  {SI Info.Accion = <T>Timbrados<T> ENTONCES <T> AND Timbrado = 1<T> SINO <T><T>}  {SI Info.Accion = <T>Cancelados<T> ENTONCES <T> AND Cancelado = 1 <T> SINO <T><T>} {SI Info.Accion = <T>No Timbrados<T> ENTONCES <T> AND Timbrado = 0<T> SINO <T><T>}
[Lista.CFDFlex.Modulo]
Carpeta=Lista
Clave=CFDFlex.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.CFDFlex.Fecha]
Carpeta=Lista
Clave=CFDFlex.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.CFDFlex.Serie]
Carpeta=Lista
Clave=CFDFlex.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDFlex.Folio]
Carpeta=Lista
Clave=CFDFlex.Folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDFlex.Importe]
Carpeta=Lista
Clave=CFDFlex.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.Columnas]
0=74
1=67
2=75
3=61
4=91
5=106
6=62
7=91










8=-2
9=-2
10=-2
11=-2
12=212
13=-2
14=-2
15=-2
16=-2
17=-2
18=-2
19=-2
20=-2
[Lista.CFDFlex.RFC]
Carpeta=Lista
Clave=CFDFlex.RFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


















[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S


[Acciones.Preeliminar]
Nombre=Preeliminar
Boton=6
NombreDesplegar=&Vista Previa
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=115
NombreDesplegar=&Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S




[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=&Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S





[Lista.CFDFlex.Impuesto1]
Carpeta=Lista
Clave=CFDFlex.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDFlex.Impuesto2]
Carpeta=Lista
Clave=CFDFlex.Impuesto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



































[Lista.CFDFlex.Timbrado]
Carpeta=Lista
Clave=CFDFlex.Timbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[Lista.CFDFlex.FechaTimbrado]
Carpeta=Lista
Clave=CFDFlex.FechaTimbrado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDFlex.OrigenSerie]
Carpeta=Lista
Clave=CFDFlex.OrigenSerie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CFDFlex.OrigenFolio]
Carpeta=Lista
Clave=CFDFlex.OrigenFolio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CFDFlex.ParcialidadNumero]
Carpeta=Lista
Clave=CFDFlex.ParcialidadNumero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco







[Acciones.PDFIntelisis.Generar]
Nombre=Generar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S


Expresion=SI (General.CFDI o Empresa.CFD) Entonces<BR>Asigna(Info.Mensaje,<T>No es posible generar PDF revisar configuración del Movimiento<T>)<BR>  Si SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID, 0) Entonces<BR>    Asigna(Info.Reporte, SQL(<T>spMovFormatoIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID))<BR>    Asigna(Info.Ruta, SQL(<T>spMovRutaIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa,CFDFlex:CFDFlex.Modulo,<T><T>, CFDFlex:CFDFlex.ModuloID))<BR>    ReportePDF(Info.Reporte,CFDFlex:CFDFlex.ModuloID,Info.Ruta)<BR>    EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, CFDFlex:CFDFlex.Modulo, <T><T>, CFDFlex:CFDFlex.ModuloID)<BR>    Asigna(Info.Mensaje,<T>Proceso Concluido<T>)<BR>  Fin<BR>Informacion(Info.Mensaje)<BR>Fin

[Acciones.Todos]
Nombre=Todos
Boton=71
NombreEnBoton=S
NombreDesplegar=Todos
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S


ActivoCondicion=Info.Accion <> <T>Todos<T>
Antes=S
AntesExpresiones=Asigna(Info.Accion,<T>Todos<T>)
[Acciones.Timbrados]
Nombre=Timbrados
Boton=71
NombreEnBoton=S
NombreDesplegar=Timbrados
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S


Antes=S
ActivoCondicion=Info.Accion <> <T>Timbrados<T>
AntesExpresiones=Asigna(Info.Accion, <T>Timbrados<T>)
[Acciones.Cancelados]
Nombre=Cancelados
Boton=71
NombreDesplegar=Cancelados
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S



NombreEnBoton=S


























ActivoCondicion=Info.Accion <>  <T>Cancelados<T>
Antes=S
AntesExpresiones=Asigna(Info.Accion, <T>Cancelados<T>)
























[Lista.CFDFlex.Cancelado]
Carpeta=Lista
Clave=CFDFlex.Cancelado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.CFDFlex.RutaAcuse]
Carpeta=Lista
Clave=CFDFlex.RutaAcuse
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco









































[Acciones.Acuse.Refrescar]
Nombre=Refrescar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S






[Acciones.Acuse.RutaAcuse]
Nombre=RutaAcuse
Boton=0
TipoAccion=Formas
ClaveAccion=RutaAcuse
Activo=S
Visible=S


















[Acciones.NoTimbrados]
Nombre=NoTimbrados
Boton=71
NombreEnBoton=S
NombreDesplegar=No Timbrados
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
ActivoCondicion=Info.Accion <>  <T>No Timbrados<T>
Antes=S
AntesExpresiones=Asigna(Info.Accion, <T>No Timbrados<T>)
Visible=S















[Acciones.Acuse.ListaAccionesMultiples]
(Inicio)=RutaAcuse
RutaAcuse=Refrescar
Refrescar=(Fin)


[Lista.CFDFlex.OrigenUUID]
Carpeta=Lista
Clave=CFDFlex.OrigenUUID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco

[Lista.CFDFlex.UUIDTexto]
Carpeta=Lista
Clave=CFDFlex.UUIDTexto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





















































































































































































[Acciones.PDFIntelisis.ListaAccionesMultiples]
(Inicio)=Generar
Generar=Refrescar
Refrescar=(Fin)














[Lista.CFDFlex.Mov]
Carpeta=Lista
Clave=CFDFlex.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CFDFlex.MovID]
Carpeta=Lista
Clave=CFDFlex.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco










[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

Antes=S








AntesExpresiones=Asigna(Info.Copiar, Verdadero)<BR>Asigna(Info.Mov, CFDFlex:CFDFlex.Mov)<BR>Asigna(Info.MovID, CFDFlex:CFDFlex.MovID)<BR>Asigna(Info.Descripcion, CFDFlex:CFDFlex.UUIDTexto)





[Lista.ListaAcciones]
(Inicio)=Seleccionar Todo
Seleccionar Todo=Quitar Seleccion
Quitar Seleccion=PDFIntelisis
PDFIntelisis=GenerarEnviar
GenerarEnviar=Cancelar
Cancelar=Acuse
Acuse=GeneraPDF
GeneraPDF=GeneraXML
GeneraXML=(Fin)


[Lista.ListaEnCaptura]
(Inicio)=CFDFlex.Modulo
CFDFlex.Modulo=CFDFlex.Mov
CFDFlex.Mov=CFDFlex.MovID
CFDFlex.MovID=CFDFlex.Fecha
CFDFlex.Fecha=CFDFlex.Serie
CFDFlex.Serie=CFDFlex.Folio
CFDFlex.Folio=CFDFlex.RFC
CFDFlex.RFC=CFDFlex.Importe
CFDFlex.Importe=CFDFlex.Impuesto1
CFDFlex.Impuesto1=CFDFlex.Impuesto2
CFDFlex.Impuesto2=ImporteTotal
ImporteTotal=CFDFlex.Timbrado
CFDFlex.Timbrado=CFDFlex.Cancelado
CFDFlex.Cancelado=CFDFlex.RutaAcuse
CFDFlex.RutaAcuse=CFDFlex.FechaTimbrado
CFDFlex.FechaTimbrado=CFDFlex.OrigenSerie
CFDFlex.OrigenSerie=CFDFlex.OrigenFolio
CFDFlex.OrigenFolio=CFDFlex.ParcialidadNumero
CFDFlex.ParcialidadNumero=CFDFlex.OrigenUUID
CFDFlex.OrigenUUID=CFDFlex.UUIDTexto
CFDFlex.UUIDTexto=(Fin)

[Lista.FiltroListaEstatus]
(Inicio)=(Todos)
(Todos)=PENDIENTE
PENDIENTE=CONCLUIDO
CONCLUIDO=CANCELADO
CANCELADO=(Fin)



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Imprimir
Imprimir=Preeliminar
Preeliminar=Excel
Excel=Personalizar
Personalizar=Timbrados
Timbrados=NoTimbrados
NoTimbrados=Cancelados
Cancelados=Todos
Todos=(Fin)
