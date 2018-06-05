[Forma]
Clave=CampanaUsuarioAsignar
Nombre=Asignar/Reasignar Usuarios
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
PosicionInicialIzquierda=567
PosicionInicialArriba=288
PosicionInicialAlturaCliente=572
PosicionInicialAncho=983
EsConsultaExclusiva=S
Comentarios=Lista(Info.Mov, Info.MovID)

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaD
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroAplicaEn=CampanaD.Usuario
FiltroPredefinido=S
FiltroAutoCampo=CampanaD.Usuario
FiltroAutoValidar=CampanaD.Usuario
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
IconosSubTitulo=<T>Nombre<T>
FiltroTodo=S
IconosSeleccionMultiple=S
MenuLocal=S
ListaAcciones=(Lista)
FiltroGrupo1=CampanaD.Usuario
FiltroValida1=CampanaD.Usuario
FiltroTodoFinal=S
IconosNombre=CampanaD:ContactoNombre
FiltroGeneral=CampanaD.ID={Info.ID}

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
0=218
1=64

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

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación Preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
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

[Lista.CampanaD.Contacto]
Carpeta=Lista
Clave=CampanaD.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaD.Situacion]
Carpeta=Lista
Clave=CampanaD.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaD.SituacionFecha]
Carpeta=Lista
Clave=CampanaD.SituacionFecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaD.Calificacion]
Carpeta=Lista
Clave=CampanaD.Calificacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaD.Observaciones]
Carpeta=Lista
Clave=CampanaD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContactoSubTipo]
Carpeta=Lista
Clave=ContactoSubTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Asignar]
Nombre=Asignar
Boton=38
NombreEnBoton=S
NombreDesplegar=&Asginar Selección
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Info.Usuario, Nulo)<BR>Si<BR>  Forma(<T>EspecificarUsuario<T>)<BR>Entonces<BR>  RegistrarSeleccionID(<T>Lista<T>)<BR>  EjecutarSQL(<T>spCampanaUsuarioAsignar :nEstacion, :nID, :tUsuario<T>, EstacionTrabajo, Info.ID, Info.Usuario)<BR>  Forma.ActualizarArbol(<T>Lista<T>) <BR>Fin

[Lista.CampanaD.Usuario]
Carpeta=Lista
Clave=CampanaD.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.LocalTodo]
Nombre=LocalTodo
Boton=0
NombreDesplegar=Seleccionar &Todo
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.LocalQuitar]
Nombre=LocalQuitar
Boton=0
NombreDesplegar=&Quitar Seleccion
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Quitar Seleccion
Activo=S
Visible=S

[Acciones.Todo]
Nombre=Todo
Boton=55
NombreDesplegar=Seleccionar &Todo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Seleccionar Todo
Activo=S
Visible=S

[Acciones.Cuantos]
Nombre=Cuantos
Boton=101
NombreDesplegar=Selección Actual
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=Informacion(e(<T>Selección Actual: <T>) +ListaConteo(ListaSeleccion(<T>Lista<T>)))
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Todo
Todo=Cuantos
Cuantos=Asignar
Asignar=Imprimir
Imprimir=Excel
Excel=Preliminar
Preliminar=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ContactoSubTipo
ContactoSubTipo=CampanaD.Contacto
CampanaD.Contacto=CampanaD.Situacion
CampanaD.Situacion=CampanaD.SituacionFecha
CampanaD.SituacionFecha=CampanaD.Calificacion
CampanaD.Calificacion=CampanaD.Observaciones
CampanaD.Observaciones=CampanaD.Usuario
CampanaD.Usuario=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalTodo
LocalTodo=LocalQuitar
LocalQuitar=(Fin)
