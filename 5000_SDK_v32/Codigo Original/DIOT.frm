
[Forma]
Clave=DIOT
Icono=0
BarraHerramientas=S
Modulos=(Todos)
MovModulo=(Todos)
Nombre=DPIVA
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=DIOT
CarpetaPrincipal=DIOT
PosicionInicialIzquierda=369
PosicionInicialArriba=194
PosicionInicialAlturaCliente=301
PosicionInicialAncho=627
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
Comentarios=FechaEnTexto(Info.FechaD, <T>dd/mmm/aaaa<T>)+<T> - <T>+FechaEnTexto(Info.FechaA, <T>dd/mmm/aaaa<T>))
[DIOT]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=DIOT
Clave=DIOT
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOT
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Rubro<T>
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)


Filtros=S
OtroOrden=S
ListaOrden=DIOT.Rubro<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
IconosNombre=DIOT:DIOT.Rubro
FiltroGeneral=DIOT.EstacionTrabajo = {EstacionTrabajo}
[DIOT.DIOT.Descripcion]
Carpeta=DIOT
Clave=DIOT.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[DIOT.DIOT.Importe]
Carpeta=DIOT
Clave=DIOT.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[DIOT.DIOT.IVA]
Carpeta=DIOT
Clave=DIOT.IVA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Totalizador=1
[DIOT.Columnas]
0=44
1=339
2=104
3=95

[Acciones.Detalle]
Nombre=Detalle
Boton=66
NombreEnBoton=S
NombreDesplegar=&Detalle
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=DIOTD
Activo=S
Visible=S

EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.ID, DIOT:DIOT.Rubro)<BR>Asigna(Info.Anuncio, DIOT:DIOT.Descripcion)
[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[DIOT.ListaEnCaptura]
(Inicio)=DIOT.Descripcion
DIOT.Descripcion=DIOT.Importe
DIOT.Importe=DIOT.IVA
DIOT.IVA=(Fin)














[Acciones.Preliminar]
Nombre=Preliminar
Boton=68
NombreDesplegar=Preliminar
EnBarraHerramientas=S
Carpeta=DIOT
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S


[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
Carpeta=DIOT
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

EspacioPrevio=S





[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=DIOT
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S












[Acciones.Calcular]
Nombre=Calcular
Boton=20
NombreEnBoton=S
NombreDesplegar=Calcular
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

EspacioPrevio=S

















































Expresion=Si Forma(<T>EspecificarFechas<T>)<BR>Entonces<BR>  Informacion(SQL(<T>EXEC spDIOT :nEstacion, :tEmpresa, :tFechaD, :tFechaA<T>, EstacionTrabajo, Empresa, FechaFormatoServidor(Info.FechaD), FechaFormatoServidor(Info.FechaA)))<BR>  ActualizarVista<BR>  ActualizarForma<BR>Fin
[Acciones.Reporte]
Nombre=Reporte
Boton=18
NombreEnBoton=S
NombreDesplegar=Reporte
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=DIOT
Activo=S
Visible=S























































































































































































































































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Calcular
Calcular=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Detalle
Detalle=Reporte
Reporte=(Fin)
