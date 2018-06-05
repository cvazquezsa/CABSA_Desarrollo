

[Forma]
Clave=MovilVistaCampo
Icono=0
CarpetaPrincipal=Lista
BarraHerramientas=S
Modulos=(Todos)
MovModulo=MovilVistaCampo
Nombre=Campos Vista
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
PosicionInicialIzquierda=556
PosicionInicialArriba=234
PosicionInicialAlturaCliente=405
PosicionInicialAncho=621
PosicionCol1=248
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovilVistaCampo
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
ListaEnCaptura=MovilVistaCampo.Campo
CarpetaVisible=S

PermiteEditar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
ExpAntesRefrescar=MovilVistaCampo:MovilVistaCampo.IDMovilVista = Info.ID
FiltroGeneral=MovilVistaCampo.IDMovilVista = <T>{Info.ID}<T>
[Lista.MovilVistaCampo.Campo]
Carpeta=Lista
Clave=MovilVistaCampo.Campo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.Columnas]
Campo=604

[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=MovilVistaCampo
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

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
[Detalle.MovilVistaCampo.Requerido]
Carpeta=Detalle
Clave=MovilVistaCampo.Requerido
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Pegado=N
[Detalle.MovilVistaCampo.Visible]
Carpeta=Detalle
Clave=MovilVistaCampo.Visible
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Pegado=N
[Detalle.MovilVistaCampo.Etiqueta]
Carpeta=Detalle
Clave=MovilVistaCampo.Etiqueta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.MovilVistaCampo.Seccion]
Carpeta=Detalle
Clave=MovilVistaCampo.Seccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

EspacioPrevio=S
[Detalle.MovilVistaCampo.Orden]
Carpeta=Detalle
Clave=MovilVistaCampo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Detalle.MovilVistaCampo.Formato]
Carpeta=Detalle
Clave=MovilVistaCampo.Formato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco


[Detalle.MovilVistaCampo.Busqueda]
Carpeta=Detalle
Clave=MovilVistaCampo.Busqueda
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco



[Detalle.MovilVistaCampo.Campo]
Carpeta=Detalle
Clave=MovilVistaCampo.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco































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




Antes=S
AntesExpresiones=MovilVistaCampo:MovilVistaCampo.IDMovilVista = Info.ID
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S












[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S



EspacioPrevio=S















[Detalle.MovilVistaCampo.Llave]
Carpeta=Detalle
Clave=MovilVistaCampo.Llave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.MovilVistaCampo.Longitud]
Carpeta=Detalle
Clave=MovilVistaCampo.Longitud
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco














[Detalle.MovilVistaCampo.Editable]
Carpeta=Detalle
Clave=MovilVistaCampo.Editable
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco




Tamano=












EspacioPrevio=S








[Detalle.ListaEnCaptura]
(Inicio)=MovilVistaCampo.Campo
MovilVistaCampo.Campo=MovilVistaCampo.Llave
MovilVistaCampo.Llave=MovilVistaCampo.Etiqueta
MovilVistaCampo.Etiqueta=MovilVistaCampo.Formato
MovilVistaCampo.Formato=MovilVistaCampo.Longitud
MovilVistaCampo.Longitud=MovilVistaCampo.Editable
MovilVistaCampo.Editable=MovilVistaCampo.Requerido
MovilVistaCampo.Requerido=MovilVistaCampo.Visible
MovilVistaCampo.Visible=MovilVistaCampo.Busqueda
MovilVistaCampo.Busqueda=MovilVistaCampo.Seccion
MovilVistaCampo.Seccion=MovilVistaCampo.Orden
MovilVistaCampo.Orden=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=Nuevo
Nuevo=(Fin)
