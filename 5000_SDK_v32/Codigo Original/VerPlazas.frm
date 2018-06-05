[Forma]
Clave=VerPlazas
Nombre=Plazas Vacantes
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
Comentarios=Info.Empresa
PosicionInicialIzquierda=222
PosicionInicialArriba=270
PosicionInicialAlturaCliente=450
PosicionInicialAncho=835
ExpresionesAlMostrar=Asigna(Info.Empresa, Empresa)
Totalizadores=S
PosicionSec1=388

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerPlazas
Fuente={Tahoma, 8, Negro, []}
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
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=Puesto
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=Departamento
FiltroAplicaEn1=Puesto
FiltroAplicaEn2=Departamento
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
FiltroTodo=S
FiltroTodoFinal=S
FiltroNull=S
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroSucursales=S
FiltroSucursalesTodasPorOmision=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha

[Lista.Puesto]
Carpeta=Lista
Clave=Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Departamento]
Carpeta=Lista
Clave=Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Sucursal]
Carpeta=Lista
Clave=Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PlazaAutorizada]
Carpeta=Lista
Clave=PlazaAutorizada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Ocupada]
Carpeta=Lista
Clave=Ocupada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Vacantes]
Carpeta=Lista
Clave=Vacantes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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

[Lista.Columnas]
Puesto=188
Departamento=182
Sucursal=49
PlazaAutorizada=94
Ocupada=64
Vacantes=64

[Acciones.Empresa]
Nombre=Empresa
Boton=45
NombreEnBoton=S
NombreDesplegar=<T>&Empresa<T>
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
Antes=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>EspecificarEmpresa<T>)

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
Totalizadores1=Plazas<BR>Ocupadas<BR>Vacantes
Totalizadores2=Suma(VerPlazas:PlazaAutorizada)<BR>Suma(VerPlazas:Ocupada)<BR>Suma(VerPlazas:Vacantes)
Totalizadores3=#,<BR>#,<BR>#,
TotAlCambiar=S
ListaEnCaptura=(Lista)

[(Carpeta Totalizadores).Plazas]
Carpeta=(Carpeta Totalizadores)
Clave=Plazas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Ocupadas]
Carpeta=(Carpeta Totalizadores)
Clave=Ocupadas
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).Vacantes]
Carpeta=(Carpeta Totalizadores)
Clave=Vacantes
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Empresa
Empresa=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Sucursal
Sucursal=Puesto
Puesto=Departamento
Departamento=PlazaAutorizada
PlazaAutorizada=Ocupada
Ocupada=Vacantes
Vacantes=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Plazas
Plazas=Ocupadas
Ocupadas=Vacantes
Vacantes=(Fin)
