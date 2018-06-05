
[Forma]
Clave=DIOTParamXML
Icono=0
Modulos=(Todos)
MovModulo=DIOTParamXML
Nombre=XML DPIVA

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=409
PosicionInicialArriba=238
PosicionInicialAlturaCliente=213
PosicionInicialAncho=547
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=FechaEnTexto(Info.FechaD, <T>dd/mm/aaaa<T>)+<T> - <T>+FechaEnTexto(Info.FechaA, <T>dd/mm/aaaa<T>))
ExpresionesAlMostrar=EjecutarSQL(<T>EXEC spDIOTXMLDPIVA :nEstacion, :nBandera, :fFechaD, :fFechaA, 0, 0<T>, EstacionTrabajo, 1,Info.FechaD, Info.FechaA)
ExpresionesAlActivar=ActualizarForma
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DIOTParamXML
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=101
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

PermiteEditar=S

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
FiltroGeneral={<T>DIOTParamXML.Estacion =<T> & EstacionTrabajo}
[Lista.DIOTParamXML.Ejercicio]
Carpeta=Lista
Clave=DIOTParamXML.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=8
OcultaNombre=N
[Lista.DIOTParamXML.TipoPeriodo]
Carpeta=Lista
Clave=DIOTParamXML.TipoPeriodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[Lista.DIOTParamXML.Periodo]
Carpeta=Lista
Clave=DIOTParamXML.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

[Lista.DIOTParamXML.DPIVA]
Carpeta=Lista
Clave=DIOTParamXML.DPIVA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

IgnoraFlujo=S
[Lista.DIOTParamXML.TipoDec]
Carpeta=Lista
Clave=DIOTParamXML.TipoDec
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

IgnoraFlujo=S
[Lista.DIOTParamXML.FolioAnt]
Carpeta=Lista
Clave=DIOTParamXML.FolioAnt
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.DIOTParamXML.FechaAnt]
Carpeta=Lista
Clave=DIOTParamXML.FechaAnt
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco



Tamano=15



[Acciones.Aceptar.XML]
Nombre=XML
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si (SQL(<T>EXEC spDIOTXMLDPIVA :nEstacion, 0, :fFechaD, :fFechaA, 0, 0<T>, EstacionTrabajo, Info.FechaD, Info.FechaA)) = 1<BR>Entonces<BR>    Informacion(SQLEnLista(<T>EXEC spDIOTXMLDPIVA :nEstacion, 0, :fFechaD, :fFechaA, 1, 0<T>, EstacionTrabajo,Info.FechaD, Info.FechaA))<BR>Sino<BR>    Asigna(Info.Nombre, SQL(<T>SELECT dbo.NombreArchivoDIOT (:nEstacion)<T>, EstacionTrabajo))<BR>    GuardarLista( AnsiEnUTF8(SQL(<T>EXEC spDIOTXMLDPIVA :nEstacion, 0, :fFechaD, :fFechaA, 1, 0<T>, EstacionTrabajo, Info.FechaD, Info.FechaA)),<T><T>, Info.Nombre, <T>xml<T>, <T>xml<T>, <T>xml<T>)<BR>Fin
[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S
GuardarAntes=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

















[Lista.EspacioV]
Carpeta=Lista
Clave=EspacioV
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=8
ColorFondo=Blanco

OcultaNombre=N














































[Lista.Columnas]
ClavePeriodicidad=108
Descripcion_1=177
ClavePeriodo=101
Descripcion=172
Clave=94





























































[Lista.ListaEnCaptura]
(Inicio)=DIOTParamXML.Ejercicio
DIOTParamXML.Ejercicio=DIOTParamXML.DPIVA
DIOTParamXML.DPIVA=DIOTParamXML.TipoPeriodo
DIOTParamXML.TipoPeriodo=DIOTParamXML.TipoDec
DIOTParamXML.TipoDec=DIOTParamXML.Periodo
DIOTParamXML.Periodo=DIOTParamXML.FolioAnt
DIOTParamXML.FolioAnt=EspacioV
EspacioV=DIOTParamXML.FechaAnt
DIOTParamXML.FechaAnt=(Fin)


































[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=XML
XML=Cerrar
Cerrar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
