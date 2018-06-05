[Forma]
Clave=ServicioTareaEditar
Nombre=<T>Editar Tarea<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=321
PosicionInicialArriba=153
PosicionInicialAltura=383
PosicionInicialAncho=382
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionSeccion1=50
VentanaExclusiva=S
VentanaEscCerrar=
PosicionColumna1=39
PosicionSeccion2=66
PosicionInicialAlturaCliente=427
AutoGuardar=S

[Lista.ServicioTarea.Tarea]
Carpeta=Lista
Clave=ServicioTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Concluido=53
Tarea=201
Diagnostico=164
Revision=604
Estado=149

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalles
EnBarraHerramientas=S
TipoAccion=Formas
ConCondicion=S
Antes=S
ClaveAccion=ServicioTareaD
DespuesGuardar=S
GuardarAntes=S
EjecucionCondicion=ConDatos(ServicioTarea:ServicioTarea.Tarea)
AntesExpresiones=Asigna(Info.ID, ServicioTarea:ServicioTarea.ID)<BR>Asigna(Info.RenglonID, ServicioTarea:ServicioTarea.RenglonID)<BR>Asigna(Info.Descripcion, ServicioTarea:ServicioTarea.Tarea)

[Acciones.Guardar]
Nombre=Guardar
Boton=0
NombreDesplegar=Guardar Cambios
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Buscar]
Nombre=Buscar
Boton=51
NombreDesplegar=&Problemas y Soluciones
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
EspacioPrevio=S
Expresion=Asigna(Info.Tarea, ServicioTarea:ServicioTarea.Tarea)<BR>Asigna(Info.Problema, ServicioTarea:ServicioTarea.Problema)<BR>Asigna(Info.Solucion, ServicioTarea:ServicioTarea.Solucion)<BR>Si<BR>  Forma(<T>ServicioTareaLista<T>)<BR>Entonces<BR>  Asigna(ServicioTarea:ServicioTarea.Problema, Info.Problema)<BR>  Asigna(ServicioTarea:ServicioTarea.Solucion, Info.Solucion)<BR>Fin

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ServicioTarea
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
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
FiltroGeneral=ServicioTarea.ID={Info.ID} AND ServicioTarea.RenglonID={Info.RenglonID}
FiltroRespetar=S
FiltroTipo=General

[Ficha.ServicioTarea.Tarea]
Carpeta=Ficha
Clave=ServicioTarea.Tarea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ServicioTarea.Problema]
Carpeta=Ficha
Clave=ServicioTarea.Problema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51x6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ServicioTarea.Solucion]
Carpeta=Ficha
Clave=ServicioTarea.Solucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51x6
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ServicioTarea.Estado]
Carpeta=Ficha
Clave=ServicioTarea.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ServicioTarea.Fecha]
Carpeta=Ficha
Clave=ServicioTarea.Fecha
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ServicioTarea.FechaEstimada]
Carpeta=Ficha
Clave=ServicioTarea.FechaEstimada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ServicioTarea.FechaConclusion]
Carpeta=Ficha
Clave=ServicioTarea.FechaConclusion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.ServicioTarea.Usuario]
Carpeta=Ficha
Clave=ServicioTarea.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Usuario.Nombre]
Carpeta=Ficha
Clave=Usuario.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=24
ColorFondo=Plata
ColorFuente=Negro

[Ficha.ServicioTarea.Tiempo]
Carpeta=Ficha
Clave=ServicioTarea.Tiempo
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Comentarios]
Nombre=Comentarios
Boton=47
NombreDesplegar=Comentarios
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ServicioTareaComentarios
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cerrar
Cerrar=Comentarios
Comentarios=Buscar
Buscar=Detalles
Detalles=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=ServicioTarea.Tarea
ServicioTarea.Tarea=ServicioTarea.Problema
ServicioTarea.Problema=ServicioTarea.Solucion
ServicioTarea.Solucion=ServicioTarea.Estado
ServicioTarea.Estado=ServicioTarea.Fecha
ServicioTarea.Fecha=ServicioTarea.FechaEstimada
ServicioTarea.FechaEstimada=ServicioTarea.FechaConclusion
ServicioTarea.FechaConclusion=ServicioTarea.Usuario
ServicioTarea.Usuario=Usuario.Nombre
Usuario.Nombre=ServicioTarea.Tiempo
ServicioTarea.Tiempo=(Fin)
