[Forma]
Clave=RHPlaza
Nombre=Plazas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=593
PosicionInicialArriba=407
PosicionInicialAltura=376
PosicionInicialAncho=741
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=349

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RHPlaza
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=25
FiltroEnOrden=S
FiltroTodoNombre=Todos
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroGrupo1=(Validaciones Memoria)
FiltroGrupo2=(Validaciones Memoria)
FiltroValida2=Puesto
FiltroAplicaEn2=RHPlaza.Puesto
FiltroTodo=S
FiltroAplicaEn=RHPlaza.Sucursal
FiltroValida1=Departamento
FiltroAplicaEn1=RHPlaza.Departamento
FiltroGeneral=RHPlaza.Empresa=<T>{Empresa}<T>

[Lista.RHPlaza.Departamento]
Carpeta=Lista
Clave=RHPlaza.Departamento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFuente=Negro
ColorFondo=Blanco

[Lista.RHPlaza.Puesto]
Carpeta=Lista
Clave=RHPlaza.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RHPlaza.Plazas]
Carpeta=Lista
Clave=RHPlaza.Plazas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RHPlaza.EnUso]
Carpeta=Lista
Clave=RHPlaza.EnUso
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Gris
ColorFondo=Blanco
Efectos=[Negritas]

[Lista.Vacantes]
Carpeta=Lista
Clave=Vacantes
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris
Efectos=[Negritas]

[Lista.Columnas]
Departamento=143
Puesto=147
Plazas=56
EnUso=64
Vacantes=59
Sucursal=48

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=Vacio(RHPlaza:RHPlaza.EnUso)

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Lista.RHPlaza.Sucursal]
Carpeta=Lista
Clave=RHPlaza.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=RHPlaza.Sucursal
RHPlaza.Sucursal=RHPlaza.Departamento
RHPlaza.Departamento=RHPlaza.Puesto
RHPlaza.Puesto=RHPlaza.Plazas
RHPlaza.Plazas=RHPlaza.EnUso
RHPlaza.EnUso=Vacantes
Vacantes=(Fin)
