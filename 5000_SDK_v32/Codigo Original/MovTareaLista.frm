[Forma]
Clave=MovTareaLista
Nombre=Problemas y Soluciones
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=270
PosicionInicialArriba=318
PosicionInicialAltura=381
PosicionInicialAncho=740
Comentarios=Info.Tarea
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
PosicionInicialAlturaCliente=354

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTareaLista
Fuente={MS Sans Serif, 8, Negro, []}
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
CarpetaVisible=S
Filtros=S
BusquedaRapidaControles=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=30
BusquedaEnLinea=S
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista
FiltroAutoCampo=Tarea
FiltroGeneral={Si(ConDatos(Info.Tarea),<T>Tarea=<T>+Comillas(Info.Tarea),<T>Tarea IS NOT NULL<T>)}

[Lista.Problema]
Carpeta=Lista
Clave=Problema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Solucion]
Carpeta=Lista
Clave=Solucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=150
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Problema=269
Solucion=277
Tarea=145

[Detalles]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalles
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTareaLista
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalles.Problema]
Carpeta=Detalles
Clave=Problema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x8
ColorFondo=Plata
ConScroll=N
ColorFuente=Negro

[Detalles.Solucion]
Carpeta=Detalles
Clave=Solucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x8
ColorFondo=Plata
ConScroll=N
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Acciones.Todas]
Nombre=Todas
Boton=50
NombreEnBoton=S
NombreDesplegar=&Buscar en Todas 
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
Antes=S
EspacioPrevio=S
ActivoCondicion=ConDatos(Info.Tarea)
AntesExpresiones=Asigna(Info.Tarea, Nulo)

[Lista.Tarea]
Carpeta=Lista
Clave=Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Problema]
Nombre=Problema
Boton=23
NombreEnBoton=S
NombreDesplegar=&Problema
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Antes=S
Visible=S
AntesExpresiones=Asigna(Info.Problema, MovTareaLista:Problema)

[Acciones.Solucion]
Nombre=Solucion
Boton=23
NombreDesplegar=&Solución
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S
Antes=S
AntesExpresiones=Asigna(Info.Solucion, MovTareaLista:Solucion)

[Acciones.ProblemaSolucion]
Nombre=ProblemaSolucion
Boton=23
NombreEnBoton=S
NombreDesplegar=P&roblema y Solución
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Problema, MovTareaLista:Problema)<BR>Asigna(Info.Solucion, MovTareaLista:Solucion)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalles
Detalles=(Fin)

[Forma.ListaAcciones]
(Inicio)=Solucion
Solucion=Problema
Problema=ProblemaSolucion
ProblemaSolucion=Cancelar
Cancelar=Todas
Todas=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Tarea
Tarea=Problema
Problema=Solucion
Solucion=(Fin)

[Detalles.ListaEnCaptura]
(Inicio)=Problema
Problema=Solucion
Solucion=(Fin)
